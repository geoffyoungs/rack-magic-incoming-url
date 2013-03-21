require 'rubygems'
require 'rack/test'
require 'rack/mock'
require 'rack/magic-incoming-url'
require 'test/unit'

class TestIncoming < Test::Unit::TestCase
  include Rack::Test::Methods

  attr_reader :app
  def setup
    orig = lambda { |env| [200, {'Content-Type' => 'text/html'}, 'OK'] }
    @app = Rack::MagicIncomingUrl.new orig, {
         'www.simons-boots.net' => {
           '/' => 'http://www.simons-boots.net/boots',
           '/offers' => '/boots-offers'
         }
      }
  end

  def test_redirect_no_referer
    get "http://www.simons-boots.net/"
    assert last_response.redirect?
    assert_equal "http://www.simons-boots.net/boots", last_response.location

    get "http://www.simons-boots.net/offers"
    assert last_response.redirect?
    assert_equal "http://www.simons-boots.net/boots-offers", last_response.location
  end

  def test_redirect_external_referer
    get "http://www.simons-boots.net/", {}, { 'HTTP_REFERER' => 'http://www.google.com/' }
    assert last_response.redirect?
    assert_equal "http://www.simons-boots.net/boots", last_response.location
  end

  def test_noredirect_same_referer
    get "http://www.simons-boots.net/", {}, { 'HTTP_REFERER' => 'http://www.simons-boots.net/' }
    assert ! last_response.redirect?

    get "http://www.simons-boots.net/offers", {}, { 'HTTP_REFERER' => 'http://www.simons-boots.net/' }
    assert ! last_response.redirect?
  end

  def test_noredirect_different_url
    get "http://www.simons-boots.net/foo", {}, { 'HTTP_REFERER' => 'http://www.simons-shoes.net/' }
    assert ! last_response.redirect?
  end
end
