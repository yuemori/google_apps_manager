# Copyright (c) 2015 Yasutomo Uemori
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/storage'
require 'google/api_client/auth/storages/file_store'

module GoogleAppsManager
  ##
  # Authorize to GoogleApi
  #
  # Usage:
  #   auth = GoogleAppsManager::Auth.new(YAML.load_file('sample.yml'))
  #   auth.authorize #=> authorize to google api
  #
  # @param yaml_file
  class Auth
    def initialize(config)
      @application_name = config['application_name']
      @credential_store_file = config['credential_store_file']
      @client_secrets_file = config['client_secrets_file']

      File.write('{}', @client_secrets_file) unless File.exist? @client_secrets_file
      authorize
    end

    def client
      @client ||= Google::ApiClient.new(application_name: @application_name)
    end

    private

    def authorize
      auth = file_storage.authorize
      auth = authorize_with_client_secrets if file_storage.authorization.nil?
      auth
    end

    def file_storage
      @file_strage ||= Google::APIClient::Storage.new(Google::APIClient::FileStore.new(@credential_store_file))
    end

    def client_secrets
      @client_secrets ||= Google::APIClient::ClientSecrets.load @client_secrets_file
    end

    def authorize_with_client_secrets
      flow = Google::APIClient::InstalledAppFlow.new(
        client_id: client_secrets.client_id,
        client_secret: client_secrets.client_secret,
        scope: %w(
          https://www.googleapis.com/auth/drive
        )
      )

      flow.authorize file_storage
    end
  end
end
