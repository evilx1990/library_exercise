# disable button if any field is empty

$(document).on("turbolinks:load load", ->
  $("""input[value='Log in'],
    input[value='Sign up'],
    input[value='Send me reset password instructions'],
    input[value='Update']""").attr('disabled', true)

  switch $("input[type='submit']").val()
    when 'Log in'
      # sessions/new
      $('#user_email, #user_password').on 'input', ->
        $("input[value='Log in']").attr('disabled', checkFields())
    when 'Sign up'
      # registrations/new
      $("""#user_first_name, #user_last_name, #user_email,
        #user_password, #user_password_confirmation""").on 'input', ->
          $("input[value='Sign up']").attr('disabled', checkFields())
    when 'Update'
      # registrations/edit
      $("""#user_first_name, #user_last_name, #user_email,
        #user_password, #user_password_confirmation, #user_current_password""").on 'input', ->
          $("input[value='Update']").attr('disabled', checkFields())
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
      $('#user_password_confirmation'),
      $('#user_current_password')
    ]

    for i in [0...fields.length]
      if fields[i].val() == ''
        return true
    false
)
