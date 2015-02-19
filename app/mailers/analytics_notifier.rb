class AnalyticsNotifier < ActionMailer::Base
  default from: "socialyzeio@gmail.com"

  def send_data_ready_email(user)
    @user = user
    mail( :to => @user.email,
      :subject => 'Your Socialytics are ready!')
  end
end
