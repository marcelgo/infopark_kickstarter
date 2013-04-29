class BlogEntry < Obj
  include Page

  cms_attribute :headline, type: :string
  cms_attribute :author, type: :string

  def blog
    parent.blog
  end

  def disqus_shortname
    blog.disqus_shortname
  end

  def enable_comments?
    true
  end

  # Override auto-generated method +author+ from +CmsAttribute+.
  def author
    author = self[:author] || ''

    if author.present?
      @author ||= Infopark::Crm::Contact.search(params: { login: author }).first
      @author ||= Infopark::Crm::Contact.search(params: { email: author }).first
    end
  end
end