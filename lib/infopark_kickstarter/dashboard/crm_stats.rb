module InfoparkKickstarter
  module Dashboard
    class CrmStats
      def contacts
        @contacts ||= Infopark::Crm::Contact.search(params: {}).size
      end

      def accounts
        @accounts ||= Infopark::Crm::Account.search(params: {}).size
      end

      def mailings
        @mailings ||= Infopark::Crm::Mailing.search(params: {}).size
      end

      def events
        @events ||= Infopark::Crm::Event.search(params: {}).size
      end

      def activities
        @activities ||= Infopark::Crm::Activity.search(params: {}).size
      end
    end
  end
end