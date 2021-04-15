$(document).on('turbolinks:load', function() {

  $(".date-range").flatpickr({
    mode: "range",
    dateFormat: "d-m-Y",
    defaultDate: ["01-04-2021", "today"]
  }); 

  $("#consume-dates").on("click", function(){
    var dates_values = $('.date-range').val();
    var dates_array = dates_values.split(" ");
    var init_date = dates_array[0];
    var finish_date = dates_array[2];
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