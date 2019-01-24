$(document).on "turbolinks:load", ->
  if $('#user_email, #user_password, #user_password_confirmation').val() == ''
    $("""input[value='Log in'],
         input[value='Sign up'],
         input[value='Send me reset password instructions']""").attr('disabled', true)

  switch $("input[type='submit']").val()
    when 'Log in'
      # sessions/new
      # isable 'Log in' button if any of fields is empty
      $('#user_email, #user_password').on 'keyup', ->
        if $('#user_email').val() == '' || $('#user_password').val() == ''
          $("input[value='Log in']").attr('disabled', true)
        else
          $("input[value='Log in']").attr('disabled', false)
    when 'Sign up'
      # registrations/new
      # disable 'Sign up' button if any of fields(email, pass, confim_pass) is empty
      $('#user_email, #user_password, #user_password_confirmation').on 'keyup', ->
        if $('#user_email').val() == '' || $('#user_password').val() == '' || $('#user_password_confirmation').val() == ''
          $("input[value='Sign up']").attr('disabled', true)
        else
          $("input[value='Sign up']").attr('disabled', false)
    when 'Send me reset password instructions'
      # passwords/new
      # disable 'Send me...' button if field is empty
      $('#user_email').on 'keyup', ->
        if $('#user_email').val() == ''
          $("input[value='Send me reset password instructions']").attr('disabled', true)
        else
          $("input[value='Send me reset password instructions']").attr('disabled', false)