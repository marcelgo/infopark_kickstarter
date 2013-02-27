module Filters
  class EnvironmentDetection < Base
    class << self
      def filter(controller)
        super(controller)

        detect_preview_environment
        detect_live_environment
      end

      def preview_environment?
        session[:preview_environment]
      end

      def live_environment?
        session[:live_environment]
      end

      private

      def detect_preview_environment
        session[:preview_environment] = preview_host? && authenticated?
      end

      def preview_host?
        request.host =~ /elb\.amazonaws\.com|\.dev|localhost$/
      end

      def authenticated?
        current_user.admin?
      end

      def detect_live_environment
        session[:live_environment] = %w(production staging).include?(Rails.env) && !preview_host?
      end
    end
  end
end