-- Init
local parser = require "redis.parser"

function url_decode(str)
  str = string.gsub (str, "+", " ")
  str = string.gsub (str, "%%(%x%x)",
      function(h) return string.char(tonumber(h,16)) end)
  str = string.gsub (str, "\r\n", "\n")
  return str
end


basen = function(n)
    local digits = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local t = {}
    repeat
        local d = (n % 62) + 1
        n = math.floor(n / 62)
        table.insert(t, 1, digits:sub(d, d))
    until n == 0
    return table.concat(t,"");
end

-- See if we have the url already

local hash = ngx.md5(ngx.var.arg_url);
local res = ngx.location.capture("/lookup", {
    args = { lookup = "*:"..hash }
});

local results, type = parser.parse_replies(res.body, 2);

if not (table.getn(results[2][1]) == 0) then
    local s, e = string.find(results[2][1][1], ":");
    ngx.say(
        "http://"
        .. ngx.var.host
        .. string.sub(results[2][1][1], 1, s - 1)
    );
    return ngx.exit(200);
end

-- We don't, so let's add it

res = ngx.location.capture("/count");

results, type = parser.parse_replies(res.body, 2)

if (nil == results[2][1]) then
    results[2][1] = 0;
end

local found = false
local id

-- Search for a non-colliding ID

math.randomseed(results[2][1] + 1)
while not found do
    id = basen(math.random(999999999))
    res = ngx.location.capture("/lookup", {
        args = { lookup = "/" .. id .. ":*" }
    });
    
    results, type = parser.parse_replies(res.body, 2)
    found = table.getn(results[2][1]) == 0
end

-- Save the url with the unique ID

ngx.location.capture("/save",
    {
        args = {
            id = "/"..tostring(id)..":"..ngx.md5(ngx.var.arg_url),
            url = url_decode(ngx.var.arg_url)
        }
    }
)

-- Present to the user

--ngx.say("http://" .. ngx.var.host .. "/" .. id)

ngx.say("myhost.com/" .. id)