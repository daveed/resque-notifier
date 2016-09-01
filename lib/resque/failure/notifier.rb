require "uri"
require "resque"
require "net/http"
require "env_resque"

module Resque
  module Failure
    class Notifier < Base

      include EnvResque

      def save
        return unless haz_required_envs?
        unless exception_logged_already?
          uri     = URI(env_resque_hook)
          payload = {
            channel:    env_resque_channel,
            username:   "resque",
            text:       text,
            icon_emoji: ":ghost:"
          }.to_json
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
        "Worker: #{worker.to_s}      \n" \
        "Class: #{link_to_class}      \n" \
        "Exception: #{error_exception} \n" \
        "Error: #{exception.to_s}       \n"
      end

      def link_to_class
        if haz_env_resque_host?
          "#{env_resque_host}/resque/failed/?class=#{error_class}"
        else
          error_class
        end
      end

      def error_exception
        (exception && exception.class).to_s
      end

      def error_class
        (payload && payload["class"]).to_s
      end

    end
  end
end
