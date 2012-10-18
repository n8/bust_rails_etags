require "bust_rails_etags/version"

module BustRailsEtags
  extend ActiveSupport::Concern

  included do
    alias_method_chain :etag=, :version_id
  end

  private
    def etag_with_version_id=(etag)

      etag_elements = []
      etag_elements << ENV['ETAG_VERSION_ID']

      if etag.is_a?(Array)
         etag_elements += etag
      else
        etag_elements << etag
      end
    
      self.etag_without_version_id = etag_elements
    end

  class Railtie < Rails::Railtie
    initializer "etag_version_ids.initialize" do |app|
      ActionDispatch::Response.class_eval do
        include BustRailsEtags
      end
    end
  end
end
