$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    $('.item-quantity').on('keyup',  getItemProduct);
    $('.item-price').on('keyup',  getItemProduct);
    $('.item-product').on('change',  getItemProduct);
  });
});

function getItemProduct(){
  var parentContainer = $(this).closest(".items_container");
  var productSelect = parentContainer.find('.item-product');
  var productId = productSelect.val();
  if(productId == ""){
    alert("Tienes que seleccionar un producto primero");
    productSelect.addClass("error");
  }
  else{
    productSelect.removeClass("error");
    var inputPrice = parentContainer.find(".item-price");
    var inputQuantity = parentContainer.find(".item-quantity");
    var inputItemTotal = parentContainer.find('.item-total');
    var purchaseInput = $("#purchase_total_amount");
    $.ajax({
      type: "GET",
      url: "/products/" + productId,
      dataType: "json",
      success: function(product){
        var units = product.units || 0;
        var totalPurchase = parseFloat(purchaseInput.val()) || 0;
        var price = parseFloat(inputPrice.val()) || 0 ;
        var quantity = parseFloat(inputQuantity.val()) || 1;
        var parcialTotal = units * price * quantity;
        var total = parcialTotal + totalPurchase;
        inputPrice.val(price);
        inputQuantity.val(quantity);
        inputItemTotal.val(parcialTotal);
        purchaseInput.val(total);
        $("#invoice-total").text("$ " + total);
      }
    });
  }
}
