require 'resque'
require 'uri'
require 'net/http'

module Resque
  module Failure
    class Notifier < Base

      def save
        uri     = URI(ENV['RESQUE_HOOK'])
        payload = { channel:    ENV['RESQUE_CHANNEL'],
                   username:   "resque",
                   text:       "text",
                   icon_emoji: ":ghost:"}.to_json
        Net::HTTP.post_form(uri, payload: payload)
      end

    end

  end
end
