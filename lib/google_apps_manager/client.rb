require 'google/api_client'
require 'google_apps_manager/auth'
require 'google_apps_manager/downloader'

module GoogleAppsManager
  ##
  # Google::ApiClient Wrapper
  #
  # Usage:
  #   auth = GoogleAppsManager::Auth.new(YAML.load_file('sample.yml'))
  #   auth.authorize #=> authorize to google api
  #
  # @param yaml_file
  class Client
    class DownloadError < StandardError; end

    def initialize(config)
      @config = config
    end

    def client
      @client ||= Google::APIClient.new(application_name: @config['application_name'])
    end

    def authorize!
      auth = Auth.new(@config)
      client.authorization = auth.authorize
      self
    end

    def download
      authorize!
      loader = Downloader.new(ENV['FILE_ID'] || '', client)
      if loader.success?
        file_write(loader.scripts)
      else
        fail DownloadError.new, loader.result
      end
      loader.scripts
    end

    private

    def file_write(scripts = [])
      scripts.each do |script|
        File.write "#{@config['dist']}/#{script.name}", script.to_html
      end
    end
  end
end
