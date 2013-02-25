class BlogEntry < Obj
  include Page
  include Cms::Attributes::BlogEntryTags
  include Cms::Attributes::BlogEntryAuthorId
  include Cms::Attributes::BlogEntryPublicationDate

  def truncated_body
    if self.body.length > truncation
      "#{self.body[0..truncation]}..."
    else
      self.body
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
end