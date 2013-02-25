class UserImageService

  def image_path(user_id)
    contact = user_manager.find_user(user_id)
    gravatar_image(contact)
  rescue UserManager::UserNotFound
    gravatar_default_image
  end

  private
  def user_manager
    @user_manager ||= Rails.application.config.user_manager
  end

  def gravatar_image(contact)
    email = contact.email.to_s.downcase
    gravatar_url(email)
  end

  def gravatar_url(email)
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end

  def gravatar_default_image
    gravatar_url('')
  end

end