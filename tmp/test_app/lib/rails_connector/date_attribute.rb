# This patch is necessary so that the RailsConnector can return the date
# in the time zone defined in Rails.application.config.time_zone
module RailsConnector
  module DateAttribute #:nodoc: all
    def self.parse(iso_date_time)
      # Original
      # Time.from_iso(iso_date_time).localtime

      # Patched
      Time.from_iso(iso_date_time).in_time_zone
    rescue ArgumentError
      raise "The value is not a valid ISO date time: #{iso_date_time.inspect}"
    end
  end
end