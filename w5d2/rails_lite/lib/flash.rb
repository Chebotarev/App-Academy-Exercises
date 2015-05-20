require 'json'
require 'webrick'
require 'byebug'

class Flash
  # attr_accessor :flash_now

  def initialize(req)
    @flash_now = {}
    @flash = {}

    req.cookies.each do |cookie|
      if cookie.name == '_rails_lite_app_flash'
        @flash_now = JSON.parse(cookie.value)
      end
    end
  end

  def [](key)
    @flash[key]
  end

  def []=(key, val)
    @flash[key] = val
  end

  def now
    @flash_now
  end

  def store_flash(res)
    serialized_flash = @flash.to_json
    flash_cookie = WEBrick::Cookie.new(
      '_rails_lite_app_flash',
      serialized_flash
    )

    res.cookies << flash_cookie
  end
end
