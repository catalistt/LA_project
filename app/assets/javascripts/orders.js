$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    getDataCocoon();
    })
    getGroupId();
    getDataCocoon();
})

function getTotalAmount(parentContainer){
  /* Obtengo los valores de los containers de price, discount y quantity */
  var price = parentContainer.find('.p-price').val();
  var discount = parentContainer.find('.p_discount').val() || 0;
  var quantity = parentContainer.find('.quantity').val();

  if(!isNaN(price) || !isNaN(discount) || !isNaN(quantity)) {
    /* Obtener el total, considerando el descuento y la cantidad*/
    var total_amount = parentContainer.find('.p_total_amount');
    var multiply = (price - (discount* price))* quantity;
    total_amount.val(Math.round(multiply));
    
    /* Obtengo el valor que está en el extra tax input y declaro el neto*/
    var extra_tax_input = parentContainer.find('.set-extra-tax');
    var net_amount_input = parentContainer.find('.set-net-amount');
    var extra_tax = parseFloat(extra_tax_input.val());
    var net_amount = parseFloat(net_amount_input.val()) || 0;
    /* Obtener el neto y el monto de impto. extra */
    if(!isNaN(extra_tax) || !isNaN(multiply) || !isNaN(net_amount) || extra_tax !== "" || multiply !== "") {
      debugger;
      net_amount = parseFloat(multiply/(1+0.19+extra_tax));
      extra_tax = parseFloat(net_amount * extra_tax);
      extra_tax_input.val(extra_tax);
      net_amount_input.val(net_amount);}
    } 
  }

function getDataCocoon(){
  $('.st-product').on('change', function() {
    var parentContainer = $(this).parent().parent().parent().parent();
    var input_price = parentContainer.find(".p-price");
    var input_extra_tax = parentContainer.find(".set-extra-tax");
    var input_packaging = parentContainer.find('.packaging');
    var product_id= $(this).val();
      $.ajax({
        type:"GET",
        url:"/products/"+product_id+"/set_price",
        dataType:"json",
        success:function(result){
          console.log(result);
          input_price.val(result.standard_price);
          input_packaging.val(0);
          input_extra_tax.val(result.extra_tax);
        }
    })
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

/* Obtener el descuento según grupo (por defecto) */
function getGroupId(){
  $('#order_client_id').on('change', function() {
    var client_id= $(this).val();
    $.ajax({
      type: "GET",
      url: "/clients/"+client_id+"/set_group",
      dataType: "json",
      success: function(result){
        var group_id = result;
        console.log(group_id);
      }
    })
  });
};

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