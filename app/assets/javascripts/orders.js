$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    getDataCocoon();
    });
    getDataCocoon();
})

function getTotalAmount(parentContainer){
  /* Obtengo los valores de los containers de price, discount y quantity */
  var price = parentContainer.find('.p-price').val() || 0;
  var hidden_price = parentContainer.find('hidden-price');
  var discount = parentContainer.find('.p_discount').val() || 0;
  var quantity = parentContainer.find('.quantity').val() || 0;
  var group_discount = parentContainer.find('.group_discount').val() || 0;

  if(!isNaN(price) || !isNaN(discount) || !isNaN(quantity) || !isNaN(group_discount)) {
    /* Obtener el total, considerando el descuento y la cantidad*/
    var total_amount = parentContainer.find('.p_total_amount');
    var real_discount = 0
    if (group_discount > discount){
      real_discount = group_discount}
    else { 
      real_discount = discount;
    }
    var multiply = (price - (real_discount* price))* quantity;
    total_amount.val(Math.round(multiply));
    
    /* Obtengo el valor que está en el extra tax input y declaro el neto*/
    var extra_tax_input = parentContainer.find('.set-extra-tax');
    var net_amount_input = parentContainer.find('.set-net-amount');
    var extra_tax = parseFloat(extra_tax_input.val()) || 0;
    var net_amount = parseFloat(net_amount_input.val()) || 0;
    /* Obtener el neto y el monto de impto. extra */
    if(!isNaN(extra_tax) || !isNaN(multiply) || !isNaN(net_amount) || extra_tax !== "" || multiply !== "") {
      net_amount = parseFloat(multiply/(1+0.19+extra_tax));
      extra_tax = parseFloat(net_amount * extra_tax);
      extra_tax_input.val(extra_tax);
      net_amount_input.val(net_amount);}
    } 
  }

function getDataCocoon(){
  $('.st-product').on('change', function() {
    var parentContainer = $(this).parent().parent().parent().parent();
    var cost = parentContainer.find(".p-price").val();
    var hidden_price = parentContainer.find("hidden-price");
    var input_extra_tax = parentContainer.find(".set-extra-tax");
    var input_g_discount = parentContainer.find(".group_discount");
    var product_id= $(this).val();
      $.ajax({
        type:"GET",
        url:"/products/"+product_id+"/set_price",
        success:function(result){
          input_extra_tax.val(result.extra_tax);
          input_price.val(result.standard_price);
          if(cost !== 1){
            hidden_price.val(cost * result.cost + result.cost);
          }
        }
    })
    /* Obtener el descuento según grupo (por defecto) */
        var client_id= $('#order_client_id').val();
        $.ajax({
          type: "GET",
          url: "/clients/"+client_id+"/set_group",
          dataType: "json",
          success: function(result){
            var group_id = result;
            console.log(group_id);
            console.log(product_id);
            $.ajax({
              type: "GET",
              url: "/aut_discount",
              dataType: "json",
              data: {product_id: product_id, group_id: group_id},
              success: function(result){
                console.log(result[0].discount);
                input_g_discount.val(result[0].discount);
              }
            })
          }
        });
        

    getTotalAmount(parentContainer);
  });

  $('.p_discount').on('keyup', function() {
    var parentContainer = $(this).parent().parent().parent().parent();
    getTotalAmount(parentContainer);
  });
  
  $('.quantity').on('keyup', function() {
    var parentContainer = $(this).parent().parent().parent().parent();
    getTotalAmount(parentContainer);
  });

  $('.p-price').on('keyup', function() {
    var parentContainer = $(this).parent().parent().parent().parent();
    getTotalAmount(parentContainer);
  });
}



/* Que se active cocoon (nuevo producto) con enter */
function enter(){
  $('#add-button').on("enterKey",function(e){
    });
    $('#add-button').keyup(function(e){
    if(e.keyCode == 13)
    {
      $(this).trigger("enterKey");
    }
    });
  }  