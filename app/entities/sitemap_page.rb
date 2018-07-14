class SitemapPage < Page
  default_type(:xml)

  def after_load
    content.remove_namespaces!
  end

  def locations
    content.xpath('//url/loc')
  end
end