$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    $('.st-product').find("select").on('change', function() {
      var product = $('.st-product').find("select").val()
      console.log(product);
        $.ajax({
          url: "st_price"
          //success: function(result) {
          //    var pokeName = result.name
      })      
    })
  })
})
