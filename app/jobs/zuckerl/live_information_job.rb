class Zuckerl::LiveInformationJob < ActiveJob::Base
  queue_as :default

  def perform(zuckerl)
    Rails.logger.info "BookingConfirmationJob start at: #{Time.now}"
    ActiveRecord::Base.connection_pool.with_connection do
      mandrill_mail = Zuckerl::LiveInformation.new zuckerl
      mandrill_mail.deliver
    end
  end
end
