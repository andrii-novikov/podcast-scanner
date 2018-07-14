class PodcastScannerService
  REGEXP = /posts\/\d+\/\d+\/\d+\/podcast/.freeze
  SITEMAP_URL = 'https://www.rwpod.com/sitemap.xml'.freeze

  attr_reader :sitemap

  def initialize
    @sitemap = SitemapPage.new(SITEMAP_URL)
  end

  def call
    sitemap.locations.each { |location| process_podcast(location.text) }
  end

  private

  def process_podcast(podcast_url)
    return unless podcast_link?(podcast_url)

    podcast = PodcastPage.new(podcast_url)

    podcast.links.each do |link|
      title = podcast.title.text
      url = link['href']
      next if PodcastLink.exists_link?(title, url)

      page = Page.new(url)
      PodcastLink.create(title: title, link: url, content: page.body_text)
    end
  end

  def podcast_link?(link)
    link =~ REGEXP
  end
end