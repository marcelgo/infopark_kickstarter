module InfoparkKickstarter
  class Configuration
    def deploy
      @deploy ||= load_configuration_file('deploy')
    end

    def custom_cloud
      @custom_cloud ||= load_configuration_file('custom_cloud')
    end

    def rails_connector
      @rails_connector ||= load_configuration_file('rails_connector')
    end

    def cms_url
      rails_connector['cms_api']['url'].gsub('admin', tenant_name)
    end

    def crm_url
      custom_cloud['crm']['url'].gsub('admin', tenant_name)
    end

    def contact_url(id)
      "#{crm_url}/contacts/#{id}"
    end

    def konsole_url
      'https://console.infopark.net'
    end

    def knowledge_base_url
      'https://kb.infopark.de/kb'
    end

    def support_url
      'https://kb.infopark.de/support'
    end

    def cms_blog_url
      'https://kb.infopark.de/cms-news'
    end

    def crm_blog_url
      'https://kb.infopark.de/webcrm-news'
    end

    def github_repository_url
      "https://github.com/infopark-cloud-express/#{tenant_name}"
    end

    def github_repository_issues_url
      "#{github_repository_url}/issues"
    end

    def status_url
      'http://status.infopark.net/'
    end

    def tenant_name
      rails_connector['cms_api']['http_host']
    end

    def tenant_api_url
      deploy['url']
    end

    def tenant_api_key
      deploy['api_key']
    end

    private

    def load_configuration_file(config)
      YAML.load_file(File.join(Rails.root, "config/#{config}.yml"))
    end
  end
end