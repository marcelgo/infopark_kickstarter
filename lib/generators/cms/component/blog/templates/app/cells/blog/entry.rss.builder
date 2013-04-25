xml.item do
  xml.title @entry.headline
  xml.pubDate @entry.valid_from.to_s(:rfc822)
  xml << render(state: :snippet)
  xml.link cms_url(@entry)
  xml.guid cms_url(@entry)
end