# FacebookでOAuth認証した際の画像取り込み不具合を修正
# Required: gem 'open_uri_redirections'

require 'open-uri'
require 'paperclip/media_type_spoof_detector'

module Paperclip

  class UriAdapter < AbstractAdapter
    def download_content
      open(@target, allow_redirections: :all)
    end
  end

  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end

end
