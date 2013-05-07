require 'rake'
require 'rake/tasklib'

require 'infopark_kickstarter/rake/credential_helper'

module InfoparkKickstarter
  module Rake
    class CmsTask < ::Rake::TaskLib
      include CredentialHelper

      def initialize
        namespace :cms do
          desc 'Reset the CMS'
          task reset: :environment do
            if yes?("Are you sure to reset the CMS '#{tenant_name}'?\nThe reset is not reversable and all content will be lost. (y|n)")
              reset(tenant_name)

              puts 'CMS resetted successfully.'
            end
          end
        end
      end

      private

      def reset(tenant_name)
        RailsConnector::CmsRestApi.delete('workspaces', {
          revision_id: RailsConnector::Workspace.default.revision_id,
          tenant_name: tenant_name
        })

        system('bundle exec rake tmp:cache:clear')
      end

      def yes?(text)
        puts text.to_s

        $stdin.gets.tap { |text| text.strip! if text }.to_s =~ /^y/
      end
    end
  end
end