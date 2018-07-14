class PodcastPage < Page
  TITLE_SELECTOR = '.content h1'
  LINK_SELECTOR = '.content ul li a[href^=http]'

  def title
    @title ||= content.search(TITLE_SELECTOR)
  end

  def links
    @links ||= content.search(LINK_SELECTOR)
  end
end