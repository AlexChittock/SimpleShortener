SimpleShortener
===============

And now, introducing something I made during lunch.

SimpleShortener is a simple redis backed nginx url shortener.

It was inspired by https://github.com/MendelGusmao/nginx-redis-url-shortener and http://uberblo.gs/2011/06/high-performance-url-shortening-with-redis-backed-nginx.

It is intended to be used as a standalone service. The idea being that you'll be hosting it on a short domain like http://go.to, and redirecting to a longer domain like http://example.com.

This isn't to say you can't use under a single domain, it just wasn't created with that in mind.

If you find this software useful. I'd love to hear from you, drop me a line at [alex@monsterhq.co.uk](mailto://alex@monsterhq.co.uk) and let me know your thoughts.

## So, what's good about it?

It's simple. It *should* be fast. It *should* scale well. (I haven't benchmarked it)

## Requirements
* Openresty
* <s>[nginx](http://wiki.nginx.org/Main)</s>
* [redis](redis.io)
* <s>[redis2-nginx-module](http://wiki.nginx.org/HttpRedis2Module)</s>
* <s>[lua-nginx-module](https://github.com/chaoslawful/lua-nginx-module)</s>
* <s>[set-misc-nginx-module](https://github.com/agentzh/set-misc-nginx-module)</s>
* <s>[ngx_devel_kit](https://github.com/simpl/ngx_devel_kit)</s>

## Usage

It's pretty damn simple.

### Starting the server

`nginx -p /path/to/simpleshortener`

### Shortening a URL

Pass your URL as the parameter "url" to /shorten, for example:

`http://localhost/shorten?url=http://somelongdomain.com/somelongpath/somelongfilename.somelongextension`

And out pops the short url:

`http://localhost/28lK`

### Expanding a URL

Open the short url in your browser. Ta da!