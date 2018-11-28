window.NewMarketTickerUI = flight.component ->
  @attributes
    askSelector: '.ask_price'
    bidSelector: '.bid_price'
#    lastSelector: '.last .price'
#    header_lastSelector: 'header-last'
    priceSelector: '.price'
    bidDollarSelector: 'span.bid_price-dollar'
    askDollarSelector: 'span.ask_price-dollar'

  @updatePrice = (selector, price, trend) ->
    selector.removeClass('text-up').removeClass('text-down').addClass(formatter.trend(trend))
    selector.html(formatter.fixBid(price))

  @refresh = (event, ticker) ->
    @updatePrice @select('askSelector'),  ticker.sell, ticker.sell_trend
    @updatePrice @select('bidSelector'),  ticker.buy,  ticker.buy_trend
#    @updatePrice @select('lastSelector'), ticker.last, ticker.last_trend
#    @updatePrice @select('header_lastSelector'), ticker.last, ticker.last_trend

    usd_amount = $('#usd_amount').val();
    btc_amount = $('#btc_amount').val();

    @select('askDollarSelector').text(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.sell)).toFixed(4) + ' USD')
    @select('bidDollarSelector').text(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.buy)).toFixed(4) + ' USD')

    e = $.Event('keyup')
    e.keycode = 13
    if $('#order_ask_price').val() == ''
      $('#order_ask_price').val(formatter.fixBid(ticker.sell))
      $('#order_ask_price').trigger(e)
    if $('#order_bid_price').val() == ''
      $('#order_bid_price').val(formatter.fixBid(ticker.buy))
      $('#order_bid_price').trigger(e)

#    $('span.ask_section_price').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.sell))).toFixed(4))
#    $('span.bid_section_price').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.buy))).toFixed(4))

  @after 'initialize', ->
    @on document, 'market::ticker', @refresh
