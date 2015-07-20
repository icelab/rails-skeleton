class AssetTargetGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def copy_initializer_file
    copy_file "target.js", "assets/targets/#{file_name}/target.js"
    copy_file "index.js", "assets/targets/#{file_name}/index.js"
    copy_file "index.css", "assets/targets/#{file_name}/index.css"
  end
end
