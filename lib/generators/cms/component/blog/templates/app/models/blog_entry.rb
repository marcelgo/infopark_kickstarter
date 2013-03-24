class BlogEntry < Obj
  include Page

  include Cms::Attributes::BlogEntryAuthor

  def blog
    parent.blog
  end

  def disqus_shortname
    blog.disqus_shortname
  end

  def enable_comments?
    true
  end
end