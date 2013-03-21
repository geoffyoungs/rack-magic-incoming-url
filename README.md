Rack::MagicIncomingURL
----------------------

Magic Incoming URL is a piece of rack middleware that redirects a URL to
another one - but only when it's not a local link.

It's *not* designed to prevent hot-linking - it's designed for sites
that respond to multiple domains, where different domains should lead to
different landing pages.

e.g. You run Simon's Shoes and have two domains: simons-shoes.net and simons-boots.net.
They both point to the same site, but you want customers who enter the
simons-boots.net URL to start off looking at boots.

So entering: 

`http://www.simons-shoes.net` goes to `http://www.simons-shoes.net/`

But entering:

`http://www.simons-boots.net` goes to
`http://www.simons-boots.net/boots`

Rack::MagicIncomingUrl allows this to be easily configured:

```` ruby
require 'rack/magic-incoming-url'

map '/' do
  use Rack::MagicIncomingUrl, { 'www.simons-boots.net' => { '/' => 'http://www.simons-boots.net/boots' } }
  run MyWebApp
end
````

Installation
============

`gem install rack-magic-incoming-url`

License (MIT)
==========================================
(c) Geoff Youngs, 2013

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish, 
distribute, sublicense, and/or sell copies of the Software, and to permit 
persons to whom the Software is furnished to do so, subject to the
following conditions: 

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


