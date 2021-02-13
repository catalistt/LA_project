$(document).on('turbolinks:load', function() {
  $('.order-payment').on('keyup change', function(){
    order_id = $(this).val();
    $.ajax({
      type:"GET",
      url:"/payments/set_pendings",
      data: {order_id: order_id}, 
      dataType:"json",
      success:function(result){
      var order_pending = result.order_amount - result.order_payments
      var client_pending = result.client_buyed - result.client_payments
      $('.order-payment-status').val(order_pending.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
      $('.client-payment-status').val(client_pending.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
     }
    });
  });
});
