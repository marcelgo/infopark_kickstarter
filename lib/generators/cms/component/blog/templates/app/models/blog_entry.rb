class BlogEntry < Obj
  include Page
  include Cms::Attributes::BlogEntryTags
  include Cms::Attributes::BlogEntryAuthorId
  include Cms::Attributes::BlogEntryPublicationDate
  include Cms::Attributes::BlogEnableTwitterButton
  include Cms::Attributes::BlogEnableDisqusComments
  include Cms::Attributes::BlogEnableFacebookButton

  def truncation
    blog.entry_truncation
  end

  def blog
    parent.blog
  end

  def author
    @author ||= Rails.application.config.user_manager.find_user(author_id)
  rescue UserManager::UserNotFound
    nil
  end

  # overriden methode of concerns/cms/attributes/blog_entry_tags.rb
  def tags
    super.split
  end

  # overriden methode of concerns/cms/attributes/blog_enable_twitter_button.rb
  def enable_twitter_button?
    blog.enable_twitter_button? && super
  end

  # overriden methode of concerns/cms/attributes/blog_enable_facebook_button.rb
  def enable_facebook_button?
    blog.enable_facebook_button? && super
  end

  # overriden methode of concerns/cms/attributes/blog_enable_disqus_comments.rb
  def enable_disqus_comments?
    blog.enable_disqus_comments? && super
  end
end