$(document).on('turbolinks:load', function() {
  $("#client-select-packaging").select2({
    placeholder: "Buscar cliente",
    theme: 'classic',
    width: 'resolve'
   });  

   $(".pack-bool").on('change', function(){
     var packBoolean = $(this).val();
     console.log(packBoolean);
     if(packBoolean == "Sí"){
      var client = parseInt($('#client-select-packaging').val());
      console.log(client);
      $.ajax({
        type: "GET",
        url: "/orders/order_pack_amount",
        data: {client_id: client},
        dataType:"json",
        success: function(result){
          $(".total_box_amount").val(result);
        }
     });
     }
     else{
      $(".pack-show").removeClass('hidden');
      console.log("tt");
     };
   });






    $('.quant_pack').on('change', function() {
      var packParent= $(this).closest(".parent");
      console.log(packParent);
      var quantPack = packParent.find(".quant_pack");
      console.log(quantPack.val());
      var packCost = packParent.find(".pack_cost").html();
      console.log(packCost);
      var amountPack = packParent.find(".amount_pack");
      var packMultiply = parseInt(packCost)*parseInt(quantPack.val())
      console.log(packMultiply);
      amountPack.val(packMultiply);
      var containers = $(".parent");
      var total = 0;
      containers.each(function(){
        var packsAmounts = $(this).find(".amount_pack").val();
        total = total + parseFloat(packsAmounts || 0);
      });
      $(".total_box_amount").val(total);
      });

      $(".pack-form").on("click", function(){
        var delivery = $(".pack-delivery").val();
        var client = $('#client-select-packaging').val();
        var turn = $('.pack-turn').val();
       if(delivery== ""){
        Swal.fire({
          title: 'Error',
          text: 'Debes seleccionar un camión',
          icon: 'error',
          confirmButtonText: 'Ok, entendido'
        });
       }
       if(client== ""){
        Swal.fire({
          title: 'Error',
          text: 'Debes seleccionar un cliente',
          icon: 'error',
          confirmButtonText: 'Ok, entendido'
        });
       }
       if(turn== ""){
        Swal.fire({
          title: 'Error',
          text: 'Debes seleccionar una vuelta',
          icon: 'error',
          confirmButtonText: 'Ok, entendido'
        });
       }
      }
      );
});