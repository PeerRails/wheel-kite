require 'spec_helper'

describe App::API do
  include Rack::Test::Methods

  def app
    App::API
  end

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
