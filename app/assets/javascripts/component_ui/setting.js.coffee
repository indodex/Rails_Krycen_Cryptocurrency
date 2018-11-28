@SettingUI = flight.component ->
  @attributes
    passwordSel: 'span.crc-side-navigation__sub-item-action.js-toggle-password-popup'
    resetPasswordModalSel: '.js-password-popup'
    resetPasswordModalCloseSel: '.js-password-popup button.crc-button.js-toggle-password-popup'
    originPasswordSel: '.crc-popup.js-password-popup input#oldPassword'
    newPasswordSel: '.crc-popup.js-password-popup input#newPassword'
    confirmPasswordSel: '.crc-popup.js-password-popup input#repeatNewPassword'
    savePasswordBtnSel: '.crc-popup.js-password-popup button[type=submit]'

  @initializeModal = ()->
    @select('originPasswordSel').val('')
    @select('newPasswordSel').val('')
    @select('confirmPasswordSel').val('')

  @togleChangePassword = ()->
    @initializeModal()
    @select('resetPasswordModalSel').toggle()

  @validate = ->
    state = true
    if @select('originPasswordSel').val() is ''
      $('.crc-popup.js-password-popup label.error.oldPassword').html("Can't be empty")
      $('.crc-popup.js-password-popup label.error.oldPassword').show().fadeOut(3000)
      state = false
    if @select('newPasswordSel').val() is ''
      $('.crc-popup.js-password-popup label.error.newPassword').html("Can't be empty")
      $('.crc-popup.js-password-popup label.error.newPassword').show().fadeOut(3000)
      state = false
    if @select('confirmPasswordSel').val() is ''
      $('.crc-popup.js-password-popup label.error.repeatNewPassword').html("Can't be empty")
      $('.crc-popup.js-password-popup label.error.repeatNewPassword').show().fadeOut(3000)
      state = false
    if @select('newPasswordSel').val() != @select('confirmPasswordSel').val()
      $('.crc-popup.js-password-popup label.error.repeatNewPassword').html("Does not match, Please type again!")
      $('.crc-popup.js-password-popup label.error.repeatNewPassword').show().fadeOut(3000)
      state = false
    else if @select('newPasswordSel').val().length < 6
      $('.crc-popup.js-password-popup label.error.repeatNewPassword').html("Too short. Password length must be greater 6.")
      $('.crc-popup.js-password-popup label.error.repeatNewPassword').show().fadeOut(3000)
      state = false
    state
  @saveChangePassword = ()->
    old_password = @select('originPasswordSel').val()
    new_password = @select('newPasswordSel').val()
    confirm_password = @select('confirmPasswordSel').val()
    if @validate()
      $.ajax({
        type: "POST",
        url: "/identity/market_update",
        data: { identity: { old_password: old_password, password: new_password, password_confirmation: confirm_password } },
        success:(data) ->
          alert(data.message)
        error:(data) ->
          alert(data.message)
      })
      
  @after 'initialize', ->
    @on @select('passwordSel'), 'click', @togleChangePassword
    @on @select('resetPasswordModalCloseSel'), 'click', @togleChangePassword
    @on @select('savePasswordBtnSel'), 'click', @saveChangePassword