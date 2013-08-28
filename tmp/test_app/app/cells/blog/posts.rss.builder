xml.instruct! :xml, :version => '1.0'

xml.rss :version => '2.0' do
  xml.channel do
    xml.title @blog.headline
    xml.description @blog.description
    xml.link cms_url(@blog)

    for post in @posts
      xml << render({ state: :post }, post)
    end
  end
end