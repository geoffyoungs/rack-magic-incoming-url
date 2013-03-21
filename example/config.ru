$: << File.dirname(__FILE__)+"../lib"
$: << './lib'
require 'rack'
require 'rack/magic-incoming-url'

app = lambda do |env|
  port = env["SERVER_PORT"]
  [
    200,
    {'Content-Type' => 'text/html'},
    [
      %Q[
      <!DOCTYPE html>
      <html>
        <head>
          <title>Title</title>
        </head>
      <body>
        <h1>#{env['PATH_INFO']}</h1>

        <h2>Local links</h2>
        <a href="/">Localhost</a>
        <a href="/localhost">/localhost</a>
        <a href="/217-0-0-1">/127-0-0-1</a>

        <h2>localhost links</h2>
        <a href="http://localhost:#{port}/">Localhost</a>
        <a href="http://localhost:#{port}/localhost">/localhost</a>
        <a href="http://localhost:#{port}/217-0-0-1">/127-0-0-1</a>

        <h2>127.0.0.1 links</h2>
        <a href="http://127.0.0.1:#{port}/">Localhost</a>
        <a href="http://127.0.0.1:#{port}/localhost">/localhost</a>
        <a href="http://127.0.0.1:#{port}/217-0-0-1">/127-0-0-1</a>
      ]
    ]
  ]
end

# When the user goes to http://localhost/ from the URL bar or from another site, they get /localhost?magic-redirect
# but when they follow a link from http://localhost/ it all works normally.
#
# The same happens when they access using 127.0.0.1, except they are directed to a different incoming URL.

use Rack::MagicIncomingUrl, {
  'localhost' => { '/' => '/localhost?magic-redirect' },
  '127.0.0.1' => { '/' => '/127-0-0-1?magic-redirect' }
}
run app

