require 'json'
require 'webrick'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    req.cookies.each do |cookie|
      if cookie.name == '_rails_lite_app'
        @cookie_val = JSON.parse(cookie.value) unless cookie.nil?
      end
    end

    @cookie_val ||= {}
  end

  def [](key)
    @cookie_val[key]
  end

  def []=(key, val)
    @cookie_val[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    serialized_session = @cookie_val.to_json
    session_cookie = WEBrick::Cookie.new('_rails_lite_app', serialized_session)
    res.cookies << session_cookie
  end
end
