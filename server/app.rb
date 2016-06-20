require "grape"

logger = Logger.new("logs/app.log")

module App
  class API < Grape::API
    format :json
    content_type :json, 'application/json'
    prefix :api

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
      API.logger.info "Request: /api"
      {text: 'OK', message: "Kaiji"}
    end

  end
end
