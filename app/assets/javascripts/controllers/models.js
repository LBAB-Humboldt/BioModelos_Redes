$( document ).ready(function() {

  var clearShowBox = function() {
    $('#search_field').val('');
    $('#search_field').typeahead('setQuery', '');
    //$('.resultados').html("<small><a href='/listado.html' target='_blank'>Listado de especies</a></small>");
    $('.cajabusqueda').show('slow');
  }

  var editButtonsOff = function(){
    $("#editBtn").show();
    $("#cancBtn").hide();
  }

  $('.searchcateg,.showmodels,.editControls,#cancBtn,.cajabusqueda,.showmodels,.cajaediciones,.edicionbar,.botonmodelos').hide();
  $("#anfsh").click(function(e){
    $('#cajasearch1').show('slow');
    $('#class_id').val(1);
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
    $('.resultados').load('../anflist.html');
    e.preventDefault();
  });
  $("#avessh").click(function(e){
    $('#cajasearch2').show('slow');
    $('#class_id').val(2);
    $('#cajasearch1,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch7').hide('slow');
    clearShowBox();
    $('.resultados').load('../aveslist.html');
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
    $('.resultados').load('../mamlist.html');
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
    $('.resultados').load('../replist.html');
     e.preventDefault();
  });
  $("#plash").click(function(e){
    $('#cajasearch7').show('slow');
    $('#class_id').val(7);
    $('#cajasearch2,#cajasearch3,#cajasearch4,#cajasearch5,#cajasearch6,#cajasearch1').hide('slow');
    clearShowBox();
    $('.resultados').load('../plantlist.html');
     e.preventDefault();
  });
  $(".findbar").click(function(e){
          e.preventDefault();
          $('.showmodels, .cajabusqueda, .editControls, .edicionbar, .cajabusqueda, .botonmodelos, .cajaediciones').hide('slow');
          editButtonsOff();
          _mapVisorModule.deactivateEdition();
          _mapVisorModule.unloadReview();
          _mapVisorModule.unloadPoints();
          $('#species_id').val('');
          $('.selectores').show('slow');
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
          $("#cancBtn").show();
          e.preventDefault();
  });
  $("#cancBtn").click(function(e){
    e.preventDefault();
    _mapVisorModule.cancelEdition();
    editButtonsOff();
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
  
  $('.searchcateg').click(function(e){
    $('.cajabusqueda').show('slow');
    $('.resultados').html("");
  });

});




