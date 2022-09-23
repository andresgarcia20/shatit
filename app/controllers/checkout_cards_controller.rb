class CheckoutCardsController < ApplicationController
  before_action :set_trip_join_request, only: %i[stripe_session_params]
  before_action :set_trip, only: %i[stripe_session_params]

  def create
    redirect_to stripe_session.url, allow_other_host: true
  end

  private

  def stripe_session
    Stripe::Checkout::Session.create(stripe_session_params)
  end

  def stripe_session_params
    {
      line_items: [{
        price_data: { unit_amount: "#{trip.trip_price}00",
                      currency: "eur",
                      product_data: { name: "#{trip.origin} - #{trip.destinations.last}" } },
        quantity: 1,
      }],
      metadata: { trip_request: trip_join_request.id,
                  trip: trip.id },
      mode: "payment",
      success_url: trip_trip_join_request_url(trip_id: trip.id, id: trip_join_request.id),
      cancel_url: root_url,
    }
  end

  def trip_join_request
    TripJoinRequest.find(params[:trip_join_request_id])
  end

  def trip
    Trip.find(params[:trip_id])
  end
end
