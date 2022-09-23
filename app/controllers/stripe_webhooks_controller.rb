class StripeWebhooksController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    endpoint_secret = ENV["STRIPE_WEBHOOK_TEST"]
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      status 400
      return
    end

    # Handle the event
    case event.type
    when "payment_intent.succeeded"
      session = event.data.object
      checkout_session = Stripe::Checkout::Session.list({ limit: 1 }).data[0]
      trip_request_id = checkout_session.metadata.trip_request

      return handle_trip_request(trip_request_id)
    else
      puts "Unhandled event type: #{event.type}"
    end
  end

  private

  def handle_trip_request(trip_request_id)
    trip_request = TripJoinRequest.find(trip_request_id)

    if TripJoinRequestStageManager.paid!(trip_request)
      TripJoinRequestNotification.notify(trip_request)
    end
  end
end
