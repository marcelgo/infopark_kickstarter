class Blog < Obj
  include Page
  include Cms::Attributes::BlogEntryTruncation
  include Cms::Attributes::BlogDisqusShortname
  include Cms::Attributes::BlogEnableDisqusComments
  include Cms::Attributes::BlogEnableFacebookButton
  include Cms::Attributes::BlogEnableTwitterButton

  def blog
    self
  end

  def tags
    tags = self.entries.inject([]) do |tags, entry|
      tags += entry.tags
    end

    tags.uniq
  end

  def entries
    self.toclist.select {|obj| obj.is_a?(::BlogEntry)}
  end

  def entries_by_tag(tag)
    self.entries.inject([]) do |filtered, entry|
      if entry.tags.include?(tag)
        filtered << entry
      end

      filtered
    end
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