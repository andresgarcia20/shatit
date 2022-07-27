class TripJoinRequestStageManager
  REQUESTER = 1
  def self.accept!(req)
    if req.requested?
      trip = req.trip
      seats = trip.available_seats - (req.companions + REQUESTER)
      trip.update_column(:available_seats, seats)

      req.accepted!
    else
      raise "Invalid stage"
    end
  end

  def self.payment_in_progress!(req)
    if req.accepted?
      req.payment_in_progress!
    else
      raise "Invalid stage"
    end
  end

  def self.paid!(req)
    if req.payment_in_progress?
      req.paid!
    else
      raise "Invalid stage"
    end
  end

  def self.reject!(req)
    if req.requested?
      req.rejected!
    else
      raise "Invalid stage"
    end
  end
end
