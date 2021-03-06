class Notifications::CommentOnRoomOffer < Notification
  TRIGGER_KEY = 'room_offer.comment'
  BITMASK = 2**4

  def self.receivers(activity)
    User.where(id: activity.trackable.user_id)
  end

  def self.description
    "Meine erstellten Inhalte wurden kommentiert"
  end

  def mail_vars
    {
      room_title: activity.trackable.slogan,
      room_url: room_offer_url(activity.trackable, DEFAULT_URL_OPTIONS),
      room_type: I18n.t("activerecord.attributes.room_offer.offer_types_active.#{activity.trackable.offer_type}"),
      room_description: activity.trackable.room_description,
      comment_url: room_offer_url(activity.trackable, DEFAULT_URL_OPTIONS),
      comment_content: activity.recipient.content.truncate(300, separator: ' '),
      owner_name: activity.owner.username,
      owner_url: user_url(activity.owner, DEFAULT_URL_OPTIONS),
      owner_avatar_url: Notifications::AvatarService.new(activity.owner).call
    }
  end

  def mail_subject
    "Neuer Kommentar bei Raumteiler"
  end
end
