//  $(document).on('turbolinks:load', function() {
//  $("#client_rut").rut({formatOn: "keyup"});
//  $.validator.addMethod("validateRut", function(value, element) {
//    console.log(value);
//   return this.optional(element) || $.validateRut(value);
//  }, "Rut inválido");
//  validateClientForm();
//});

/*function validateClientForm(){
  $("#client_form").validate({
    debug: true,
    errorClass: "error",
    validClass: "success",
    errorElement: "small",
    rules: {
      'client[business_name]': "required",
      'client[line_of_business]': "required",
      'client[city_id]': "required",
      'client[commune_id]': "required",
      'client[address]': "required",
      'client[group_id]': "required",
      'client[user_id]': "required",
      'client[rut]': {
        required: true,
        validateRut: function(){
          var clientRut = $('#client_rut').val();
          return clientRut.length
        },
      }
    },
    messages: {
      'client[business_name]': {
        required: "Este campo es obligatorio"
      },
      'client[city_id]': {
        required: "Este campo es obligatorio"
      },
      'client[line_of_business]': {
        required: "Este campo es obligatorio"
      },
      'client[commune_id]': {
        required: "Este campo es obligatorio"
      },
      'client[address]': {
        required: "Este campo es obligatorio"
      },
      'client[group_id]': {
        required: "Este campo es obligatorio"
      },
      'client[user_id]': {
        required: "Este campo es obligatorio"
      },
      'client[rut]': {
        required: "Este campo es obligatorio"
      }
    }
  });
//}
*/