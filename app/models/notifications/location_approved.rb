class Notifications::LocationApproved < Notification

  TRIGGER_KEY = 'location.approve'
  BITMASK = 1024
  # approve_of_location: {
  #   triggered_by_activity_with_key: 'location.approve',
  #   bitmask: 1024,
  #   receivers: ->(activity) { activity.trackable.users }
  # }

  # TRIGGER_KEY = 'meeting.create'
  # BITMASK = 1 #TODO autosave right bitmask attribute for new records...
  #
  #
  #
  def self.receivers(activity)
    activity.trackable.users
  end
  #
  #
  # def self.condition(activity)
  #   true
  # end
end
