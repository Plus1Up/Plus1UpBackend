Apipie.configure do |config|
  config.app_name                = "Plus1UPBackend"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apidoc"
  config.default_locale          = nil
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.default_version         = "0.1"
  config.app_info                = "Documentation for backend side of Plus 1UP project."
  config.validate                = false
end
