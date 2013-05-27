base_url = request.protocol + request.host_with_port

xml.instruct!

xml.urlset(xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9') do
  for obj in @objects do
    xml.url do
      xml.loc(base_url, cms_path(obj))
      xml.lastmod(obj.last_changed.present? ? obj.last_changed.strftime('%Y-%m-%d') : nil)
      xml.changefreq('weekly')
      xml.priority(1.0).to_s
    end
  end
end