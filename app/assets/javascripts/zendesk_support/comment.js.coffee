$(document).ready ()->
  $('.ticket-list-block .ticket-block-list').on 'click', '.ticket-collapse-icon-col', (e)->
    ticket_block = $(e.currentTarget).closest('.ticket-block')
    if ticket_block.find('.comments-block').is(':visible')
      ticket_block.find('span.fa-plus').show()
      ticket_block.find('span.fa-minus').hide()
      ticket_block.find('.comments-block').hide()
    else
      ticket_block.find('span.fa-plus').hide()
      ticket_block.find('span.fa-minus').show()
      ticket_block.find('.comments-block').show()
      ticket_block.find('.comment-block').remove()
      update_comment_list(ticket_block.data('ticket-id'), ticket_block)
    return

  $('.ticket-list-block .ticket-block-list').on 'click', '.create-comment-btn', (e)->
    ticket_block = $(e.currentTarget).closest('.ticket-block')
    comment_body = ticket_block.find('textarea.comment-body').val()
    create_comment(ticket_block.data('ticket-id'), comment_body)
    return

  update_comment_list = (ticket_id, ticket_block) ->
    $.ajax '/tickets/get_comments',
      method: 'GET',
      data: {id: ticket_id},
      success: (response)->
        $(ticket_block).find('.comments-block').prepend(response)
    return
    
  create_comment = (ticket_id, ticket_body)->
    if comment_validation()
      $.ajax '/tickets/create_comment',
        method: 'POST',
        data: {id: ticket_id, body: ticket_body},
        success: (response)->
          if response['status'] == "success"
            $('#ticket_'+ticket_id + " .comment-block").remove()
            $('#ticket_'+ticket_id + " .comments-block").prepend(response['body'])
            $('#ticket_'+ticket_id + " .comment-body").val('')
          else
            clear_alert()
            $('.support-alert span').text('Failed! Please try again later.')
            $('.support-alert').addClass('alert-danger').show()
    return

  comment_validation = (body)->
    if body == ''
      clear_alert()
      $('.support-alert span').text("Comment body can't be empty!")
      $('.support-alert').addClass('alert-danger').show()
      return false
    return true
