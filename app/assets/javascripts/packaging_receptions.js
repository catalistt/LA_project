$(document).on('turbolinks:load', function() {
  $("#client-select-packaging").select2({
    placeholder: "Buscar cliente",
    theme: 'classic',
    width: 'resolve'
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
});