require 'json'
require 'google_apps_manager/script'
require 'pry'

module GoogleAppsManager
  ##
  # convert to script list from download json
  class Downloader
    DOWNLOAD_BASE_URL = 'https://script.google.com/feeds/download/export?format=json&id='

    attr_reader :result

    def initialize(file_id, client)
      @uri = DOWNLOAD_BASE_URL + file_id
      @client = client
    end

    def result
      @result ||= @client.execute(uri: @uri)
    end

    def success?
      result.status == 200
    end

    def scripts
      unless @scripts
        JSON.parse(result.body)['files'].inject(scripts = []) do |array, data|
          array << Script.new(name: data['name'], source: data['source'], type: data['type'])
        end
      end
      scripts
    end
  end
end
