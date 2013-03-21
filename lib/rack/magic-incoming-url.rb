=begin
  Magic Incoming URL is a piece of rack middleware that redirects a URL to another one - but only when it's not from a local link.

  It's designed for sites that respond to multiple domains, where different domains should lead to different landing pages.

  e.g. You run Simon's Shoes and have two domains: simons-shoes.net and simons-boots.net.
  They both point to the same site, but you want customers who go to simons-boots.net to end up
  start on the boots page.

  http://www.simons-shoes.net -> http://www.simons-shoes.net/
  http://www.simons-boots.net -> http://www.simons-boots.net/boots

  You can achieve this with the following config:

  map '/' do
    use Rack::MagicIncomingUrl, { 'www.simons-boots.net' => { '/' => '/boots' } }
    run MyWebApp
  end

=end
module Rack
class MagicIncomingUrl
  def initialize(app, map)
    @app, @map = app, map
  end

  def redirect_for_env(env)
    return nil unless @map

    host, path, server = env['HTTP_HOST'], env['PATH_INFO'], env['SERVER_NAME']

    settings = @map[host] || @map[server]

    return unless settings

    settings[path]
  end

  def call env
    redirect = redirect_for_env(env)

    if redirect
      # Only continue if no referer or non-local refererer
      if env['HTTP_REFERER'].nil? or env['HTTP_REFERER'].index(env['HTTP_HOST']).nil?
        if redirect[0..0] == '/'
          redirect = "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{redirect}"
        end
        res = Rack::Response.new
        res.redirect(redirect)

        return res.finish
      end
    end

    @app.call(env)
  end
end
end
