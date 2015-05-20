require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      query_params = parse_www_encoded_form(req.query_string)
      body_params = parse_www_encoded_form(req.body)
      @params = route_params.merge(query_params.merge(body_params))
    end

    def [](key)
      key = key.to_s if key.is_a?(Symbol)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      result = {}
      return result if www_encoded_form.nil?

      URI::decode_www_form(www_encoded_form).each do |keys, value|
        nested_hash = Hash.new

        parse_key(keys).reverse.each_with_index do |key, idx|
          value = nested_hash unless idx == 0
          nested_hash = { key => value}
        end
        p nested_hash
        result.merge!(nested_hash)
        # 'cat' => [ {'owner' => 'alex'} , 'name' => 'fluffy' ]
      end

      p "Result: #{result}"
      result
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
