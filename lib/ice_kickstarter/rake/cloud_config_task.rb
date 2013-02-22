require 'rake'
require 'rake/tasklib'

require 'ice_kickstarter/rake/credential_helper'

module IceKickstarter
  module Rake
    class CloudConfigTask < ::Rake::TaskLib
      include CredentialHelper

      def initialize
        namespace :cms do
          namespace :cloud_config do

            desc "Edit the cloud config as stored in the ICE Konsole"
            task :edit => :environment do
              edit
            end

            desc "Download the cloud config from the ICE Konsole to edit it locally"
            task :download => :environment do
              download
            end

            desc "Upload the edited cloud config to the ICE Konsole"
            task :upload => :environment do
              upload
            end

          end
        end
      end

      private

      def edit
        download
        if ENV["EDITOR"].to_s != ""
          sh "#{ENV["EDITOR"]} #{config_path}", verbose: false
          upload
        else
          puts "No $EDITOR specified."
          puts "Edit #{config_path}"
          puts "Finally upload with rake cms:cloud_config:upload"
        end
      end

      def download
        config = RestClient.get("#{url}/cloud_config", params: {token: api_key})
        save_config(config)
      end

      def upload
        config = load_config
        puts config

        if yes?("Upload this config to the ICE Konsole? [yn]")
          puts "Uploading..."
          config_and_token = {
            token: api_key,
            cloud_config: config,
          }
          RestClient.put("#{url}/cloud_config", config_and_token.to_json, content_type: :json, accept: :json)

          puts "Local backup: #{config_backup_path}"
          cp config_path, config_backup_path, verbose: false
        else
          puts "Aborting."
        end
      rescue MultiJson::LoadError => e
        puts "ERROR: #{config_path} contains syntax errors. Please fix."
        puts "Edit #{config_path}"
        puts "Finally upload with rake cms:cloud_config:upload"
      end

      def load_config
        MultiJson.load(File.read(config_path))
      end

      def save_config(config)
        File.write(config_path, pretty_print(config))
      end

      def pretty_print(json)
        # MultiJson does not output pretty printed JSON under Ruby 1.9, so we
        # use JSON.pretty_generate instead.
        # MultiJson.dump(MultiJson.load(json), :pretty => true)
        JSON.pretty_generate(MultiJson.load(json))
      end

      def config_path
        Rails.root + "tmp/cloud_config.json"
      end

      def config_backup_path
        @config_backup_path ||= "#{config_path}-#{Time.now.strftime('%Y%m%d%H%M')}"
      end

      def yes?(text)
        puts text.to_s
        $stdin.gets.tap{|text| text.strip! if text}.to_s =~ /^y/
      end
    end
  end
end
