// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require jquery-validation/dist/jquery.validate.js
//= require jquery.rut/jquery.rut.js
//= require cocoon
//= require datatables.net/js/jquery.dataTables
//= require datatables.net-bs4/js/dataTables.bootstrap4
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require highcharts
//= require chartkick
//= require flatpickr
//= require select2
//= require turbolinks
//= require_tree .


$(document).on('turbolinks:load', function(){
  $('#js-searchable-payment').select2({
    allowClear: true,
    placeholder: "Digita n° de orden o cliente",
  });
  $('#js-searchable-stock').select2({
    allowClear: true,
    placeholder: "Digita código o nombre",
  });
  $(document).on('cocoon:after-insert', function(){

    $('#js-searchable-order').select2({
      allowClear: true,
      placeholder: "Digita código o nombre",
    });
  });
});

