( function( $ ) {
	"use strict";
	var $element = $("#_desktop_search_content");
	console.log('--- novadvancedsearch.js ---');
	console.log($element.data("action"));
	var $novadvancedsearch_type = $element.data("novadvancedsearch_type");
	var $id_lang = $element.data("id_lang");
	var $ajaxsearch = $element.data("ajaxsearch");
	var $action = $element.data("action");
	var $search_ssl = $element.data("search_ssl");
	var $link_search_ssl = $element.data("link_search_ssl");
	var $instantsearch = $element.data("instantsearch");

	//select list for search type
	$('.form-novadvancedsearch').on('click','li', function(e){
		e.preventDefault();
		$('.form-novadvancedsearch .dropdown-item').removeClass('active');
		$(this).addClass('active');
		var id_category = $(this).data("value");
		$('.id_category','.form-novadvancedsearch').val(id_category);
		$('.form-novadvancedsearch .dropdown-toggle').html($(this).html());
	});

	if($ajaxsearch){
		$('document').ready(function() {
			var $input = $("#search_query_"+$novadvancedsearch_type);
			var select = $( ".nov_category_tree" ),
			options = select.find( "dropdown-item" ),
			id_category = options.filter( ".active" ).data('value');
			$input.novautocomplete(
			$action,
			{
				minChars: 3,
				max: 10,
				resultsClass: "ac_nov_results",
				loadingClass: "ac_nov_loading",
				selectFirst: false,
				scroll: false,
				dataType: "json",
				formatItem: function(data, i, max, value, term) {
					return value;
				},
				parse: function(data) {
					var mytab = [];
					for (var i = 0; i < data.length; i++)
						mytab[mytab.length] = { data: data[i], value: '<a href="'+data[i].product_link+'" class="d-flex align-items-center"><img src="'+data[i].pimage+'" /><span>' + data[i].pname + '</span></a>' };
					return mytab;
				},
				extraParams: {
					ajaxSearch: 1,
					id_category : id_category,
					id_lang: $id_lang
				}
			})
			.result(function(event, data, formatted) {
				$input.val(data.pname);
				document.location.href = data.product_link;
			});

			select.change(function () {
					id_category = options.filter( ".active" ).data( "value" );
					$( ".ac_nov_results" ).remove();
					$input.novautocomplete(
					$action,
					{
						minChars: 3,
						max: 10,
						selectFirst: false,
						scroll: false,
						dataType: "json",
						formatItem: function(data, i, max, value, term) {
							return value;
						},
						parse: function(data) {
							var mytab = [];
							for (var i = 0; i < data.length; i++)
								mytab[mytab.length] = { data: data[i], value: '<a href="'+data[i].product_link+'" class="d-flex align-items-center"><img src="'+data[i].pimage+'" /><span>' + data[i].pname + '</span></a>' };
							return mytab;
						},
						extraParams: {
							ajaxSearch: 1,
							id_category : id_category,
							id_lang: $id_lang
						}
					})
					.result(function(event, data, formatted) {
						$input.val(data.pname);
						document.location.href = data.product_link;
					});

			});
		});
	}

	if($instantsearch){
		function tryToCloseInstantSearch()
		{
			var $oldCenterColumn = $('#old_center_column');
			if ($oldCenterColumn.length > 0)
			{
				$('#center_column').remove();
				$oldCenterColumn.attr('id', 'center_column').show();
				return false;
			}
		}

		instantSearchQueries = [];
		function stopInstantSearchQueries()
		{
			for(var i=0; i<instantSearchQueries.length; i++) {
				instantSearchQueries[i].abort();
			}
			instantSearchQueries = [];
		}

		$('document').ready(function() {

			var $input = $("#search_query_"+$novadvancedsearch_type);

			$input.on('keyup', function() {
				if ($(this).val().length > 4)
				{
					stopInstantSearchQueries();
					instantSearchQuery = $.ajax({
						url: $link_search_ssl,
						data: {
							instantSearch: 1,
							id_lang: $id_lang,
							q: $(this).val()
						},
						dataType: 'html',
						type: 'POST',
						headers: { "cache-control": "no-cache" },
						async: true,
						cache: false,
						success: function(data){
							if($input.val().length > 0)
							{
								tryToCloseInstantSearch();
								$('#center_column').attr('id', 'old_center_column');
								$('#old_center_column').after('<div id="center_column" class="' + $('#old_center_column').attr('class') + '">'+data+'</div>').hide();
								// Button override
								ajaxCart.overrideButtonsInThePage();
								$("#instant_search_results a.close").on('click', function() {
									$input.val('');
									return tryToCloseInstantSearch();
								});
								return false;
							}
							else
								tryToCloseInstantSearch();
						}
					});
					instantSearchQueries.push(instantSearchQuery);
				}
				else
					tryToCloseInstantSearch();
			});
		});
	}

} )( jQuery );
