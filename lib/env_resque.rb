require "core_ext/string"

module EnvResque

  def env_resque_channel
    ENV["RESQUE_CHANNEL"]
  end

  def env_resque_hook
    ENV["RESQUE_HOOK"]
  end

  def env_resque_host
    ENV["RESQUE_HOST"]
  end

  def haz_env_resque_host?
    !env_resque_host.blank?
  end

  def haz_required_envs?
    !env_resque_channel.blank? && !env_resque_hook.blank?
  end

end
