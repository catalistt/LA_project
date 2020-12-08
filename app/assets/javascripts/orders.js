$(document).on('turbolinks:load', function(){
  $(document).on('cocoon:after-insert', function(){

    $( ".add_item" ).select2({
      theme: "bootstrap"
    });
  });
});