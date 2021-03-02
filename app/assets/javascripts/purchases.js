$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(e,insertedItem){
    $('.item-quantity').on('keyup', function(){
      getItemTotal(insertedItem);
    });
    $('.item-price').on('keyup',  function(){
      getItemTotal(insertedItem);
    });
    $('.item-product').on('change', function(){
      setProduct(insertedItem);
      getTotal();
    });
  });
});



function setProduct(insertedContainer){
  var container = $(insertedContainer);
  var productSelect = container.find('.item-product');
  var productId = productSelect.val();
  if(productId == ""){
    alert("Tienes que seleccionar un producto primero");
    productSelect.addClass("error");
  }
  else{
    productSelect.removeClass("error");
    var inputPrice = container.find(".item-price");
    var inputQuantity = container.find(".item-quantity");
    var unitsInput = container.find(".item-units");
    var inputItemTotal = container.find('.item-total');
    $.ajax({
      type: "GET",
      url: "/products/" + productId,
      dataType: "json",
      success: function(product){
        var units = product.units || 0;
        var price = parseFloat(inputPrice.val()) || 0 ;
        var quantity = parseFloat(inputQuantity.val()) || 1;
        var itemTotal = units * price * quantity;
        inputPrice.val(price);
        inputQuantity.val(quantity);
        unitsInput.val(units);
        inputItemTotal.val(itemTotal);
      }
    });
  }
}

function getItemTotal(insertedContainer){
  var container = $(insertedContainer);
  var price = container.find(".item-price").val() || 0;
  var quantity = container.find(".item-quantity").val() || 0;
  var units = container.find(".item-units").val() || 0;
  var itemTotal = parseFloat(price) * parseFloat(quantity) * parseFloat(units);
  container.find(".item-total").val(itemTotal);
  getTotal();
}

function getTotal(){
  var containers = $(".items_container");
  var total = 0;
  containers.each(function(){
    var itemTotalInput = $(this).find(".item-total").val();
    total = total + parseFloat(itemTotalInput || 0);
  });
  $("#purchase_total_amount").val(total);
  $("#invoice-total").text("$ " + total);
}
