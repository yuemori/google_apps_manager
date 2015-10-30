require 'json'
require 'cgi'

module GoogleAppsManager
  ##
  # Script file object by google apps script
  class Script
    def initialize(name:, source:, type:)
      @name = name
      @source = source
      @type = type
    end

    def expantion
      case @type
      when 'server_js' then '.js'
      when 'html'      then '.html'
      else
        '.txt'
      end
    end

    def name
      @name + expantion
    end

    def to_html
      @html ||= CGI.unescape_html(@source)
    end
  end
end
