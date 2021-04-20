$(document).on('turbolinks:load', function() {
  $("#client-select-packaging").select2({
    placeholder: "Buscar cliente",
    theme: 'classic',
    width: 'resolve'
   });  
    $('#quantity_pack').on('change', function() {
      var this_packaging = $('#convertion').val();
      var this_quantity = $(this).val();
        $.ajax({
          type: "GET",
          url:"/packaging_convertions/pack_info",
          data: {packaging_convertion_id: this_packaging}, 
          dataType:"json",
          success: function(amount_pack){
            var pack_multiply = parseInt(amount_pack) * parseInt(this_quantity);
            $('#total_pack').val(pack_multiply);
            console.log(pack_multiply);
          }
        });
      });

      $('#convertion').on('change', function() {
        $('#quantity_pack').val("");
        $('#total_pack').val("");
      });
});