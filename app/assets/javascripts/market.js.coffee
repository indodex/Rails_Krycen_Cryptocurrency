#= require es5-shim.min
#= require es5-sham.min
#= require jquery
#= require jquery_ujs
#= require jquery.mousewheel
#= require jquery-timing.min
#= require jquery.nicescroll.min
#
#= require bootstrap
#= require bootstrap-switch.min
#
#= require moment
#= require bignumber
#= require underscore
#= require cookies.min
#= require flight.min
#= require pusher.min
#= require plugins

#= require ./lib/sfx
#= require ./lib/notifier
#= require ./lib/pusher_connection

#= require highstock
#= require_tree ./highcharts/

#= require_tree ./helpers
#= require_tree ./component_mixin
#= require_tree ./component_data
#= require_tree ./component_ui
#= require_tree ./templates

#= require market/market_page
#= require navigation
#= require_tree ./zendesk_support/
#= require_self

$ ->
  window.notifier = new Notifier()

  BigNumber.config(ERRORS: false)

  HeaderUI.attachTo('header')
  AccountSummaryUI.attachTo('#account_summary')

  FloatUI.attachTo('.float')
  KeyBindUI.attachTo(document)

  PlaceOrderUI.attachTo('#bid_entry')
  PlaceOrderUI.attachTo('#ask_entry')
#  OrderBookUI.attachTo('#order_book')
  OrderAskBookUI.attachTo('#order_bookask')
  OrderBidBookUI.attachTo('#order_bookbid')
  DepthUI.attachTo('#depths_wrapper')

  MyOrdersUI.attachTo('#my_orders')
#  MarketTickerUI.attachTo('#ticker')
  NewMarketTickerUI.attachTo('#ask_ticker, #bid_ticker, header')
  MarketSwitchUI.attachTo('#market_list_wrapper')
  MarketTradesUI.attachTo('#market_trades_wrapper')

  MarketData.attachTo(document)
  GlobalData.attachTo(document, {pusher: window.pusher})
  MemberData.attachTo(document, {pusher: window.pusher}) if gon.accounts

  CandlestickUI.attachTo('#candlestick')
#  SwitchUI.attachTo('#range_switch, #indicator_switch, #main_indicator_switch, #type_switch')
  RangeSwitchUI.attachTo('#range_switch')
  IndicatorSwitchUI.attachTo('#indicator_switch, #main_indicator_switch, #type_switch')
  SettingUI.attachTo(document)

  $('.panel-body-content').niceScroll
    autohidemode: true
    cursorborder: "none"

  $('#btc_amount').change (e) ->
    if $(this).val() == ""
      $(this).val(1)
    btc_cost_per_usd = $("#usd_amount").attr('placeholder')

    if $(this).val() * btc_cost_per_usd > 999999
      usd_amount = ($(this).val() * btc_cost_per_usd).toFixed(0)
    else
      usd_amount = ($(this).val() * btc_cost_per_usd).toFixed(2)
    $('#usd_amount').val(usd_amount)
    return

  $("#btc_amount").keydown (e) ->
    #limit length but allow backspace, delete and arrows
    if $(this).val().length >= parseInt( $(this).attr('maxlength') ) && (e.which != 13 && e.which != 46 && e.which != 37 && e.which != 39 && e.which != 8 && e.which != 0)
      return false


  $('#usd_amount').change (e) ->
    btc_cost_per_usd = $("#usd_amount").attr('placeholder')
    if $(this).val() == ""
      $(this).val(btc_cost_per_usd)
    $('#btc_amount').val( ($(this).val() / btc_cost_per_usd).toFixed(2) )
    return

  $("#usd_amount").keydown (e) ->
    #limit length but allow backspace, delete and arrows
    if $(this).val().length >= parseInt( $(this).attr('maxlength') ) && (e.which != 13 && e.which != 46 && e.which != 37 && e.which != 39 && e.which != 8 && e.which != 0)
      return false
  $(".crc-tabs.crc-tabs--x2").easytabs({
    animationSpeed: 300,
    updateHash: false
  });

  usd_amount = $('#usd_amount').val();
  btc_amount = $('#btc_amount').val();

  $('span.ask_section_price').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(gon.ticker.sell))).toFixed(4))
  $('span.bid_section_price').text(parseFloat(((parseFloat(usd_amount) / parseFloat(btc_amount)) * parseFloat(gon.ticker.buy))).toFixed(4))

#  $(".crc-button--warning").trigger('click');