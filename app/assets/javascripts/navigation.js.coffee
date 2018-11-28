$(document).on('ready page:load', ->
  $(document).on('click', '#navlink-sign-up', (e) ->
    $('#sign-in-sign-up-tabs').easytabs('select', '#sign-up')
    return
  )

  $(document).on('click', '#navlink-sign-in', (e) ->
    $('#sign-in-sign-up-tabs').easytabs('select', '#sign-in')
    return
  )

  $('#navlink-markets').click( ->
    location.href = $(this).data('link')
    return
  )
  
  $(document).on('click', '#forget_pwd', (e) ->
    $('#sign-in-sign-up-tabs').hide()
    $('#forget_pwd_form').show()
    return
  )

  $('#forget_pwd_form').on('click', '.cancel', (e) ->
    $('#sign-in-sign-up-tabs').show()
    $('#forget_pwd_form').hide()
    return
  )
  return
)