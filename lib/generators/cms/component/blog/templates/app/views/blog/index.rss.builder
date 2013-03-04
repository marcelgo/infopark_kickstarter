xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @blog.title
    xml.description @blog.body
    xml.link blog_url

    for entry in @entries
      xml.item do
        xml.title entry.title
        xml.description entry.preview
        xml.pubDate Time.now
        xml.link cms_url(entry)
        xml.guid cms_url(entry)
      end
    end
  end
end