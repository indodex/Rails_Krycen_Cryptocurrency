@OrderPriceUI = flight.component ->
  flight.compose.mixin @, [OrderInputMixin]

  @attributes
    precision: gon.market.bid.fixed
    variables:
      input: 'price'
      known: 'volume'
      output: 'total'

  @getLastPrice = ->
    Number gon.ticker.last

  @toggleAlert = (event) ->
    lastPrice = @getLastPrice()

    usd_amount = $('#usd_amount').val();
    btc_amount = $('#btc_amount').val();

    if (event.currentTarget.id == "order_ask_price")
      $('span.ask_section_price').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(@value))).toFixed(2))
    else
      $('span.bid_section_price').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(@value))).toFixed(2))

    switch
      when !@value
        @trigger 'place_order::price_alert::hide'
      when @value > (lastPrice * 1.1)
        @trigger 'place_order::price_alert::show', {label: 'price_high'}
      when @value < (lastPrice * 0.9)
        @trigger 'place_order::price_alert::show', {label: 'price_low'}
      else
        @trigger 'place_order::price_alert::hide'

  @onOutput = (event, order) ->
    price = order.total.div order.volume
    @$node.val price

  @after 'initialize', ->
    @on 'focusout', @toggleAlert
