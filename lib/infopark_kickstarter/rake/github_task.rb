require 'rake'
require 'rake/tasklib'

require 'infopark_kickstarter/rake/credential_helper'

module InfoparkKickstarter
  module Rake
    class GithubTask < ::Rake::TaskLib
      include CredentialHelper

      def initialize
        namespace :cms do
          namespace :github do
            desc 'List github users allowed to access the project repository'
            task :list do
              params = [
                "token=#{api_key}",
              ].join('&')

              sh("curl -X GET #{url}/developers -d \"#{params}\"", verbose: false)
              puts
            end

            desc 'Show access information for github user'
            task :show, [:username] do |_, args|
              validate_username(args)

              params = [
                "token=#{api_key}",
              ].join('&')

              sh("curl -X GET #{url}/developers/#{args[:username]} -d \"#{params}\"", verbose: false)
              puts
            end

            desc 'Add github user with "pull" (read-only, default) or "push" (read and write) permission'
            task :add, [:username, :permission] do |_, args|
              validate_username(args)
              args.with_defaults(permission: 'pull')

              params = [
                "token=#{api_key}",
                "developer[username]=#{args[:username]}",
                "developer[perm]=#{args[:permission]}",
              ].join('&')

              sh("curl -X POST #{url}/developers -d \"#{params}\"", verbose: false)
              puts
            end

            desc 'Change access permission of github user to "pull" (read-only) or "push" (read and write)'
            task :change, [:username, :permission] do |_, args|
              validate_username(args)
              validate_permission(args)

              params = [
                "token=#{api_key}",
                "developer[perm]=#{args[:permission]}",
              ].join('&')

              sh("curl -X PUT #{url}/developers/#{args[:username]} -d \"#{params}\"", verbose: false)
              puts
            end

            desc 'Disallow github user to access the project repository'
            task :remove, [:username] do |_, args|
              validate_username(args)

              params = [
                "token=#{api_key}",
              ].join('&')

              sh("curl -X DELETE #{url}/developers/#{args[:username]} -d \"#{params}\"", verbose: false)
              puts
            end
          end
        end
      end

      private

      def validate_username(args)
        validate(args, :username, 'Please provide a github username.')
      end

      def validate_permission(args)
        validate(args, :permission, 'Please provide a permission "pull" (read-only, default) or "push" (read and write).')
      end

      def validate(args, key, msg)
        unless args[key]
          puts msg
          exit(1)
        end
      end
    end
  end
end