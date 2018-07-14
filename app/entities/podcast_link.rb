class PodcastLink
  include Elasticsearch::Persistence::Model

  attribute :title,  String
  attribute :link,  String
  attribute :content,  String

  def initialize(attrs)
    attrs[:id] ||= self.class.generate_id(attrs[:title], attrs[:link])
    super
  end

  class << self
    def generate_id(title, link)
      Digest::SHA1.hexdigest([title, link].join)
    end

    def exists_link?(title, link)
      exists?(generate_id(title, link))
    end
  end
end