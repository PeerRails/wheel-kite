require "grape"
require "sequel"
require 'dotenv'
require_relative "../lib/haversine.rb"

connect_url = ENV["DATABASE_URL"] || 'postgres://dev:dev@localhost/wheelkite-dev'
DB = Sequel.connect(connect_url)
Dotenv.load

module App
  include Haversine
  class API < Grape::API
    format :json
    content_type :json, 'application/json'

    helpers do
      def logger
        API.logger = Logger.new(File.expand_path("../../logs/#{ENV['RACK_ENV']}.log", __FILE__))
      end
    end

    rescue_from :all do |e|
      logger.error e
      status 502
      {error: true, message: 'an unexpected error'}
    end

    desc "Return ok"
    get do
      logger.info "Request: /"

      {text: 'OK', message: "Kaiji"}
    end

    route :any, '*path' do
      logger.error "404"
      error! :not_found, 404
    end

  end
end
