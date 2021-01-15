$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    getDataCocoon();
    })
    getGroupId();
    getDataCocoon();
})

function getTotalAmount(parentContainer){
  var price = parentContainer.find('.p-price').val();
  var discount = parentContainer.find('.p_discount').val() || 0;
  var quantity = parentContainer.find('.quantity').val();
  if(!isNaN(price) || !isNaN(discount) || !isNaN(quantity)) {
    var total_amount = parentContainer.find('.p_total_amount');
    var multiply = (price - (discount* price))* quantity;
    total_amount.val(Math.round(multiply))
  }
}

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
}

function getDataCocoon(){
  $('.st-product').on('change', function() {
    var parentContainer = $(this).parent().parent().parent().parent();
    var input_price = parentContainer.find(".p-price")
    var input_packaging = parentContainer.find('.packaging');
    var product_id= $(this).val();
      $.ajax({
        type:"GET",
        url:"/products/"+product_id+"/set_price",
        dataType:"json",
        success:function(result){
          input_price.val(result);
          input_packaging.val(0);
          
        }
    })
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

  $('.discount').on('change', function() {
    var parentContainer = $(this).parent().parent();
    getTotalAmount(parentContainer);
  });

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
}
