$(document).on('turbolinks:load', function() {

$('#purchase_supplier_id').on('keyup change', function() { 
  $(document).on('cocoon:after-insert', function(){
    getDataCocoon();
    });
    getDataCocoon();
    function getDataCocoon(){
      $('.item-quantity').on('keyup change', function() {
        var parentContainer = $('.item-product').parent().parent().parent().parent();
        var input_price = parentContainer.find(".item-price");
        var input_quantity = parentContainer.find(".item-quantity");
        var product_id= $('.item-product').val();
        var product_total = parentContainer.find('.item-amount');
        var total_purchase = parentContainer.find(".total-purchase");
          $.ajax({
            type:"GET",
            url:"/products/"+product_id+"/set_price",
            dataType:"json",
            success:function(result){
              units = result.unit || 0;
              var price = input_price.val() || 0 ;
              var quantity = input_quantity.val() || 0;
              var multiply = units * price * quantity;
              product_total.val(multiply);
            } 
        })
      });
    }
    
    
});
});

