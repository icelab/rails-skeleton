class AssetTargetGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  def copy_initializer_file
    target_name = file_name.dasherize
    copy_file "target.js", "assets/targets/#{target_name}/target.js"
    copy_file "index.js",  "assets/targets/#{target_name}/index.js"
    copy_file "index.css", "assets/targets/#{target_name}/index.css"
  end
end
