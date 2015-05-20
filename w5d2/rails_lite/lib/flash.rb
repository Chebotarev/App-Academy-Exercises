require 'json'
require 'webrick'

class Flash

  def initialize(req)
    req.cookies.each do |cookie|
      if cookie.name == '_rails_lite_app'

      end
    end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def now

  end
end
