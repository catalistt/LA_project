$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    $('.st-product').find("select").on('change', function() {
      var product_id= $('.st-product').find("select").val()
        $.ajax({
          type:"GET",
          url:"/products/"+product_id+"/set_price",
          dataType:"json",
          success:function(result){
            var input_price = document.getElementById('p-price');
            var input_packaging = document.getElementById('packaging');
            input_price.value = result;
            input_packaging.value = 0;
          }
      })
    });
    $('#quantity').on('change', function() {
      var p_quatity = $(this).val()
      console.log(p_quatity);
    }); 
    $('.discount').find("select").on('change', function() {
      var p_discount= $('.discount').find("select").val()
      console.log(p_discount);  
    });
  })
})