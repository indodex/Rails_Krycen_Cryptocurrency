json.asks @asks
json.bids @bids
json.trades @trades

if @member
  json.my_trades @trades_done.map(&:for_notify)
  json.my_orders *([@orders_wait] + Order::ATTRIBUTES)
end

if @current_user
  json.current_user @current_user
  json.deposit_channels @deposit_channels
  json.withdraw_channels @withdraw_channels
  json.deposits @deposits
  json.withdraws @withdraws
  json.fund_accounts @accounts
  json.fund_sources @fund_sources
  json.banks @banks.map(&:attributes), :code
end