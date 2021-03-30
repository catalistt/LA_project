var assignDeliveryMethodDatatable;
initDatatable(assignDeliveryMethodDatatable, '#assign-delivery-method-datatable');
var ordersDatatable;
initDatatable(ordersDatatable, '.orders-datatable');
var deliveryOrdersDatatable;
initDatatable(deliveryOrdersDatatable, '.delivery-orders-datatable');

function initDatatable(datatable, element){
    $(document).on('turbolinks:before-cache', function(){
      if (datatable) {
        datatable.destroy();
      }
    });
    $(document).on('turbolinks:load', function() {
      $('.date-filter').datepicker({
        format: 'dd/mm/yyyy',
        language: 'es'
      });
      $('.date-filter').on('change', function(){
        datatable.draw();
      });
      datatable = $(element).DataTable({
        sPaginationType: 'full_numbers',
        bSort: true,
        Processing: true,
        bServerSide: true,
        bDestroy: true,
        sAjaxSource: $(element).data('source'),
        fnServerData: function (sSource, aoData, fnCallback){
           start_date = $('#f_start_date').val()
           if(start_date != null){
            aoData.push({'name': 'f_start_date', 'value': start_date});
           }
           end_date = $('#f_end_date').val()
           if(end_date != null){
            aoData.push({'name': 'f_end_date', 'value': end_date});
           }
           $.getJSON(sSource, aoData, function(json){
            fnCallback(json);
           });
        },
        oLanguage: {
          sProcessing:     'Procesando...',
          sLengthMenu:     'Mostrar : _MENU_',
          sZeroRecords:    'No se encontraron resultados',
          sEmptyTable:     'Ningún dato disponible en esta tabla',
          sInfo:           '_START_ / _END_ de _TOTAL_',
          sInfoEmpty:      'Registros del 0 al 0 de un total de 0 registros',
          sInfoFiltered:   '',
          sInfoPostFix:    '',
          sSearch:         '',
          sSearchPlaceholder: 'Buscar',
          sUrl:            '',
          sInfoThousands:  ',',
          sLoadingRecords: 'Cargando...',
          oAria: {
            sSortAscending:  ': Activar para ordenar la columna de manera ascendente',
            sSortDescending: ': Activar para ordenar la columna de manera descendente'
          },
          oPaginate: {
            sFirst: 'Primero',
            sLast: 'Último',
            sNext: 'Siguiente',
            sPrevious: 'Anterior'
          },
        }
      });
    });
    var datatable;
  }