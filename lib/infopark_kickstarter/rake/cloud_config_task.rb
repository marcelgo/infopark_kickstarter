require 'rake'
require 'rake/tasklib'
require 'rest_client'

require 'infopark_kickstarter/rake/credential_helper'

module InfoparkKickstarter
  module Rake
    class CloudConfigTask < ::Rake::TaskLib
      include CredentialHelper

      def initialize
        namespace :cms do
          namespace :cloud_config do
            desc 'Edit the cloud config as stored in the Infopark console'
            task :edit => :environment do
              edit
            end

            desc 'Download the cloud config from the Infopark console to edit it locally'
            task :download => :environment do
              download
            end

            desc 'Upload the edited cloud config to the Infopark console'
            task :upload => :environment do
              upload
            end
          end
        end
      end

      private

      def edit
        download

        if editor?
          sh("#{ENV['EDITOR']} #{config_path}", verbose: false)

          upload
        else
          puts 'No $EDITOR specified.'
          puts "Edit #{config_path}"
          puts 'Finally upload with rake cms:cloud_config:upload'
        end
      end

      def editor?
        ENV['EDITOR'].to_s != ''
      end

      def download
        config = begin
          RestClient.get("#{url}/cloud_config", params: { token: api_key })
        rescue RestClient::InternalServerError
          puts 'Aborted. Cloud config could not be loaded.'
          puts 'Please make sure that you have at least one live server configured.'

          exit
        end

        config = MultiJson.load(config)

        save_config(config.to_json)
      end

      def upload
        config = load_config

        puts pretty_print(config.to_json)

        if yes?('Upload this config to the Infopark console? [yn]')
          puts 'Uploading...'

          upload_config(config)
        else
          puts 'Aborted. Custom cloud configuration not uploaded.'
        end
      rescue MultiJson::LoadError => e
        puts "ERROR: #{config_path} contains syntax errors. Please fix."
        puts "Edit #{config_path}"
        puts "Finally upload with rake cms:cloud_config:upload"
      end

      def load_config
        json = File.read(config_path)

        MultiJson.load(json)
      end

      def save_config(config)
        json = pretty_print(config)

        File.write(config_path, json)
      end

      def upload_config(config)
        endpoint = "#{url}/cloud_config"

        data = {
          token: api_key,
          cloud_config: config,
        }.to_json

        options = {
          content_type: :json,
          accept: :json,
        }

        RestClient.put(endpoint, data, options)

        backup
      end

      def backup
        puts "Local backup: #{config_backup_path}"

        cp(config_path, config_backup_path, verbose: false)
      end

      def pretty_print(json)
        config = MultiJson.load(json)

        # TODO MultiJson does not output pretty printed JSON under Ruby 1.9, so we use
        # JSON.pretty_generate instead.
        # MultiJson.dump(config, pretty: true)
        JSON.pretty_generate(config)
      end

      def config_path
        @config_path ||= Rails.root + 'tmp/cloud_config.json'
      end

      def config_backup_path
        @config_backup_path ||= "#{config_path}-#{current_time}"
      end

      def current_time
        Time.now.strftime('%Y%m%d%H%M')
      end

      def yes?(text)
        puts text.to_s

        $stdin.gets.tap { |text| text.strip! if text }.to_s =~ /^y/
      end
    end
  end
end