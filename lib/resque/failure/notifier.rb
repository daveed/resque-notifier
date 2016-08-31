require 'uri'
require 'resque'
require 'net/http'

module Resque
  module Failure
    class Notifier < Base
      attr_accessor :error_class, :error_exception

      def initialize(exception, worker, queue, payload)
        @error_exception = (exception && exception.class).to_s
        @error_class     = (payload && payload['class']).to_s
        super
      end

      def save
        unless exception_logged_already?
          uri     = URI(ENV['RESQUE_HOOK'])
          payload = {channel:    ENV['RESQUE_CHANNEL'],
                     username:   "resque",
                     text:       text,
                     icon_emoji: ":ghost:"}.to_json
          Net::HTTP.post_form(uri, payload: payload)
        end
      end

      def exception_logged_already?
        count = 0
        failed_resque_jobs.each do |failed_job|
          break if count > 1
          if failed_job.include?(error_class) && failed_job.include?(error_exception)
            count += 1
          end
        end
        count > 1 ? true : false
      end

      def failed_resque_jobs
        Resque.redis.lrange("failed", 0, 1000)
      end

      def text
        "Worker: #{worker.to_s}       \n" +
        "Class: #{@error_class}        \n" +
        "Exception: #{@error_exception} \n" +
        "Error: #{exception.to_s}        \n"
      end

    end
  end
end
