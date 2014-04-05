# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# Redirect to the canonical hostname.
use Rack::CanonicalHost, ENV["HOSTNAME"] if ENV["HOSTNAME"]

run Rails.application
