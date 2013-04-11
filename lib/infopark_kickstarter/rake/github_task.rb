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
              puts RestClient.get("#{url}/developers", params: { token: api_key })

              puts
            end

            desc 'Show access information for github user'
            task :show, [:username] do |_, args|
              validate_username(args)

              puts RestClient.get("#{url}/developers/#{args[:username]}", params: { token: api_key })

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

              puts RestClient.post("#{url}/developers?#{params}", {})

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

              puts RestClient.put("#{url}/developers/#{args[:username]}?#{params}", {})

              puts
            end

            desc 'Disallow github user to access the project repository'
            task :remove, [:username] do |_, args|
              validate_username(args)

              puts RestClient.delete("#{url}/developers/#{args[:username]}", params: { token: api_key })

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