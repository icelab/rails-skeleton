class ApplicationResponder < ActionController::Responder
  # Set the flash message using i18n values, based on the controller action
  # and resource status.
  include Responders::FlashResponder

  # Automatically add Last-Modified headers to API requests.
  include Responders::HttpCacheResponder

  # Allow callable objects as the `respond_with` redirect location.
  include Responders::LocationResponder

  # Uncomment this responder if you want your resources to redirect to the collection
  # path (index action) instead of the resource path for POST/PUT/DELETE requests.
  # include Responders::CollectionResponder
end
