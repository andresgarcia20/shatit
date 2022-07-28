require "./app/services/InvalidStageChange"

class TripJoinRequestStageManager
  REQUESTER = 1
  def self.accept!(trip_request)
    if trip_request.requested?
      trip = trip_request.trip
      new_seats = trip.available_seats - (trip_request.companions + REQUESTER)
      trip.update_column(:available_seats, new_seats)
      new_pets = trip.pets - trip_request.pets
      trip.update_column(:pets, new_pets)

      user_overlapping_requests = trip_request.user.trip_join_requests.by_stage_requested.where("trip_join_requests.id != #{trip_request.id}").by_trip_date(trip.departure_date)
      user_overlapping_requests.map(&:rejected!)

      all_trip_requests = trip.trip_join_requests.by_stage_requested.where("trip_join_requests.id != #{trip_request.id}")
      all_trip_requests.map do |each_request|
        total_seats = new_seats - (each_request.companions + REQUESTER)
        total_pets = new_pets - each_request.pets
        if total_seats < 0 || total_pets < 0 || trip.luggage > trip_request.luggage
          each_request.rejected!
        end
      end

      trip_request.accepted!
    else
      raise InvalidStageChange
    end
  end

  def self.payment_in_progress!(trip_request)
    if trip_request.accepted?
      trip_request.payment_in_progress!
    else
      raise InvalidStageChange
    end
  end

  def self.paid!(trip_request)
    if trip_request.payment_in_progress?
      trip_request.paid!
    else
      raise InvalidStageChange
    end
  end

  def self.reject!(trip_request)
    if trip_request.requested?
      trip_request.rejected!
    else
      raise InvalidStageChange
    end
  end

  def self.canceled!(trip_request)
    trip_request.canceled!
  end
end
