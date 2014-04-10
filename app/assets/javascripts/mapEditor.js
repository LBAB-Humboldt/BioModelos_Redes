var _mapVisorModule = function() {

	var map, drawnItems, layerControl, modelOverlay, currentLayer, drawControl, reviewLayer, csvLayer, cluster,
		isEditOn = false,
		commentForm = '<div class="commentForm"><form accept-charset="UTF-8" action="/reviews" class="simple_form well" data-remote="true" id="new_review" method="post" novalidate="novalidate"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="✓"></div>' +
           '<input id="review_model_id" name="review[model_id]" type="hidden">' +
           '<input id="review_user_id" name="review[user_id]" type="hidden">' +
           '<input id="review_geoJSON" name="review[geoJSON]" type="hidden">' +
           '<label><strong>Observación:</strong></label><br />' +
	       '<textarea rows="4" cols="30" placeholder="Ingrese una observación" id="comment" class="cmtArea"></textarea>' +
	       '<div class="row-fluid clearfix">' +
	       '<label class="labelcom clearfix"><strong>Acción:</strong></label><input type="radio" name="EditType" value="Add" class="radiogaga">Agregar</input><input type="radio" name="EditType" value="Cut" class="radiogaga">Remover</input><input type="radio" name="EditType" value="Other" class="radiogaga" checked>Otra</input>'+
	       '<input class="btn2" id="saveBtn" name="commit" type="submit" value="guardar">' +
           '<button class="btn2" id="popUpCancelBtn" type="button">cancelar</button></form></div>'; 
        pointForm = '<div class="commentForm"><form id="inputform" enctype="multipart/form-data" class="well"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="✓"></div>' +
           '<input id="review_type" type="hidden">'+
           '<label class="tituloformas">Observación:</label><br />' +
	       '<label>Lat: </label><input type="text" name="latitude" id="lat" size="7" disabled class="inputforma wauto"><label> Lng: </label><input type="text" name="longitude" id="lng" size="7" class="inputforma wauto" disabled><br />' +
	       '<input type="date" id="fecha_registro" name="fecha_registro" placeholder="Fecha de registro (mm/dd/aa)" class="inputforma w227"><br />' +
	       '<input type="text" id="r_localidad" name="localidad" placeholder="Localidad" class="inputforma w227"><br />' +
	       '<input type="text" name="tipo" id="r_tipo" placeholder="Tipo" class="inputforma w227"><br />' +
	       '<input type="text" name="colector" id="r_observador" placeholder="Observador" class="inputforma w227"><br />' +
	       '<input type="text" name="cita" id="r_cita" placeholder="Cita" class="inputforma w227"><br />' +
	       '<textarea rows="4" cols="30" placeholder="Ingrese una observación" id="comment" class="inputforma w227"></textarea>' +
	       '<div class="row-fluid clearfix">' +
	       '<input class="btn2" id="saveBtn" name="commit" type="submit" value="guardar">' +
           '<button class="btn2" id="popUpCancelBtn" type="button">cancelar</button></form></div>'; 

	var init = function() {

		var latlng = new L.LatLng(4, -72),
        	zoom = 6,
        	mZoom = 2,
        	mxZoom = 16;

        	/* Base Layers */
        	var googleTerrain = new L.Google('TERRAIN', {minZoom:mZoom, maxZoom: mxZoom}),
				googleSatellite = new L.Google('SATELLITE', {minZoom:mZoom, maxZoom: mxZoom}),
	    		osmBase = new L.TileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
	            {
	                minZoom: mZoom,
	                maxZoom: mxZoom,
	                attribution: 'Map data © OpenStreetMap contributors'
	            }),
	    		thunderForestLand= new L.TileLayer('http://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png',{
	    			minZoom: mZoom,
	                maxZoom: mxZoom,
					attribution: 'Map data ' + L.TileLayer.OSM_ATTR + ', Tiles &copy; <a href="http://www.mapquest.com/" target="_blank">MapQuest</a> <img src="http://developer.mapquest.com/content/osm/mq_logo.png" />'
		
	    		});

	    var	baseLayers = {
	    		"Google Terrain": googleTerrain,
	    		"Google Satellite": googleSatellite,
	        	"OpenStreetMap": osmBase,
	        	"Thunderforest Landscape": thunderForestLand
	    	},

	    	overlays = {};

    	
    	map = L.map('map').setView(latlng, zoom);
   
	    map.addLayer(googleTerrain);

	    /* autoZIndex controls the layer order */
	    layerControl = L.control.layers(baseLayers, overlays, {autoZIndex: true});
	    layerControl.addTo(map);

	    L.control.coordinates({
    		position:"bottomright", //optional default "bootomright"
		    decimals:2, //optional default 4
		    decimalSeperator:".", //optional default "."
		    labelTemplateLat:"Latitud: {y}", //optional default "Lat: {y}"
		    labelTemplateLng:"Longitud: {x}", //optional default "Lng: {x}"
		    enableUserInput:false, //optional default true
		    useDMS:false, //optional default false
		    useLatLngOrder: true //ordering of labels, default false-> lng-lat
		}).addTo(map);
	    
	    //loadModel();
	};

	var loadModel = function (modelUrl) {

		var imageUrl = modelUrl,
        	//imageBounds = [[12.675003791, -60.4833271], [-13.841664259, -82.949994938]];
        	imageBounds = [[12.675, -60.48333], [-13.84166, -82.94999]];

       /* Dispose older model if it exists */
       if(map.hasLayer(modelOverlay)) {
       		map.removeLayer(modelOverlay);
       		layerControl.removeLayer(modelOverlay);
       }
       	
	    modelOverlay = new L.ImageOverlay(imageUrl, imageBounds, {opacity: 0.6});
	    map.addLayer(modelOverlay, true);
	    layerControl.addOverlay(modelOverlay, "Modelo");
	    
	    
	    map.on('overlayadd', function(e) {
	        if(e.layer === modelOverlay)
	            modelOverlay.bringToBack();
	    });
	};

	var loadAllModels = function (modelsUrls) {
		var modelOver1 = null, modelOver2 = null, modelOver3 = null, modelOver4 = null;

		if(map.hasLayer(modelOver1)){
			map.removeLayer(modelOver1);
			layerControl.removeLayer(modelOver1);
		}
		if(map.hasLayer(modelOver2)){
			map.removeLayer(modelOver1);
			layerControl.removeLayer(modelOver1);
		}
		if(map.hasLayer(modelOver3)){
			map.removeLayer(modelOver1);
			layerControl.removeLayer(modelOver1);
		}
		if(map.hasLayer(modelOver4)){
			map.removeLayer(modelOver1);
			layerControl.removeLayer(modelOver1);
		}

		modelOver1 = new L.ImageOverlay(modelsUrls[1], imageBounds, {opacity: 0.6});
		modelOver2 = new L.ImageOverlay(modelsUrls[2], imageBounds, {opacity: 0.6});
		modelOver3 = new L.ImageOverlay(modelsUrls[3], imageBounds, {opacity: 0.6});
		modelOver4 = new L.ImageOverlay(modelsUrls[4], imageBounds, {opacity: 0.6});
		map.addLayer(modelOver1);
		map.addLayer(modelOver2);
		map.addLayer(modelOver3);
		map.addLayer(modelOver4);
		layerControl.addOverlay({"Modelo 1": modelOver1, "Modelo 2": modelOver2, "Modelo 3": modelOver3, "Modelo 4": modelOver4});

	};

	var unloadReview = function (){
		if(map.hasLayer(reviewLayer)) {
       		map.removeLayer(reviewLayer);
       		layerControl.removeLayer(reviewLayer);
       }
	};

	var loadReview = function (reviewGeoJSON) {

		/* Dispose older review if it exists */
       unloadReview();

       /* Deactivate edition if it is active */
       if (isEditOn) 
       	deactivateEdition();

       var 	propTypes = ["Fecha de Registro", "Localidad", "Tipo", "Observador", "Cita"],
       		popupString = '';


		reviewLayer = new L.GeoJSON(JSON.parse(reviewGeoJSON), {
        	onEachFeature: function (feature, layer) {
            	if (feature.geometry.type === 'Point') {
            		for (var i=0; i < propTypes.length; i++) {
						popupString += '<b>'+propTypes[i]+'</b><br />'+ feature.properties[propTypes[i]]+'<br /><br />';
					}
				}
				popupString += '<b>Comentario </b><br />'+ feature.properties.Comentario+'<br /><br />';
                layer.bindPopup(popupString, { maxHeight: 200 });
    		}
    	});

    	map.addLayer(reviewLayer);
    	layerControl.addOverlay(reviewLayer,"Anotación");

	};

	var loadPoints = function (csvUrl) {

		var csvTitles = ["Localidad","Municipio","Departamento","Altitud","Fecha","Institucion","Colector"];

		csvLayer = L.geoCsv(null, {		
										onEachFeature: function (feature, layer) {
												var popup = '<div class="cajita">';
												popup += '<b>'+ feature.geometry.coordinates[0]+', '+ feature.geometry.coordinates[1] + '</b><br /><br />';
												for (var i=0; i < csvTitles.length; i++) {
													popup += '<b>'+csvTitles[i]+'</b><br />'+ feature.properties[csvLayer.getPropertyName(csvTitles[i])]+'<br /><br />';
												}
												popup += '</div>'
												layer.bindPopup(popup);
										},
										latitudeTitle: 'latitude',
										longitudeTitle: 'longitude',
										firstLineTitles: true, 
										fieldSeparator: ','});


		$.ajax ({
			type:'GET',
			dataType:'text',
			url: csvUrl,
			async: false,
   			error: function() {
     			alert('No se pudieron cargar los datos');
   			},
			success: function(data) {
     			cluster = new L.MarkerClusterGroup();
				csvLayer.addData(data);
				cluster.addLayer(csvLayer);
				map.addLayer(cluster);
				layerControl.addOverlay(cluster,"Registros");
				map.fitBounds(cluster.getBounds());

			},
   			complete: function() {
      			//$('#cargando').delay(500).fadeOut('slow');
   			}
		});
    };

    var unloadPoints = function () {
		if(map.hasLayer(cluster)) {
       		map.removeLayer(cluster);
       		layerControl.removeLayer(cluster);
       }
	};

	var activateEdition = function () {

		unloadReview();

    	if(!isEditOn) {

    		isEditOn = true;

    		drawnItems = new L.FeatureGroup(); //Capa editable
		    /* Control */
		    drawControl = new L.Control.Draw({
		        draw: {
		            position: 'topright',
		            circle: false,
		            rectangle: false
		        },
		        edit: {
		            featureGroup: drawnItems
		        }
		    });

		    map.addControl(drawControl);
		    layerControl.addOverlay(drawnItems, "Edición");
		    map.addLayer(drawnItems);

		    /* Draw Created Event Listener */
		    map.on('draw:created', function(e) {

		    	var type = e.layerType,
		    		layer = e.layer,
		    		pLatLng,
		    		popup = new L.Popup({
		            	closeButton: false,
		            	closeOnClick: false
		       		});

    			if (type === 'marker') {
    				pLatLng = layer.getLatLng();
    				popup.setContent(pointForm);	
    			}
    			else {
    				//popup.setContent($('.editControls').html());
    				popup.setContent(commentForm);
    			}

    			layer.bindPopup(popup); 
		        drawnItems.addLayer(layer);
		        layer.openPopup();

		        if(type === 'marker'){
		        	$('#lat').val(L.NumberFormatter.round(pLatLng.lat, 2, "."));
		        	$('#lng').val(L.NumberFormatter.round(pLatLng.lng, 2, "."));
		        	$('#review_type').val('point');
		        } 
		    });

		    /* Updates lat lng points on popup when edited */
		    map.on('draw:edited', function (e) {
    			var layers = e.layers;
    			layers.eachLayer(function (layer) {
    				if(layer._latlng != undefined){
        		  		$('#lat').val(L.NumberFormatter.round(layer.getLatLng().lat, 2, "."));
		        		$('#lng').val(L.NumberFormatter.round(layer.getLatLng().lng, 2, "."));
		        	}
    			});
			});
		    
		    /* Popup Open Event Listener*/
		    map.on('popupopen', function(e) {
		        currentPopupID = e.popup._leaflet_id;
		    });

		    map.on('draw:drawstart', function(e) {
		    	// alert("Hola");
		    	// console.log("Elegido");
		    });	    
		}   
	};

	var deactivateEdition = function () {
		if(drawnItems != null && drawControl != null && layerControl != null){
			isEditOn = false;
			if(drawnItems._map != null)
				map.removeLayer(drawnItems);
		 	if(drawControl._map != null)
		 		map.removeControl(drawControl);
		 	if(layerControl._map != null)
		 		layerControl.removeLayer(drawnItems);
		}
	};

	var cancelLayer = function () {

		currentLayer = getCurrentLayer(currentPopupID);
		drawnItems.removeLayer(currentLayer);

	};

	var getCurrentLayer = function (popupID) {
	    var layerRet;
	    if (popupID !== undefined && popupID !== null) {
	        drawnItems.eachLayer(function(layer) {
	            if (layer._popup._leaflet_id === popupID) {
	                var count = 0;
	                //console.log(count++);
	                layerRet = layer;
	            }
	        });
	    }
	    return layerRet;
	};


	var saveEdition = function () {
		var popupHtml = '';
		var comment = $("#comment").val();
	    if (comment.length === 0) {
	        alert("¡Ingrese una observación!");
	        return false;
	    }

	    currentLayer = getCurrentLayer(currentPopupID);

	    if (currentLayer !== undefined && currentLayer !== null) {
	    	var editType = $('input[name="EditType"]:checked').val();
	    	if($('#review_type').val() === 'point'){
	    		popupHtml +=	'<label>Fecha de registro: </label><label id="puFechaRegistro">'+ $('#fecha_registro').val() +'</label><br />' +
	    						'<label>Localidad: </label><label id="puLocalidad">'+ $('#r_localidad').val() +'</label><br />' +
	    						'<label>Tipo: </label><label id="puTipo">'+ $('#r_tipo').val() +'</label><br />' +
	    						'<label>Observador: </label><label id="puObservador">'+ $('#r_observador').val() +'</label><br />' +
	    						'<label>Cita: </label><label id="puCita">'+ $('#r_cita').val() +'</label><br />';
	    	}
	    	popupHtml += '<label>Comentario: </label><label id="puComment">'+ $('#comment').val() +'</label><br />';
	    	
	        currentLayer.closePopup();
	        currentLayer.bindPopup(popupHtml);
	        currentLayer.openPopup();
	    }
	    else {
	        alert("No se ha podido enviar el comentario");
	        return false;
	    }
	    //console.log(toGeoJSON());
	    $('#review_geoJSON').val(toGeoJSON());
	    $('#new_review').submit();
	};

	var cancelEdition = function () {
		// var cancel = true;
		// if(confirm('¿Desea cancelar sin guardar los cambios?'))
		// 	deactivateEdition();
		// else 
		// 	cancel = false;
		
		// return cancel;
		deactivateEdition();
	};


	var toGeoJSON = function () {

	    var geoJSONLayer = '{"type": "FeatureCollection", "features":[',
	        layNum = drawnItems.getLayers().length,
	        count = 0;
	        
	    drawnItems.eachLayer(function(layer) {
	        ltG = layer.toGeoJSON();
	        geoJSONLayer += '{"type": "' + ltG.type + '", "geometry": {"type": "' + ltG.geometry.type + '", "coordinates": ';

	        var coords, isPoint = false, isPolygon = false;

	        /* Check if layer is Point, Polygon or LineString */
	        switch (ltG.geometry.coordinates.length)
	        {
	            case 1:
	                coords = ltG.geometry.coordinates[0];
	                isPolygon = true;
	                break;
	            case 2:
	                coords = ltG.geometry.coordinates;
	                isPoint = true;                                    
	                break;
	            default:
	                coords = ltG.geometry.coordinates;
	                break;
	        }

	        var len = coords.length;
	        if (!isPoint) {
	            if (len > 1 && !isPolygon)
	                geoJSONLayer += '[';
	            else if (len > 1)
	                geoJSONLayer += '[[';
	            for (var i = 0; i < len; i++)
	            {
	                geoJSONLayer += '[' + coords[i] + ']';
	                if (i < len - 1)
	                    geoJSONLayer += ',';
	            }
	            if (len > 1 && !isPolygon)
	                geoJSONLayer += ']';
	            else if (len > 1)
	                geoJSONLayer += ']]';
	        }
	        else
	            geoJSONLayer += '[' + coords + ']';

	        geoJSONLayer += '}, "properties": {"Comentario": "' + $('#puComment').text();
	        if (ltG.geometry.type === 'Point'){
	        	geoJSONLayer += '", "Fecha de Registro": "' + $('#puFechaRegistro').text() + '"' +
	        					', "Localidad": "' + $('#puLocalidad').text() + '"' +
	        					', "Tipo": "' + $('#puTipo').text() + '"' +
	        					', "Observador": "' + $('#puObservador').text() + '"' +
	        					', "Cita": "' + $('#puCita').text();
	        }
	        else
	        	geoJSONLayer += '", "Accion": "' + $('input[name="EditType"]:checked').val();

	        geoJSONLayer += '"}}';

	        if (layNum > 1 && count < layNum - 1)
	            geoJSONLayer += ',';
	        count += 1;
	    });
	    geoJSONLayer += ']}';

	    //console.log(geoJSONLayer);
	    return geoJSONLayer;
	};


	return {

		init: init,
		loadModel: loadModel,
		activateEdition: activateEdition,
		deactivateEdition: deactivateEdition,
		cancelLayer: cancelLayer,
		saveEdition: saveEdition,
		loadReview: loadReview,
		unloadReview: unloadReview,
		loadPoints: loadPoints,
		unloadPoints: unloadPoints,
		cancelEdition: cancelEdition
	};
}();

$(document).ready(function() {

	/* Function Handlers */

	$("#editBtn").click(function() {
    	_mapVisorModule.activateEdition();
    });

	$("body").on("click", "#saveBtn", function(){
     	_mapVisorModule.saveEdition();
	});

	$("body").on("click", "#popUpSubmitBtn", function(){
		_mapVisorModule.submitComment();
	});

	$("body").on("click", "#popUpCancelBtn", function(){
		_mapVisorModule.cancelLayer();
	});

	_mapVisorModule.init();

});