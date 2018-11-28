@HeaderUI = flight.component ->
  @attributes
    vol: 'span.vol'
    amount: 'span.amount'
    high: 'span.high'
    low: 'span.low'
    last: 'span.last'
    change: 'span.change'
    vol_dollar: 'span.vol-dollar'
    high_dollar: 'span.high-dollar'
    low_dollar: 'span.low-dollar'
    last_dollar: 'span.last-dollar'
    sound: 'input[name="sound-checkbox"]'

  @refresh = (event, ticker) ->
    @select('vol').text("#{parseFloat(ticker.volume).toFixed(4)} #{gon.market.base_unit.toUpperCase()}")
    @select('high').text(parseFloat(ticker.high).toFixed(8))
    @select('low').text(parseFloat(ticker.low).toFixed(8))
    @select('last').text(parseFloat(ticker.last).toFixed(8))

    usd_amount = $('#usd_amount').val();
    btc_amount = $('#btc_amount').val();

    @select('vol_dollar').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.last) * parseFloat(ticker.volume))).toFixed(4) + ' USD')
    @select('high_dollar').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.high))).toFixed(4) + ' USD')
    @select('low_dollar').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.low))).toFixed(4) + ' USD')
    @select('last_dollar').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(ticker.last))).toFixed(4) + ' USD')

    p1 = parseFloat ticker.open
    p2 = parseFloat ticker.last
    trend = formatter.trend(p1 <= p2)
    @select('change').html("<span class='#{trend}'>#{formatter.price_change(p1, p2)}%</span>")

  @after 'initialize', ->
    @on document, 'market::ticker', @refresh

    if Cookies.get('sound') == undefined
      Cookies.set('sound', true, 30)
    state = Cookies.get('sound') == 'true' ? true : false
    $('input[name="sound-checkbox"]').attr "checked", state
#    @select('sound').bootstrapSwitch
#      labelText: gon.i18n.switch.sound
#      state: state
#      handleWidth: 40
#      labelWidth: 40
#      onSwitchChange: (event, state) ->
#        Cookies.set('sound', state, 30)
    $('input[name="sound-checkbox"]').change () ->
        Cookies.set('sound', $(this).is(":checked"), 30)

#    $('header .dropdown-menu').click (e) ->
#      e.stopPropagation()
