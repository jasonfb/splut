
require 'rails/generators'

module Splut
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    desc "Creates a Splut Initializer"

    source_root File.expand_path('../templates', __dir__)

    def self.next_migration_number(path)
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    end

    desc "Creates an initializer for Splut and copy files to your application."
    def create_splut_migration
      migration_template "create_splut_tables.rb",  "db/migrate/create_splut_tables.rb"
    end

    def migration_version
      "[#{ActiveRecord::Migration.current_version}]" if ActiveRecord::Migration.respond_to?(:current_version)
    end
  end
end


