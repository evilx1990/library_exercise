# disable button if any field is empty

$(document).on "turbolinks:load", ->
  $("""input[value='Log in'],
       input[value='Sign up'],
       input[value='Send me reset password instructions']""").attr('disabled', true)

  switch $("input[type='submit']").val()
    when 'Log in'
      # sessions/new
      $('#user_email, #user_password').on 'keyup', ->
        $("input[value='Log in']").attr('disabled', checkFields())
    when 'Sign up'
      # registrations/new
      $('#user_first_name, #user_last_name, #user_email, #user_password, #user_password_confirmation').on 'keyup', ->
        $("input[value='Sign up']").attr('disabled', checkFields())
    when 'Send me reset password instructions'
      # passwords/new
      $('#user_email').on 'keyup', ->
        $("input[value='Send me reset password instructions']").attr('disabled', checkFields())


  checkFields = () ->
    fields = [
      $('#user_first_name'),
      $('#user_last_name'),
      $('#user_email'),
      $('#user_password'),
      $('#user_password_confirmation')
    ]

    for i in [0...fields.length]
      if fields[i].val() == ''
        return true
    false
