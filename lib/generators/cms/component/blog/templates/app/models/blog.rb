class Blog < Obj
  include Page
  include Cms::Attributes::BlogEntryTruncation

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
      filtered_entries << entry if entry.has_tag?(tag)
    }

    filtered_entries
  end

  def entry_truncation
    if self.blog_entry_truncation.to_i <= 0
      @entry_truncation = 500
    end

    @entry_truncation ||= self.blog_entry_truncation.to_i
  end
end