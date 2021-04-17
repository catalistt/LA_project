$(document).on('turbolinks:load', function() {
  initOrderProduct();
  $("#client-select").select2({
    placeholder: "Buscar cliente",
    theme: 'classic',
    width: 'resolve'
   });
  $("#add_products").on('cocoon:after-insert', function(){
    disabledAllSelectedOptions();
    initOrderProduct();
    $(".list-products").select2({
      theme: 'classic',
      width: 'resolve'
     });
  });

  $(".list-products").select2({
    theme: 'classic',
    width: 'resolve'
   });
  updateOrders();
});

function updateOrders(){
  $("#update_orders").on("click", function(){
    var orders = [];
    $(".delivery_method_id").each(function(){
      var deliveryMethod = $(this);
      var orderDeliveryId = deliveryMethod.val();
      var orderId = deliveryMethod.data("oid");
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
      success: function(){
        Swal.fire({
          title: '¡Logrado!',
          text: 'Se asignaron los camiones a las ordenes exitosamente',
          icon: 'success',
          confirmButtonText: '¡Bacan!',
          timer: 3000
        });
        $('#assign-delivery-method-datatable').DataTable().ajax.reload();
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
  });
}

function disabledAllSelectedOptions(){
  $(".product option:not(:selected)").prop("disabled", false);
  var selectedOptions = $(".product option:selected");
  if(selectedOptions.length > 0){
    selectedOptions.each(function(){
      if($(this).val() !== ""){
        $("option[value=" + $(this).val() +"]").not(":selected").prop("disabled" , "disabled");
      }
    });
  }
}

function setProductInfo(){
  $('.product').on('change', function() {
    var productInput = $(this);
    var clientInput = $('#client-select');
    var clientId = clientInput.val();
    var selectedOption = productInput.val();
    if(clientId){
      var parentContainer = productInput.closest(".add_new_product");
      var quantityInput = parentContainer.find(".quantity");
      var priceInput = parentContainer.find(".price");
      var inputExtraTax = parentContainer.find(".extra_tax");
      var productId = parentContainer.find('.product').val();
      var productSelected = parentContainer.find('.product')
      var productCost = parentContainer.find(".product_cost");
      var groupDiscountInput = parentContainer.find(".group_discount");
      var unitPrice = parentContainer.find('.unit-price');
      $.ajax({
        type: "GET",
        url: "/products/" + productId + "/group_discount/" + clientId,
        success: function(product){
          window.thisProductStock = product.stock
          if(product.stock <= 0){
            Swal.fire({
              title: '¡Sin stock! Debes eliminar ese producto',
              text: 'Este producto no puede ser vendido. NO tiene stock.',
              icon: 'error',
              confirmButtonText: ':( Ok',
              timer: 6000
            });
          } 
          else{
          inputExtraTax.val(product.extra_tax);
          groupDiscountInput.val(product.discount);
          productCost.val(product.cost);
          var productUnit = product.unit;
          unitPrice.val(productUnit);
          priceInput.val(product.standard_price);
            if(quantityInput.val() === ""){
              quantityInput.val(1);
            }
            getTotalAmount(productInput);
          }}
      });
      disabledAllSelectedOptions();
    }
    else{
      Swal.fire({
        title: 'Error',
        text: 'Debes seleccionar un cliente primero y volver a seleccionar el producto',
        icon: 'error',
        confirmButtonText: 'Ok, entendido',
        timer: 3000
      });
      clientInput.addClass("error");
    }
  });
}

function getTotalAmount(element){
  /* Obtengo los valores de los containers de price, discount y quantity */
  var parentContainer = element.closest(".add_new_product");
  var priceInput = parentContainer.find(".price");
  var htmlUnit = parentContainer.find(".unit-price");
  var cost = parseFloat(parentContainer.find(".cost").val());
  var price = parseFloat(priceInput.val()) || 0;
  var discount = parseFloat(parentContainer.find('.discount').val()) || 0;
  var quantity = parseFloat(parentContainer.find('.quantity').val()) || 1;
  var pUnit = parseInt(parentContainer.find('.unit-price').val());

  /* Obtener el total, considerando el descuento y la cantidad*/
  var totalAmountInput = parentContainer.find('.total_product_amount');
  var total = price * quantity;
  if(cost !== 1){
    var productCost = parseFloat(parentContainer.find(".product_cost").val());
    total = ((productCost + (cost * productCost)) * quantity);}
  else 
    {var discount = parseFloat(parentContainer.find('.group_discount').val());
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
  var unit_amount = parseInt(totalAmountInput.val()) / parseInt(quantity) / parseInt(pUnit);
  htmlUnit.html("Unitario: $" + parseInt(unit_amount));
  };

function initOrderProduct(){
  setProductInfo();
  $('.discount').on('change', function(){
    getTotalAmount($(this));
  });

  $('.quantity').on('keyup change', function(){
    var quant = $(this).val() || 0;
    if(parseInt(quant) > parseInt(thisProductStock)){
      Swal.fire({
        title: 'Error de stock',
        text: 'Agregaste más unidades de las que hay en stock. Debes modificar la cantidad',
        icon: 'warning',
        confirmButtonText: 'Ok, entendido'
      });
    }
    else
      {getTotalAmount($(this));};
    if (quant%1 != 0){
      Swal.fire({
        title: 'Error de tipeo',
        text: 'Agregaste decimales. Corrige la cantidad, por favor',
        icon: 'warning',
        confirmButtonText: 'Ok, entendido'
      });
    }
  });

  $('.cost').on('change', function(){
    getTotalAmount($(this));
  });
  $("#order_client_id").on('change', function(){
    $(this).removeClass("error");
  });
}

