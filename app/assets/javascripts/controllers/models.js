var clearShowBox = function() {
  $('#search_field').val('');
  $('#search_field').typeahead('setQuery', '');
  $('.resultados').html("");
  $('.cajabusqueda').show('slow');
}

$( document ).ready(function() {
  $('.searchcateg,.showmodels,.editControls,#saveBtn,.cajabusqueda,.showmodels,.cajaediciones,.edicionbar,.botonmodelos').hide();
  $("#anfsh").click(function(e){
    $('#cajasearch1').show('slow');
    $('#class_id').val(1);
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
    e.preventDefault();
  });
  $("#avessh").click(function(e){
    $('#cajasearch2').show('slow');
    $('#class_id').val(2);
    $('#cajasearch1,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
    e.preventDefault();
  });
  $("#invsh").click(function(e){
    $('#cajasearch3').show('slow');
    $('#class_id').val(3);
    $('#cajasearch2,#cajasearch1,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $("#mamsh").click(function(e){
    $('#cajasearch4').show('slow');
    $('#class_id').val(4);
    $('#cajasearch2,#cajasearch3,#cajasearch1,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault(); 
  });
  $("#pecsh").click(function(e){
    $('#cajasearch5').show('slow');
    $('#class_id').val(5);
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch1,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $("#repsh").click(function(e){
    $('#cajasearch6').show('slow');
    $('#class_id').val(6);
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch1,#cajasearch7').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $("#plash").click(function(e){
    $('#cajasearch7').show('slow');
    $('#class_id').val(7);
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch1').hide('slow');
    clearShowBox();
     e.preventDefault();
  });
  $(".findbar").click(function(e){
          $('.showmodels, .cajabusqueda, .editControls, .edicionbar, .cajabusqueda, .botonmodelos, .cajaediciones').hide('slow');
          $("#editBtn").show();
          $("#saveBtn").hide();
          _mapVisorModule.deactivateEdition();
          _mapVisorModule.unloadReview();
          $('#species_id').val('');
          $('.selectores').show('slow');
          e.preventDefault();
  });
  $(".edicionbar").click(function(e){
      if($(".cajaediciones").is(":visible")){
        $(".cajaediciones").hide();
      }
      else{
        $(".cajaediciones").show();
      }
      
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

   $(".botonmodelos").click(function(e){
      if($(".showmodels").is(":visible")){
        $(".showmodels").hide();
      }
      else{
        $(".showmodels").show();
      }
      
      e.preventDefault();
  });



  // $("#species_src_btn").click(function(e){
  //         $('.selectores,.cajabusqueda').hide('slow');
  //         $('.showmodels').show('slow');
  //         //e.preventDefault();
  // });
  
  $('.searchcateg').click(function(e){
    $('.cajabusqueda').show('slow');
    $('.resultados').html("");
  });
});




