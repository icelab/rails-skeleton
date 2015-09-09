require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#development_javascript" do
    it "points to the local webpack server using ENV vars" do
      allow(ENV).to receive(:[]).with("ASSETS_DEVELOPMENT_HOST").and_return "localhost"
      allow(ENV).to receive(:[]).with("ASSETS_WEBPACK_PORT").and_return "8080"

      expect(helper.development_javascript).to eq \
        '<script src="http://localhost:8080/webpack-dev-server.js" data-turbolinks-track="true"></script>'
    end
  end
end
