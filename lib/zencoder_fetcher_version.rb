module ZencoderFetcher
  FETCHER_VERSION = [0,2,8] unless defined?(FETCHER_VERSION)

  def self.version
    FETCHER_VERSION.join(".")
  end
end

