require 'finnhub_ruby'

class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    FinnhubRuby.configure do |config|
      config.api_key['api_key'] = 'cifse6hr01qhvakk887gcifse6hr01qhvakk8880'
    end

    finnhub_client = FinnhubRuby::DefaultApi.new

    quote = finnhub_client.quote(ticker_symbol)
    current_price = quote.c
    profile = finnhub_client.company_profile2({ symbol: ticker_symbol })

    begin
      new(ticker: ticker_symbol, name: profile.name, last_price: current_price)
    rescue => exception
      nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker:ticker_symbol).first
  end
end
