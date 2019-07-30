class AocMailerPreview < ActionMailer::Preview
  def welcome_email
    @invited = User.second
    @host = User.first

    AocMailer.notify_invitation(@invited, @host)
  end
end