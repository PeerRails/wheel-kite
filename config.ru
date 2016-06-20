require "./server/app.rb"

require 'rack/cors'

use Rack::Static, :root => 'public',
       :header_rules => [
         [:all, {'Cache-Control' => 'public, max-age=31536000'}],
         [:fonts, {'Access-Control-Allow-Origin' => '*'}]
       ]

run App::API
