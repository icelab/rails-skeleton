require 'spec_helper'

RSpec.describe RakeGuard do
  describe '#enabled?' do
    it 'should return true if in production mode' do
      RakeGuard.configure do |config|
        config.enabled = true
      end
      expect(RakeGuard.enabled?).to be true
    end

    it 'should return false if not in production mode' do
      RakeGuard.configure do |config|
        config.enabled = false
      end
      expect(RakeGuard.enabled?).to be false
    end
  end

  describe '#tasks_to_guard' do
    tasks = ['db:drop', 'db:reset']

    it 'should return a list of guarded tasks' do
      RakeGuard.configure do |config|
        config.tasks_to_guard = tasks
      end
      expect(RakeGuard.tasks_to_guard).to eq tasks
    end
  end
end
