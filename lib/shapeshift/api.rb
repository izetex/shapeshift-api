require "shapeshift/api/version"
require 'net/http'

module Shapeshift
  module Api

    def self.coins
      get 'getcoins'
    end

    #
    # minimum, limit - measured in from_symbol
    # rate = from_symbol / to_symbol
    # minerFee - measured in to_symbol
    #
    def self.rate from_symbol, to_symbol = 'btc'
      get "marketinfo/#{pair(from_symbol, to_symbol)}"
    end

    def self.quote amount_to, from_symbol, to_symbol = 'btc'
      post 'sendamount', {amount: amount_to, pair: pair(from_symbol, to_symbol)}
    end

    # {"success"=>{"orderId"=>"23902010-5280-499c-8065-50ff3fc9f24a",
    # "pair"=>"eth_gnt", "withdrawal"=>"0xd7170547046adc91b5cdf39bc04ad70e95d0a825",
    # "withdrawalAmount"=>"30", "deposit"=>"0x553beec262e0ab11dfe43f7d60dc1f51f03e4398",
    # "depositAmount"=>"0.02696698", "expiration"=>1512726449980, "quotedRate"=>"1557.46037437",
    # "maxLimit"=>11.57075248, "apiPubKey"=>"shapeshift", "minerFee"=>"12"}}
    #
    def self.sendamount amount_to, address_to, from_symbol, to_symbol = 'btc'
      post 'sendamount', {amount: amount_to, withdrawal: address_to, pair: pair(from_symbol, to_symbol)}
    end

    # {"status"=>"no_deposits", "address"=>"0x553beec262e0ab11dfe43f7d60dc1f51f03e4398"}
    def self.status address
      get "txStat/#{address}"
    end


    private

    def self.pair from_symbol, to_symbol
      "#{from_symbol.to_s.downcase}_#{to_symbol.to_s.downcase}"
    end

    def self.get method_args
      url = URI.parse("https://shapeshift.io/#{method_args}")
      req = Get.new url

      r = start(url.hostname, url.port,
                use_ssl: true, connect_timeout: 10, read_timeout: 20 ) {|http|
        http.request(req)
      }

      JSON.parse(r.body)


      r = Net::HTTP.get(URI.parse("https://shapeshift.io/#{method_args}"))
      JSON.parse(r)
    end


    def self.post method, args
      url = URI.parse("https://shapeshift.io/#{method}")
      req = Post.new url
      req.form_data = args

      r = start(url.hostname, url.port,
            use_ssl: true, connect_timeout: 10, read_timeout: 120 ) {|http|
        http.request(req)
      }

      JSON.parse(r.body)

    end

  end
end
