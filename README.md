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
* [redis](redis.io)
* [openresty](http://openresty.org)

Or instead of openresty:

* [nginx](http://wiki.nginx.org/Main)
* [redis2-nginx-module](http://wiki.nginx.org/HttpRedis2Module)
* [lua-nginx-module](https://github.com/chaoslawful/lua-nginx-module)
* [set-misc-nginx-module](https://github.com/agentzh/set-misc-nginx-module)
* [ngx\_devel\_kit](https://github.com/simpl/ngx_devel_kit)

## Getting Started

### Installation

1. Extract the [zip](https://github.com/AlexChittock/SimpleShortener/archive/master.zip) somewhere.
2. Modify the first line of `nginx.conf` to use the account you want. For example: `user www staff;`

### Starting the server

`nginx -p /path/to/simpleshortener`

### Shortening a URL

Pass your URL as the parameter "url" to /shorten, for example:

`http://localhost/shorten?url=http://somelongdomain.com/somelongpath/somelongfilename.somelongextension`

And out pops the short url:

`http://localhost/28lK`

### Expanding a URL

Open the short url in your browser. Ta da!