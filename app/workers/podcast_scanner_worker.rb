class PodcastScannerWorker
  include Sidekiq::Worker

  def perform
    PodcastScannerService.new.call
  end
end