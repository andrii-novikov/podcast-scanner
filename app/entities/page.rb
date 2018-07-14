class Page
  attr_reader :content, :response, :type

  PARSERS = { html: Nokogiri::HTML, xml: Nokogiri::XML }.freeze

  DEFAULT_TYPE = :html

  def self.default_type(type = nil)
    if type
      @default_type = type
    else
      @default_type || DEFAULT_TYPE
    end
  end

  def initialize(url)
    @type = type
    @response = HttpClient.get(url)
    @content = parser.parse(response.body)

    after_load
  end


  def body_text
    html_page = content.css('body')
    html_page.css('script').remove
    html_page.css('style').remove
    Sanitize.clean(html_page).gsub(/\R+/, '')
  end

  private

  def after_load

  end

  def parser
    PARSERS[self.class.default_type]
  end
end