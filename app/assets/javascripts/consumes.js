$(document).on('turbolinks:load', function() {

  $(".name-select").select2({
    placeholder: "Buscar trabajador",
    theme: 'classic',
    width: 'resolve'
   });


  $('.consume-quantity, .consume-item').on('change', function() {
    var item = $('.consume-item').val();
    var quantity = $('.consume-quantity').val();
    $.ajax({
      type:"GET",
      url:"/resources/resource_amount",
      data: {resource_id: item}, 
      dataType:"json",
      success:function(result){
      var total = parseInt(result) * parseInt(quantity);
      if (isNaN(total)){
        total = 0
      };
      console.log(total);
      $('.consume-amount').val(total);
    }
  });
  });

});