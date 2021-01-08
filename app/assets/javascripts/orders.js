$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    $('.st-product').find("select").on('change', function() {
      var product_id= $('.st-product').find("select").val()
      console.log(product_id);
        $.ajax({
          type:"GET",
          url:"products/"+product_id+"/set_price",
          dataType:"json",
          success:function(result){
            alert(result);
            console.log(result); 
          }
      })
    })
  })
})