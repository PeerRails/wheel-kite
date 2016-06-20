require "grape"
require "sequel"

logger = Logger.new("logs/app.log")

connect_url = ENV["DATABASE_URL"] || 'postgres://dev:dev@localhost/wheelkite-dev'
DB = Sequel.connect(connect_url)

module App
  class API < Grape::API
    format :json
    content_type :json, 'application/json'

    helpers do
      def logger
        API.logger
      end
    end

    rescue_from :all do |e|
      API.logger.error e
      status 502
      {error: true, message: 'Error'}
    end

    desc "Return ok"
    get do
      API.logger.info "Request: /"
      {text: 'OK', message: "Kaiji"}
    end

  end
end
