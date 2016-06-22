require "grape"
require "sequel"
require 'dotenv'
require 'securerandom'
require_relative "../lib/haversine.rb"
require_relative "../lib/cars.rb"

connect_url = ENV["DATABASE_URL"] || 'postgres://dev:dev@localhost/wheelkite-dev'
DB = Sequel.connect(connect_url)
Dotenv.load

module App
  extend Haversine

  def self.mideta(cars=[], person=[])
    Haversine.eta_median(Haversine.calculate_eta(cars, person))
  end

  class API < Grape::API
    format :json
    content_type :json, 'application/json'

    helpers do
      def logger
        API.logger = Logger.new(File.expand_path("../../logs/#{ENV['RACK_ENV']}.log", __FILE__))
      end
    end

    rescue_from :all do |e|
      error_ticket = SecureRandom.hex(42)
      logger.error "#{error_ticket}\n#{e}"
      error! "Service Error, ticket: #{error_ticket}", 502
    end

    desc "Return ok"
    get do
      logger.info "Request: /"
      {text: 'OK', message: "Kaiji"}
    end

    desc "Find a car"
    post "/search" do
      ticket = SecureRandom.uuid
      logger.info "Request: /search\nTicket: #{ticket}\nParams: #{params.to_json}"
      if params["location"].nil?
        error! "Not Valid Parameters", 400
      elsif params["location"]["long"].nil? || params["location"]["lat"].nil?
        error! "Not Valid Parameters", 400
      end

      long=params["location"]["long"].to_f
      lat=params["location"]["lat"].to_f

      cars = Car.find_nearest(long, lat)
      car_coordinates = cars.map { |car| [car[:x], car[:y]] }
      person = [long, lat]

      result_eta = App.mideta(car_coordinates, person)
      {eta: result_eta}

    end

    route :any, '*path' do
      logger.error "404"
      error! :not_found, 404
    end

  end
end
