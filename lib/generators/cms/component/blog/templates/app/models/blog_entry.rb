class BlogEntry < Obj
  include Page
  include Cms::Attributes::BlogEntryTags
  include Cms::Attributes::BlogEntryAuthorId
  include Cms::Attributes::BlogEntryPublicationDate
  include Cms::Attributes::BlogEntryEnableTwitterButton
  include Cms::Attributes::BlogEntryEnableDisqusComments
  include Cms::Attributes::BlogEntryEnableFacebookButton

  def preview
    text = first_text_box.body || ''
    text.truncate(blog.entry_truncation)
  end

  def blog
    parent.blog
  end

  def publish_date
    blog_entry_publication_date
  end

  def tags
    blog_entry_tags.split
  end

  def author_id
    blog_entry_author_id
  end

  def author
    @author ||= Rails.application.config.user_manager.find_user(author_id)
  rescue UserManager::UserNotFound
    nil
  end

  def author_name
    if author.present?
      [
        author.first_name,
        author.last_name
      ].compact.join(' ')
    else
      ''
    end
  end

  def author_email
    author.try(:email)
  end

  def enable_twitter_button?
    blog.enable_twitter_button? && blog_entry_enable_twitter_button?
  end

  def enable_facebook_button?
    blog.enable_facebook_button? && blog_entry_enable_facebook_button?
  end

  def enable_disqus_comments?
    blog.enable_disqus_comments? && blog_entry_enable_disqus_comments?
  end

  def disqus_shortname
    blog.disqus_shortname
  end

  def first_text_box
    boxes.detect do |box|
      box.is_a?(BoxText)
    end
  end
end