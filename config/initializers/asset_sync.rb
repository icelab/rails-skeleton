if %w(REGION BUCKET ACCESS_KEY_ID SECRET_ACCESS_KEY).all? { |k| ENV["ASSETS_AWS_#{k}"].present? }
  AssetSync.configure do |config|
    config.fog_provider          = "AWS"
    config.fog_region            = ENV["ASSETS_AWS_REGION"]
    config.fog_directory         = ENV["ASSETS_AWS_BUCKET"]
    config.aws_access_key_id     = ENV["ASSETS_AWS_ACCESS_KEY_ID"]
    config.aws_secret_access_key = ENV["ASSETS_AWS_SECRET_ACCESS_KEY"]

    # To use AWS reduced redundancy storage.
    # config.aws_reduced_redundancy = true

    # Invalidate a file on a cdn after uploading files.
    # config.cdn_distribution_id = "12345"
    # config.invalidate = ['file1.js']

    # Don't delete files from the store.
    # config.existing_remote_files = "keep"

    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true

    # Use the Rails generated 'manifest.yml' file to produce the list of files to
    # upload instead of searching the assets directory.
    # config.manifest = true

    # Fail silently.  Useful for environments such as Heroku.
    config.fail_silently = true
  end
end
