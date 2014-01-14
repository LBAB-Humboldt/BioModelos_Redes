$( document ).ready(function() {
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
});
