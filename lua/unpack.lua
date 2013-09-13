local parser = require "redis.parser";
local lookup = string.gsub(ngx.var.request_uri, " ", "")

local res = ngx.location.capture("/lookup", { args = { lookup = lookup..":*" } } );

local results, type = parser.parse_replies(res.body, 2);

if table.getn(results[2][1]) == 0 then
    return ngx.exit(ngx.HTTP_NOT_FOUND);
end

local res = ngx.location.capture("/get", { args = { id = results[2][1][1] } } );
local href, type = parser.parse_replies(res.body, 2);

if type == parser.ERROR_REPLY or href == nil or href[2][1] == nil then
    return ngx.exit(ngx.HTTP_NOT_FOUND);
else
    ngx.redirect(href[2][1]); 
end