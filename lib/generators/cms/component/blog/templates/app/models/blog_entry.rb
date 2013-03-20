class BlogEntry < Obj
  include Page

  include Cms::Attributes::BlogEntryTags
  include Cms::Attributes::BlogEntryAuthorId
  include Cms::Attributes::BlogEnableTwitterButton
  include Cms::Attributes::BlogEntryPublicationDate
  include Cms::Attributes::BlogEnableDisqusComments
  include Cms::Attributes::BlogEnableFacebookButton

  def truncation
    blog.entry_truncation
  end

  def blog
    parent.blog
  end

  def disqus_shortname
    blog.disqus_shortname
  end

  def author
    @author ||= user_manager.find_user(author_id)
  rescue UserManager::UserNotFound
    nil
  end

  # Overriden method from +Cms::Attributes::BlogEntryTags+.
  def tags
    super.split
  end

  # Overriden method from +Cms::Attributes::BlogEnableTwitterButton+.
  def enable_twitter_button?
    blog.enable_twitter_button? && super
  end

  # Overriden method from +Cms::Attributes::BlogEnableFacebookButton+.
  def enable_facebook_button?
    blog.enable_facebook_button? && super
  end

  # Overriden method from +include Cms::Attributes::BlogEnableDisqusComments+.
  def enable_disqus_comments?
    blog.enable_disqus_comments? && super
  end

  private

  def user_manager
    @user_manager ||= Rails.application.config.user_manager
  end
end