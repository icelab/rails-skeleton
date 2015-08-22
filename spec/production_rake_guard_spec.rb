require 'spec_helper'

RSpec.describe 'db:reset' do
  include_context 'rake'

  before(:all) do
    RakeGuard.configure do |config|
      config.tasks_to_guard = ['db:reset']
      config.enabled = true
    end
  end

  it 'fails in production when rake guard is enabled' do
    silence_stream(STDOUT) do # silencing our console warning
      expect { task.invoke }.to raise_error(SystemExit)
    end
  end

  it 'succeeds in production when force="true" is set' do
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with('force').and_return('true')
    silence_stream(STDOUT) do # silencing our console warning
      expect { task.invoke }.not_to raise_error
    end
  end
end
