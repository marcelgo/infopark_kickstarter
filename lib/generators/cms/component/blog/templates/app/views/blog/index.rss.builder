xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title @obj.title
    xml.description @obj.description
    xml.link cms_url(@obj)

    for entry in @entries
      xml.item do
        xml.title entry.title
        xml.pubDate entry.valid_from.to_date
        xml.link cms_url(entry)
        xml.guid cms_url(entry)
      end
    end
  end
end