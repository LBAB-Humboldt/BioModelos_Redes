var clearShowBox = function() {
  $('#search_field').val('');
  $('#search_field').typeahead('setQuery', '');
  $('.resultados').html("");
  $('.cajabusqueda').show('slow');
}

$( document ).ready(function() {
  $('.searchcateg,.showmodels,.editControls,#saveBtn,.cajabusqueda,.selectores,.showmodels').hide();
  $("#anfsh").click(function(e){
    $('#cajasearch1').show('slow');
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
    e.preventDefault();
  });
  $("#avessh").click(function(e){
    $('#cajasearch2').show('slow');
    $('#cajasearch1,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
    e.preventDefault();
  });
  $("#invsh").click(function(e){
    $('#cajasearch3').show('slow');
    $('#cajasearch2,#cajasearch1,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $("#mamsh").click(function(e){
    $('#cajasearch4').show('slow');
    $('#cajasearch2,#cajasearch3,#cajasearch1,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault(); 
  });
  $("#pecsh").click(function(e){
    $('#cajasearch5').show('slow');
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch1,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $("#repsh").click(function(e){
    $('#cajasearch6').show('slow');
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch1,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $("#plash").click(function(e){
    $('#cajasearch7').show('slow');
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch1').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $(".findbar").click(function(e){
          $('.showmodels, .cajabusqueda, .editControls').hide('slow');
          $("#editBtn").show();
          $("#saveBtn").hide();
          _mapVisorModule.deactivateEdition();
          $('.selectores').show('slow');
          e.preventDefault();
  });
  $("#editBtn").click(function(e){
          $("#editBtn").hide();
          $("#saveBtn").show();
          e.preventDefault();
  });
  $("#saveBtn").click(function(){
        var newGeoJSON = _mapVisorModule.saveEdition();
        if(newGeoJSON)
          $("#review_geoJSON").val(_mapVisorModule.saveEdition());
        else
          return false; 
  });
  
  $('.searchcateg').click(function(e){
    $('.cajabusqueda').show('slow');
    $('.resultados').html("");
  });
});




