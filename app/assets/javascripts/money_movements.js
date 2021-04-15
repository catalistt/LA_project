$(document).on('turbolinks:load', function() {
  $("#money-select").select2({
    placeholder: "Categoría",
    theme: 'classic',
    width: 'resolve'
   });
   $("#user-money").select2({
    placeholder: "Usuario",
    theme: 'classic',
    width: 'resolve'
   });
  });
