$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    $('.st-product').on('change', function() {
      var parent_container = $(this).parent(".products_container")
      var input_price = $(this).siblings(".p-price")
      var input_packaging = $(this).siblings('.packaging');
      var product_id= $(this).val();
      debugger;
        $.ajax({
          type:"GET",
          url:"/products/"+product_id+"/set_price",
          dataType:"json",
          success:function(result){
            input_price.val(result);
            input_packaging.val(0);
            
          }
      })    
    });


    $('.quantity').on('change', function() {
      getTotalAmount();
    });

    $('.p-price').on('change', function() {
      getTotalAmount();
    });

    $('.discount').on('change', function() {
      getTotalAmount();
    });

  })
})

function getTotalAmount(){
  var price = $(this).siblings('.p-price');
  var discount = $(this).siblings('.p_discount');
  var quantity = $(this).siblings('.quantity');
  if(!isNaN(price) || !isNaN(discount) || !isNaN(quantity)) {
    var total_amount = $(this).siblings('.p_total_amount');
    var multiply = (price - (discount* price))* quantity;
    total_amount.val(Math.round(multiply))
  }
}