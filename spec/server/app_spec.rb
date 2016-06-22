require 'spec_helper'

describe App::API do
  include Rack::Test::Methods

  def app
    App::API
  end

  describe "GET /" do

    let(:response) {JSON.parse(last_response.body)}
    it 'ping' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(response["text"]).to eq('OK')
    end

    it 'returns 404' do
      get '/404'
      expect(last_response.status).to eq(404)
      expect(response["error"]).to eq('not_found')
    end

  end

  describe "POST /search" do
    let(:response) {JSON.parse(last_response.body)}

    it "should return a nearest car" do
      post "/search", location: {long: 40.71330, lat: -74}
      expect(response["error"]).to be nil
      expect(response["eta"]).to eql(0.5253301482113608)
    end

    it "should return error with wrong params" do
      post "/search", location: nil
      expect(response["error"]).not_to be nil

      post "/search", location: {name: "koko"}
      expect(response["error"]).not_to be nil

      post "/search"
      expect(response["error"]).not_to be nil
    end

    #it "should return error when no available cars" do
      #and how will I do this?
    #end
  end

end
