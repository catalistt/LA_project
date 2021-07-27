$(document).on('turbolinks:load', function() {

  $('.stock-product').on('keyup change', function(){
    var product_id= $(this).val();
    $.ajax({
      type:"GET",
      url:"/products/"+product_id+"/set_product_stock",
      dataType:"json",
      success:function(result){
      $('.initial-stock').val(result) || 0;
     }
    });
  });

  $(".stock-product").select2({
    placeholder: "Buscar producto",
    theme: 'classic',
    width: 'resolve'
   });

  $('.quantity-stock').on('keyup change', function(){
    var quantity_st = parseInt($(this).val());
    var initial_st = parseInt($('.initial-stock').val());
    var move_type = $('.move-type').val();
    var total =  0;
    $('.id-document').val(0);
    if(move_type == "Suma de stock manual"){
      total = initial_st + quantity_st;
    }
    else{
      total = initial_st - quantity_st;
    };
    $('.final-stock').val(total);
  });
});
