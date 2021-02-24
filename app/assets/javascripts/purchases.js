$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    getItemProduct();
  });
});

function getItemProduct(){
  $('.item-quantity').on('keyup', function() {
    var parentContainer = $('.item-product').closest(".items_container");
    var inputPrice = parentContainer.find(".item-price");
    var inputQuantity = parentContainer.find(".item-quantity");
    var productId = parentContainer.find('.item-product').val();
    var productTotal = parentContainer.find('.item-amount');
    var totalPurchase = parentContainer.find(".total-purchase");
      $.ajax({
        type:"GET",
        url:"/products/"+ productId,
        success:function(product){
          units = product.unit || 0;
          var price = parseFloat(inputPrice.val()) || 0 ;
          var quantity = parseFloat(inputQuantity.val()) || 1;
          var total = units * price * quantity;
          productTotal.val(total);
        }
    })
  });
}
