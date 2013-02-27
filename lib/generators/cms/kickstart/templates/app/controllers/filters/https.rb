module Filters
  class Https < Base
    class << self
      def filter(controller)
        super(controller)

        require_https
      end

      private

      # TODO Insert valid hostname like "dev.project.com". You should use a hostname the ssl
      # certificate is issued for.
      def require_https
        if request.protocol == "http://" && request.host == 'HOSTNAME'
          redirect_to('https://' + request.host_with_port + request.fullpath, status: :moved_permanently)
        end
      end
    end
  end
end