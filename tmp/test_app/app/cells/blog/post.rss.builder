xml.item do
  xml.title @post.headline
  xml.pubDate @post.valid_from.to_s(:rfc822)
  xml << render(state: :snippet)
  xml.link cms_url(@post)
  xml.guid cms_url(@post)
end