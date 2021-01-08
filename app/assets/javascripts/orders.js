$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
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
      getTotalAmount($(this));
    });


    $('.quantity').on('keyup', function() {
      getTotalAmount($(this));
    });

    $('.p-price').on('keyup', function() {
      getTotalAmount($(this));
    });

    $('.discount').on('keyup', function() {
      getTotalAmount($(this));
    });

  })
})

function getTotalAmount(element){
  var parentContainer = element.parent().parent().parent().parent();
  var price = parentContainer.find('.p-price').val();
  var discount = parentContainer.find('.p_discount').val() || 0;
  var quantity = parentContainer.find('.quantity').val();
  if(!isNaN(price) || !isNaN(discount) || !isNaN(quantity)) {
    var total_amount = parentContainer.find('.p_total_amount');
    var multiply = (price - (discount* price))* quantity;
    total_amount.val(Math.round(multiply))
  }
}