class Notifications::AlsoCommentedLocationPost < Notification
  TRIGGER_KEY = 'location_post.comment'
  BITMASK = 2**6

  def self.receivers(activity)
    User.where(id: activity.trackable.comments.includes(:user).pluck(:user_id) - [activity.owner_id])
  end

  def self.description
    'Es gibt neue Antworten auf Inhalte die ich auch kommentiert habe'
  end

  def mail_vars
    {
      post_title: activity.trackable.title,
      post_url: graetzl_location_url(activity.trackable.graetzl, activity.trackable.author, anchor: ApplicationController.helpers.dom_id(activity.trackable), host: DEFAULT_URL_OPTIONS[:host]),
      comment_url: graetzl_location_url(activity.trackable.graetzl, activity.trackable.author, anchor: ApplicationController.helpers.dom_id(activity.trackable), host: DEFAULT_URL_OPTIONS[:host]),
      comment_content: activity.recipient.content.truncate(300, separator: ' '),
      owner_name: activity.owner.username,
      owner_url: user_url(activity.owner, DEFAULT_URL_OPTIONS),
      owner_avatar_url: Notifications::AvatarService.new(activity.owner).call
    }
  end

  def mail_subject
    'Neue Antwort bei Beitrag'
  end
end
