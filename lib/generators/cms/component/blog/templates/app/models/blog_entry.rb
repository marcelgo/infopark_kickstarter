class BlogEntry < Obj
  include Page
  include Cms::Attributes::BlogEntryTags
  include Cms::Attributes::BlogEntryAuthorId
  include Cms::Attributes::BlogEntryPublicationDate
  include Cms::Attributes::BlogEntryEneableTwitterButton
  include Cms::Attributes::BlogEntryEneableDisqusComments
  include Cms::Attributes::BlogEntryEneableFacebookButton

  def preview
    text = first_text_box.body || ''

    if text.length > truncation
      "#{text[0..truncation]}..."
    else
      text
    end
  end

  def truncation
    self.blog.entry_truncation
  end

  def blog
    self.parent
  end

  def publish_date
    self.blog_entry_publication_date
  end

  def tags
    tags = []
    tags_string = self.blog_entry_tags

    tags_string.scan(/"{1}[a-zA-Z\s\w]*"{1}/) {|m|
      tags << m[1..-2]
    }

    tags
  end

  def has_tag?(tag)
    self.tags.include?(tag)
  end

  def author_id
    self.blog_entry_author_id
  end

  def author
    @user_manager ||= Rails.application.config.user_manager
    @user ||= @user_manager.find_user(self.author_id)
  rescue UserManager::UserNotFound
    nil
  end

  def author_name
    if self.author.present?
      "#{self.author.first_name} #{self.author.last_name}"
    else
      ''
    end
  end

  def author_email
    self.author.try(:email)
  end

  def eneable_twitter_button?
    self.blog.eneable_twitter_button? && self.blog_entry_eneable_twitter_button?
  end

  def eneable_facebook_button?
    self.blog.eneable_facebook_button? && self.blog_entry_eneable_facebook_button?
  end

  def eneable_disqus_comments?
    self.blog.eneable_disqus_comments? && self.blog_entry_eneable_disqus_comments?
  end

  def disqus_shortname
    self.parent.disqus_shortname
  end

  def first_text_box
    self.boxes.each { |child|
      return child if child.class.eql?(BoxText)
    }
  end
end