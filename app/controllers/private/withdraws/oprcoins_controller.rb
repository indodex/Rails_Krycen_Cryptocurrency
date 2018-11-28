module Private::Withdraws
  class OprcoinsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
