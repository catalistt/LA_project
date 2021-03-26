$(document).on('turbolinks:load', function() {
  initOrderProduct();
  $("#add_products").on('cocoon:after-insert', function(){
    initOrderProduct();
  });
  updateOrders();
});

function updateOrders(){
  $("#update_orders").on("click", function(){
    var orders = [];
    $(".order-container").each(function(){
      var order = $(this);
      var orderId = order.find(".order_id").val();
      var orderDeliveryId = order.find(".delivery_method_id").val();
      if(orderId !== "" && orderDeliveryId !== ""){
        orders.push({ id: orderId, delivery_method_id: orderDeliveryId });
      }
    });
    $.ajax({
      type: "PUT",
      url: "/orders/update_all",
      data: { order: {
        orders: orders
        }
      },
      success: function(response){
        $("#edit_orders").html(response);
        Swal.fire({
          title: '¡Logrado!',
          text: 'Se asignaron los camiones a las ordenes exitosamente',
          icon: 'success',
          confirmButtonText: '¡Bacan!',
          timer: 3000
        });
      },
      error: function(){
        Swal.fire({
          title: '¡Error!',
          text: 'Hubo un problema asignando las órdenes',
          icon: 'error',
          confirmButtonText: ':( Ok',
          timer: 3000
        });
      }
    });
  })
}

function setProductInfo(){
  $('.product').on('change', function() {
    var productInput = $(this);
    var clientInput = $('#order_client_id');
    var clientId = clientInput.val();
    if(clientId){
      var parentContainer = productInput.closest(".add_new_product");
      var quantityInput = parentContainer.find(".quantity");
      var priceInput = parentContainer.find(".price");
      var inputExtraTax = parentContainer.find(".extra_tax");
      var productId = parentContainer.find('.product').val();
      var productCost = parentContainer.find(".product_cost");
      var groupDiscountInput = parentContainer.find(".group_discount");
      $.ajax({
        type: "GET",
        url: "/products/" + productId + "/group_discount/" + clientId,
        success: function(product){
          console.log(product);
          inputExtraTax.val(product.extra_tax);
          groupDiscountInput.val(product.discount);
          productCost.val(product.cost);
          priceInput.val(product.standard_price);
          if(quantityInput.val() === ""){
            quantityInput.val(1);
          }
          getTotalAmount(productInput);
        }
      });
    }
    else{
      alert("Tienes que seleccionar un cliente primero");
      clientInput.addClass("error");
    }
  });
}

function getTotalAmount(element){
  /* Obtengo los valores de los containers de price, discount y quantity */
  var parentContainer = element.closest(".add_new_product");
  var priceInput = parentContainer.find(".price");
  var cost = parseFloat(parentContainer.find(".cost").val());
  var price = parseFloat(priceInput.val()) || 0;
  var discount = parseFloat(parentContainer.find('.discount').val()) || 0;
  var quantity = parseFloat(parentContainer.find('.quantity').val()) || 1;
  var groupDiscount = parseFloat(parentContainer.find('.group_discount').val()) || 0;

  /* Obtener el total, considerando el descuento y la cantidad*/
  var totalAmountInput = parentContainer.find('.total_product_amount');
  var total = price * quantity;
  if(cost !== 1){
    var productCost = parseFloat(parentContainer.find(".product_cost").val());
    console.log(cost, productCost);
    total = (productCost + (cost * productCost));}
  else 
    {var discount = parseFloat(parentContainer.find('.group_discount').val());
     console.log(discount);
     total = (total - discount*total); }

  totalAmountInput.val(Math.round(total));

  /* Obtengo el valor que está en el extra tax input y declaro el neto*/
  var extraTaxInput = parentContainer.find('.extra_tax');
  var netAmountInput = parentContainer.find('.net_amount');
  var extraTax = parseFloat(extraTaxInput.val()) || 0;
  var netAmount = parseFloat(netAmountInput.val()) || 0;
  /* Obtener el neto y el monto de impto. extra */

  netAmount = total/(1.19 + extraTax);
  extraTax = netAmount * extraTax;
  extraTaxInput.val(extraTax);
  netAmountInput.val(netAmount);
}

function initOrderProduct(){
  setProductInfo();
  $('.discount').on('change', function(){
    getTotalAmount($(this));
  });
  $('.quantity').on('keyup', function(){
    getTotalAmount($(this));
  });
  $('.cost').on('change', function(){
    getTotalAmount($(this));
  });
  $("#order_client_id").on('change', function(){
    $(this).removeClass("error");
  });
}