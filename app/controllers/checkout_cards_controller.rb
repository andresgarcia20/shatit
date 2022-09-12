class CheckoutCardsController < ApplicationController
  def create
    product = TripJoinRequest.find(params[:id])
    trip = Trip.find(params[:trip_id])

    @session = Stripe::Checkout::Session.create({
      success_url: "https://example.com/success",
      cancel_url: "https://example.com/cancel",
      line_items: [
        { name: trip.id,
          amount: trip.trip_price,
          trip_request: product.id,
          currency: "euro",
          quantity: 1 },
      ],
      mode: "payment",
    })

    binding.pry
  end
end
