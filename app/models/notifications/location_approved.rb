class Notifications::LocationApproved < Notification

  TRIGGER_KEY = 'location.approve'
  BITMASK = 2048

  def self.receivers(activity)
    activity.trackable.users
  end

  def mail_vars
    {
      owner_name: activity.owner.username,
      owner_url: user_url(activity.owner, DEFAULT_URL_OPTIONS),
      owner_avatar_url: ApplicationController.helpers.attachment_url(activity.owner, :avatar, :fill, 40, 40, fallback: "avatar/user/40x40.png", host: "http://#{DEFAULT_URL_OPTIONS[:host]}"),
      location_name: activity.trackable.name,
      location_url: graetzl_location_url(activity.trackable.graetzl, activity.trackable, DEFAULT_URL_OPTIONS)
    }
  end

  def mail_subject
    'Deine Location wurde freigeschalten'
  end
end
