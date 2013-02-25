xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Your Blog Title"
    xml.description "A blog about software and chocolate"
    xml.link blog_url

    for entry in @entries
      xml.item do
        xml.title entry.title
        xml.description entry.body
        xml.pubDate Time.now
        xml.link cms_url(entry)
        xml.guid cms_url(entry)
      end
    end
  end
end