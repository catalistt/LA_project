$(document).on('turbolinks:load', function() {
  $(document).on('cocoon:after-insert', function(){
    $('.st-product').find("select").on('change', function() {
      var product = $('.st-product').find("select").val()
      console.log(product);
        $.ajax({
          type: 'GET',
          url: "st_price",
          data: {product},
          success: function(result) {
          console.log(result)
      }})
    })
  })
})
