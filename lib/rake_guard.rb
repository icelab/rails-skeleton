module RakeGuard
  def self.configure
    @config ||= OpenStruct.new
    yield @config if block_given?
    @config
  end

  def self.config
    @config
  end

  def self.enabled?
    config.enabled || false
  end

  def self.tasks_to_guard
    config.tasks_to_guard || []
  end
end
