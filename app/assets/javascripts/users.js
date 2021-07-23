$(document).on('turbolinks:load', function() {
  //$("#user_rut").rut({formatOn: "keyup"});
  validateUserForm();
});

function validateUserForm(){
  $("#user_form").validate({
    debug: false,
    errorClass: "error",
    validClass: "success",
    errorElement: "small",
    rules: {
      'user[name]': "required",
      'user[email]': "required",
      'user[password]': "required",
      'user[rut]': {
        required: true,
        validateRut: function(){
          var userRut = $('#user_rut').val();
          return userRut.length
        },
      }
    },
    messages: {
      'user[name]': {
        required: "Este campo es obligatorio"
      },
      'user[rut]': {
        required: "Este campo es obligatorio"
      }
    }
  });
}