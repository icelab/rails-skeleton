require "spec_helper"

RSpec.describe "db:sample_data" do
  include_context "rake"

  it "seeds the database with sample_data - `rake db:sample_data`" do
    expect { task.invoke }.to_not raise_error
  end
end

RSpec.describe "db:seed" do
  it "seeds the database with seed data - `rake db:seed`" do
    expect { Rails.application.load_seed }.to_not raise_error
  end
end
