$( document ).ready(function() {

  /* Model animation */
  $("body").on("mouseenter",".cajadatosm",function(e){
        $(this).animate({scrollTop:$(".cajadatosm").scrollTop() + $(this).find(".modeldata").position().top},600);
  });
  $("body").on("mouseleave",".cajadatosm",function(e){
        $(this).animate({scrollTop:$(".cajadatosm").position().top - '20px'},600).finish();
  });
  

  /* Autocomplete */
	$("#search_field").typeahead({
       	name: 'Search',
    	//remote: '/species/autocomplete?query=%QUERY&class_id=%SPCLASS',
    	remote: {
    				url: '/species/autocomplete?query=%QUERY&classId=%SPCLASS',
    				replace:
    					function(url, query) {
      						var sp_classId = encodeURIComponent($('#class_id').val());
      						return url.replace('%QUERY', query).replace('%SPCLASS', sp_classId);
    					}
  				},
    	minLength: 2
  });

  $("#search_field").on("typeahead:selected typeahead:autocompleted", function(e,datum) { 
		$("#species_id").val(datum.id);
	});

  /* Model selection */
  $("body").on("click",".model_link",function (event) {
                _mapVisorModule.loadModel("/modelos/"+$(this).find('#imgsrc').val());
                $("#review_model_id").val($(this).find('img').attr('id'));
                $('.editControls').show('slow');
                $('.showmodels, .cajabusqueda, .selectores').hide ('slow');
                event.preventDefault(); // Prevent link from following its href
  });
  
});
