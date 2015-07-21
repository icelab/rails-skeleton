module ApplicationHelper
  # Common helpers sit under lib/helpers
  include TextFormattingHelper

  def development_javascript
    return unless Rails.env.development?
    javascript_include_tag \
      "http://#{ENV['ASSETS_DEVELOPMENT_HOST']}:#{ENV['ASSETS_WEBPACK_PORT']}/webpack-dev-server.js",
      "data-turbolinks-track" => true
  end

end
