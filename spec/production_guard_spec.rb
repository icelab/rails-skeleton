require 'spec_helper'

RSpec.describe 'db:schema:load' do
  include_context 'rake'

  it 'fails in production' do
    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
    silence_stream(STDOUT) do # silencing our console warning
      expect { task.invoke }.to raise_error(SystemExit)
    end
  end

  it 'succeeds in production when force="true" is set' do
    allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
    allow(ENV).to receive(:[])
    allow(ENV).to receive(:[]).with('force').and_return('true')
    silence_stream(STDOUT) do # silencing our console warning
      expect { task.invoke }.not_to raise_error
    end
  end
end
