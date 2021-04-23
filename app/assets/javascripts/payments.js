$(document).on('turbolinks:load', function() {
  $("#unpaid-select").select2({
    placeholder: "Elegir orden",
    theme: 'classic',
    width: 'resolve'
   });
  $('.order-payment').on('keyup change', function(){
    order_id = $(this).val();
    $.ajax({
      type:"GET",
      url:"/payments/set_pendings",
      data: {order_id: order_id}, 
      dataType:"json",
      success:function(result){
      console.log(result)
      var order_pending = Math.round(result.order_amount - result.order_payments - result.order_discount)
      var client_pending = Math.round(result.client_buyed - result.client_payments - result.client_discounts)
      $('.order-payment-status').val(order_pending.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
      $('.client-payment-status').val(client_pending.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
     }
    });
  });
});
