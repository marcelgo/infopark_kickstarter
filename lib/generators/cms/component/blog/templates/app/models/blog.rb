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
end