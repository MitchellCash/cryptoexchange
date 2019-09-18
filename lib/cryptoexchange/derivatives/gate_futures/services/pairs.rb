module Cryptoexchange::Exchanges
  module GateFutures
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::GateFutures::Market::API_URL}/contracts"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          market_pairs = []
          output.each do |pair|
            base, target = pair["name"].split("_")
            market_pairs << Cryptoexchange::Models::MarketPair.new(
                              base: base,
                              target: target,
                              market: GateFutures::Market::NAME,
                              inst_id: pair["name"]
                            )
          end
          market_pairs
        end
      end
    end
  end
end