# Copyright (c) 2015 Yasutomo Uemori
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

require 'thor'
require 'yaml'
require 'google_apps_manager/client'

module GoogleAppsManager
  ##
  # CLI Support Class
  class CLI < Thor
    desc 'init', 'authorize to google with oauth2'
    def init
      puts 'Authorization to google...'
      authorization
      puts 'Successed!'
    end

    desc 'pull', 'download files from google apps script'
    def pull
      puts 'Authorization to google...'
      client = authorization
      puts "Successed.\n\n"
      puts 'file downloading...'
      scripts = client.download
      puts "Successed.\n\n"
      scripts.each do |script|
        puts "Download file: #{config['dist']}/#{script.name}"
      end
      puts "\nFinish!"
    end

    private

    def config
      @config ||= YAML.load_file(ENV['GAM_CONFIG_FILE'])
    end

    def authorization
      @client = GoogleAppsManager::Client.new(config)
      @client.authorize!
    end
  end
end
