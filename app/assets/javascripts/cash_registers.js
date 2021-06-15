$(document).on('turbolinks:load', function() {
  $('.initial-cash').on('change', function(){
    var initial = $(this).val();
    $.ajax({
      type:"GET",
      url:"/cash_registers/new",
      dataType:"json",
      success:function(result){
      var final_cash = parseInt(initial) + parseInt(result.cash_in) - parseInt(result.cash_out)
      var final_cash_admin = parseInt(initial) + parseInt(result.cash_no_delivery) - parseInt(result.cash_out)
      $('.final-cash').val(final_cash.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
      $('.final-cash-admin').val(final_cash_admin.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
      }
    });
  });
});