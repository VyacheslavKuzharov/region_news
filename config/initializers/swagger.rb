class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    # Make a distinction between the APIs and API documentation paths.
    "apidocs/#{path}"
  end
end


Swagger::Docs::Config.register_apis({
    "1.0" => {
        # the extension used for the API
        :api_extension_type => :json,
        # the output location where your .json files are written to
        :api_file_path => "public/apidocs",
        # the URL base path to your API
        :base_path => Rails.env.production? ? ENV['prod_url'] : 'http://localhost:3000',
        # if you want to delete all .json files at each generation
        :clean_directory => true,
        # add custom attributes to api-docs
        :attributes => {
            :info => {
                "title" => "Swagger Sample App",
                "description" => "This is a sample description.",
                "termsOfServiceUrl" => "http://helloreverb.com/terms/",
                "contact" => "apiteam@wordnik.com",
                "license" => "Apache 2.0",
                "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
            }
        }
    }
})