$( document ).ready(function() {
	$("#model_model_id").change(function() {
		_mapVisorModule.loadModel($("#model_model_id").val());
	});

	/*$(function() {
  		return $('select[rel="autocomplete"]').each(function() {
	    var input, option;
	    option = [];
	    $(this).find('option').each(function() {
	      return option.push($(this).text());
	    });
	    input = $('<input>');
	    input.attr('type', 'text');
	    input.attr('name', $(this).attr('name'));
	    input.attr('id', $(this).attr('id'));
	    input.attr('class', $(this).attr('class'));
	    input.attr('data-provide', 'typeahead');
	    input.val($(this).attr('data_default'));
    	$(this).replaceWith(input);
    		return $(input).typeahead({
      			local: option
    		});
  		});
	});*/
});