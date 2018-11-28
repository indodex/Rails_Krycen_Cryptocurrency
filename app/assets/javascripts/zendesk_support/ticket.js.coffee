$(document).ready ()->
  $('.new-ticket-block .new-ticket-form label.submit-btn').on 'click', ()->
    title = $('.new-ticket-block .new-ticket-form input.title').val();
    content = $('.new-ticket-block .new-ticket-form textarea.detail').val();
    if ticket_validation(title, content)
      create_ticket(title, content)
    return

  $('.new-ticket-block .new-ticket-form label.cancel-btn').on 'click', ()->
    switch_to_ticket_list_page()
    return

  $('.js-toggle-help-popup').on 'click', ()->
    if $('.js-help-popup').is(':visible')
      switch_to_ticket_list_page()
      $('.select-option-block input[type=checkbox]').prop("checked", false)
      update_ticket_list()
    return

  $('.select-option-block').on 'click', '.add-ticket-btn', ()->
    switch_to_create_ticket_page()
    return

  $('.select-option-block').on 'click', 'input[type=checkbox]', (e)->
    if($(e.currentTarget).is(':checked'))
      condition = $(e.currentTarget).val()
      filter_tickets(condition)
    $('.select-option-block input[type=checkbox]').prop("checked", false)
    $(e.currentTarget).prop("checked", true)
    return
    
#=============Methods===================
  update_ticket_list = ()->
    $('.ticket-list-block .ticket-block-list').empty()
    $.ajax '/tickets',
      method: 'GET',
      success: (response)->
        $('.ticket-list-block .ticket-block-list').html(response)
    return

  create_ticket = (title, content)->
    $.ajax '/tickets',
      method: 'POST',
      data: {
        ticket: {
          title: title,
          content: content
        }
      },
      success: (response)->
        clear_alert()
        if response['status'] == 'success'
          $('.support-alert span').text(response['message'])
          $('.support-alert').addClass('alert-success').show()
          switch_to_ticket_list_page()
          $('.ticket-block-list').append(response['body'])
        else
          $('.support-alert span').text(response['message'])
          $('.support-alert').addClass('alert-danger').show()
        return
      error: ()->
        clear_alert()
        $('.support-alert span').text('Failed! Please try again later.')
        $('.support-alert').addClass('alert-danger').show()
        return

  reset_create_ticket_page = ()->
    $('.new-ticket-block .new-ticket-form .title').val('')
    $('.new-ticket-block .new-ticket-form .detail').val('')
    return

  switch_to_create_ticket_page = ()->
    reset_create_ticket_page()
    $('.select-option-block').hide()
    $('.ticket-list-block').hide()
    $('.new-ticket-block').show()
    return

  switch_to_ticket_list_page = ()->
#    reset_create_ticket_page()
    $('.select-option-block').show()
    $('.ticket-list-block').show()
    $('.new-ticket-block').hide()
    return

  clear_alert = ()->
    $('.support-alert span').text('')
    $('.support-alert').removeClass('alert-info').removeClass('alert-success').removeClass('alert-danger').hide()
    return

  ticket_validation = (title, content)->
    clear_alert()
    if title=='' || content==''
      $('.support-alert span').text('Error! Title and Content must be filled.')
      $('.support-alert').addClass('alert-danger').show()
      return false
    return true

  filter_tickets = (condition)->
    $.ajax '/tickets/filter_ticket',
      method: 'GET',
      data: {condition: condition},
      success: (response)->
        $('.ticket-list-block .ticket-block-list').html(response)
    return
