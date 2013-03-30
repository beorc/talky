class PostsMailer < ActionMailer::Base
  def send_notification_email(emails, options)
    @options = options
    @options[:post_url] = edit_post_url(options[:post_url_options])
    @options[:topic_url] = topic_url(options[:topic_url_options])

    subject = I18n.t('mailer.posts.subject')
    mail(to: emails, subject: subject)
  end
end
