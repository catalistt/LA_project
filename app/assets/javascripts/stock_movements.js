$(document).on('turbolinks:load', function() {

  $('.stock-product').on('keyup change', function(){
    var product_id= $(this).val();
    $.ajax({
      type:"GET",
      url:"/products/"+product_id+"/set_product_stock",
      dataType:"json",
      success:function(result){
      $('.initial-stock').val(result) || 0;
      console.log(result)
     }
    });
  });
});
