class TripJoinRequestNotification
  def self.notify_all(obj)
    NotifyRequesterJob.perform_later(obj)
    NotifyDriverJob.perform_later(obj)
  end
end
