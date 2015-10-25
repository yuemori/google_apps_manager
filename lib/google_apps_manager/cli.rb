# Copyright (c) 2015 Yasutomo Uemori
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

require 'thor'
require 'yaml'
require 'google_apps_manager/auth'

module GoogleAppsManager
  ##
  # CLI Support Class
  class CLI < Thor
    desc 'init', 'authorize to google with oauth2'
    def init
      auth
    end

    private

    def config
      @config ||= YAML.load_file(ENV['GAM_CONFIG_FILE'])
    end

    def auth
      @auth ||= Auth.new(config)
    end
  end
end
