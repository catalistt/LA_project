$(document).on('turbolinks:load', function() {
  $(".responsable").select2({
    placeholder: "Buscar usuario",
    theme: 'classic',
    width: 'resolve'
   });
});