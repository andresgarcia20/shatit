class CheckoutCardsController < ApplicationController
  def create
    product = TripJoinRequest.find(params[:trip_join_request_id])
    trip = Trip.find(params[:trip_id])

    @session = Stripe::Checkout::Session.create({
      success_url: trip_trip_join_request_url(trip_id: trip.id, id: product.id),
      cancel_url: root_url,
      line_items: [{
        price_data: { unit_amount: trip.trip_price,
                     currency: "eur",
                     product_data: { name: "#{trip.origin} - #{trip.destinations.last}",
                                     metadata: { trip: trip.id } } },
        quantity: 1,
      }],
      metadata: { trip_request: product.id },
      mode: "payment",
    })

    respond_to do |format|
      format.js
    end
  end
end
