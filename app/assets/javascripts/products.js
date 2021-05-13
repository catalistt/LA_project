$(document).on('turbolinks:load', function() {
  validateProductForm();
});

function validateProductForm(){
  $("#product_form").validate({
    errorClass: "error",
    validClass: "success",
    errorElement: "small",
    rules: {
      'product[name]': "required",
      'product[code]': "required",
      'product[cost]': "required",
      'product[standard_price]': "required"
    },
    messages: {
      'product[name]': {
        required: "Este campo es obligatorio"
      },
      'product[code]': {
        required: "Este campo es obligatorio"
      },
      'product[cost]': {
        required: "Este campo es obligatorio"
      },
      'product[standard_price]': {
        required: "Este campo es obligatorio"
      }
    }
  });
}