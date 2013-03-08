class Blog < Obj
  include Page
  include Cms::Attributes::BlogEntryTruncation
  include Cms::Attributes::BlogDisqusShortname
  include Cms::Attributes::BlogEneableDisqusComments
  include Cms::Attributes::BlogEneableFacebookButton
  include Cms::Attributes::BlogEneableTwitterButton

  def blog
    self
  end

  def tags
    tags = []
    self.entries.map { |entry|
      tags += (entry.tags)
    }

    tags.uniq
  end

  def entries
    self.toclist.select {|obj| obj.is_a?(::BlogEntry)}
  end

  def entries_by_tag(tag)
    filtered_entries = []

    self.entries.each { |entry|
      filtered_entries << entry if entry.include?(tag)
    }

    filtered_entries
  end

  def enable_twitter_button?
    self.blog_enable_twitter_button?
  end

  def enable_facebook_button?
    self.blog_enable_facebook_button?
  end

  def disqus_shortname
    self.blog_disqus_shortname
  end

  def enable_disqus_comments?
    self.blog_enable_disqus_comments?
  end

  def entry_truncation
    if self.blog_entry_truncation.to_i <= 0
      @entry_truncation = 500
    end

    @entry_truncation ||= self.blog_entry_truncation.to_i
  end
end