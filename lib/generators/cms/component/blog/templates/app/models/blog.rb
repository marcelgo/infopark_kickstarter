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
    tags = entries.inject([]) do |tags, entry|
      tags += entry.tags
    end

    tags.uniq
  end

  def entries
    @entries ||= toclist.select do |obj|
      obj.is_a?(::BlogEntry)
    end
  end
end