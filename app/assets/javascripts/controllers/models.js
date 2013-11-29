$( document ).ready(function() {
	$("#search_field").typeahead({
       	name: 'Search',
    	remote: '/species/autocomplete?query=%QUERY'
  	});
});