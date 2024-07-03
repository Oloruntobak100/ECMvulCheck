/*
 * JavaScript Dashboard Class
 * Created On: 15-JULY-2013
 * Created By: Ogbuitepu O. Patrick
 *
        WebBrowser1.Navigate("http://datamanagement.northwindproject.com")
        WebControl1.Source = New Uri("http://datamanagement.northwindproject.com")

 *
*/
$( document ).ready( function() {
	var current_module = '1357383943_1';
	var current_record = '';
	
	//Store HTML ID of Last Clicked Function
	var clicked_menu = '';
	
	//Store HTML ID of Last Clicked Popup Function
	var clicked_main_menu = '';
	
	//Name of Table to Search
	var search_table = '';
	
	//Name of Table to Toggle its Columns
	var column_toggle_table = '';
	
	//Number of Column to toggle
	var column_toggle_num = '';
	
	//Name of Column to toggle
	var column_toggle_name = '';
	
	//Selected Record ID
	var single_selected_record = '';
	
	//Selected Records IDs
	var multiple_selected_record_id = '';
	
	//Selected Records Details
	var details_of_multiple_selected_records = '';
	
	var class_action = '';
	var class_name = '';
	var module_id = '';
	
	var pagepointer = $('#pagepointer').text();
	
	var clicked_action_button = '';
	var confirm_action_prompt = 1;
	
	var form_method = 'get';
	var ajax_data_type = 'json';
	var ajax_data = '';
	var ajax_get_url = '';
	var ajax_action = '';
	var ajax_container;
	var ajax_notice_container;
	
	//AJAX Request Data Before Sending
	var ajax_request_data_before_sending_to_server = '';
	
	var function_click_process = 1;
	
	var cancel_ajax_recursive_function = false;
	
	var oTable;
	
	var oNormalTable;
	
	//Last Position of Mouse on mouseup event
	var last_position_of_mouse_on_mouse_up_x = 0;
	var last_position_of_mouse_on_mouse_up_y = 0;
	
	//Variable to determine if entity is being renamed
	var renaming_entity_in_progress = 0;
	
	//Currently Opened Label
	var currently_opened_label_id_in_report_letters_memo = '';
	
	var editted_entity_source = '';
	
	//Determine if Menus have been bound to actions after initialization
	var bound_menu_items_to_actions = 0;
	
	var test_view_entity = 0;
	
	//Variable that determines the number of times notifications have to be closed prior to status update
	var update_notifications_to_read = 0;
	
	//Variable that determines whether to archive dataset
	var archive_dataset = 0;
	
	//Variable that determines the currently edited textarea
	var editing_textarea;
	
	//Variable that determines the currently view port opened in reports , letters & memo
	var report_letters_memo_current_view = '';
	
	var months = {
		"01":"Jan",
		"02":"Feb",
		"03":"Mar",
		"04":"Apr",
		"05":"May",
		"06":"Jun",
		"07":"Jul",
		"08":"Aug",
		"09":"Sep",
		"10":"Oct",
		"11":"Nov",
		"12":"Dec",
	};
	
	var months_reverse = {
		"Jan":"01",
		"Feb":"02",
		"Mar":"03",
		"Apr":"04",
		"May":"05",
		"Jun":"06",
		"Jul":"07",
		"Aug":"08",
		"Sep":"09",
		"Oct":"10",
		"Nov":"11",
		"Dec":"12",
	};
	
	function ajax_send(){
		if(function_click_process){
		//Send Data to Server
		$.ajax({
			dataType:"text",
			type:form_method,
			data:ajax_data,
			url: pagepointer+'php/ajax_request_processing_script.php'+ajax_get_url,
			timeout:100000,
			beforeSend:function(){
				//Display Loading Gif
				function_click_process = 0;
				
				cancel_ajax_recursive_function = false;
				
				confirm_action_prompt = 0;
				
				/*ajax_container.html('<div id="loading-gif" class="no-print">Please Wait</div>');*/
				
				$('#generate-report-progress-bar')
				.html('<div id="virtual-progress-bar" class="progress progress-striped"><div class="progress-bar bar"></div></div>');
				progress_bar_change();
				
				ajax_request_data_before_sending_to_server = '';
				ajax_request_data_before_sending_to_server += '<p><b>dataType:</b> '+ajax_data_type+'</p>';
				ajax_request_data_before_sending_to_server += '<p><b>type:</b> '+form_method+'</p>';
				if( typeof(ajax_data) == "object" )
					ajax_request_data_before_sending_to_server += '<p><b>data:</b> '+ $.param( ajax_data ) +'</p>';
				else
					ajax_request_data_before_sending_to_server += '<p><b>data:</b> '+ ajax_data +'</p>';
				
				ajax_request_data_before_sending_to_server += '<p><b>url:</b> '+pagepointer+'php/backend.php'+ajax_get_url+'</p>';
				
			},
			error: function(event, request, settings, ex) {
				
				if( function_click_process == 0 && event.responseText ){
					
					//Refresh Page
					function_click_process = 1;
					
					//Display Timeout Error Message
					var theme = 'a';
					var message_title = 'AJAX Request Error';
					var message_message = "Error requesting page!<br /><br /><h4>Request Parameters</h4>" + ajax_request_data_before_sending_to_server + "<br /><h4>Response Text</h4><p><textarea>" + event.responseText + "</textarea></p>";
					var auto_close = 'no';
					
					no_function_selected_prompt(theme, message_title, message_message, auto_close);
					
				}
			},
			success: function(data){
				
				function_click_process = 1;
				$("#results-box").html( data );
				/*
				switch(ajax_action){
				case "generate_modules":
					ajax_generate_modules(data);
				break;
				case "request_function_output":
					ajax_request_function_output(data);
				break;
				case "action_button_submit_form":
					ajax_action_button_submit_form(data);
				break;
				case "submit_form_data":
					ajax_submit_form_data(data);
				break;
				}
				*/
			}
		});
		}
	};
    
	function set_function_click_event(){
		if(!bound_menu_items_to_actions){
			//Ensure that Menus are bound only once
			$('ul.module-menu')
			.find('a')
			.not('.drop-down')
			.bind('click',function( e ){
				e.preventDefault();
				set_the_function_click_event($(this));
				
			});
			
			bound_menu_items_to_actions = 1;
		}
		
		$('a#show-dashboard-page')
		.not(".activated-click-event")
        .bind('click', function( e ){
            populate_dashbaord();
        })
		.addClass("activated-click-event");
        
		$('a#add-new-record')
		.add('a#generate-report')
		.add('a#import-excel-table')
		.add('a#navigation-pane')
		.add('a#advance-search')
		.add('a#clear-search')
		.add('a.custom-action-button')
		.add('a#delete-forever')
		.not(".activated-click-event")
		.bind('click',function( e ){
			e.preventDefault();
			set_the_function_click_event( $(this) );
		})
		.addClass("activated-click-event");
		
		$('#refresh-datatable')
		.not(".activated-click-event")
		.bind('click',function( e ){
			e.preventDefault();
			
			var data_table_id = getDataTableID( 1 );
			
			if( $('#'+data_table_id) && $('#'+data_table_id).is(":visible") ){
				var oTable1 = $('#'+data_table_id).dataTable();
				
				oTable1.fnReloadAjax();
				
				$(this).hide();
			}
		})
		.addClass("activated-click-event");
		
		//Bind Edit Buttons Event and entity right click menu buttons events
		$('a.custom-single-selected-record-button')
		.add('a#edit-selected-record')
		.add('#edit-selected-record-password')
		.not(".activated-click-event")
		.bind('click',function( e ){
			e.preventDefault();
			
			if( $(this).attr("override-selected-record") ){
				single_selected_record = $(this).attr("override-selected-record");
			}
			
			if( ( ! single_selected_record  ) && $(this).attr("selected-record") ){
				single_selected_record = $(this).attr("selected-record");
			}
				
			if( single_selected_record ){
				clicked_action_button = $(this);
			
				ajax_data = {mod:$(this).attr('mod'), id:single_selected_record};
				form_method = 'post';
				
				ajax_data_type = 'json';
				
				ajax_action = 'request_function_output';
				ajax_container = '';
				ajax_get_url = $(this).attr('action');
				
				ajax_send();
				
			}else{
				no_record_selected_prompt();
			}
		});
		
		//Bind Generate Report Buttons Event
		
		$('a.custom-multi-selected-record-button')
		.add('a#generate-report-first-term')
		.not(".activated-click-event")
		.bind('click',function(e){
			e.preventDefault();
			
			if(single_selected_record || multiple_selected_record_id){
				clicked_action_button = $(this);
				
				var budget_id = '';
				var month_id = '';
				
				if( $(this).attr('budget-id') && $(this).attr('month-id') ){
					budget_id = $(this).attr('budget-id');
					month_id = $(this).attr('month-id');
				}
				
				ajax_data = {mod:$(this).attr('mod'), id:single_selected_record, ids:multiple_selected_record_id, budget:budget_id, month:month_id };
				form_method = 'post';
				
				ajax_data_type = 'json';
				
				ajax_action = 'request_function_output';
				ajax_container = '';
				ajax_get_url = $(this).attr('action');
			
				ajax_send();
			}else{
				no_record_selected_prompt();
			}
		})
		.addClass("activated-click-event");
		
        //preview-content
		$('a.preview-content')
		.not(".activated-click-event")
		.bind('click',function(e){
			 
			e.preventDefault();
			
			if( single_selected_record ){
				var html = $('table#the-main-details-table-'+single_selected_record).find('tr[jid="'+$(this).attr('row-id')+'"]').find('td.details-section-container-value').html();
                
                if( html ){
                    var x=window.open();
                    x.document.open();
                    x.document.write( html );
                    x.document.close();
                }
			}else{
				no_record_selected_prompt();
			}
		})
		.addClass("activated-click-event");
		
		//Bind Delete Buttons Event
		$('a#restore-selected-record')
		.add('a#delete-selected-record')
		.not(".activated-click-event")
		.bind('click',function(e){
			e.preventDefault();
			
			if(single_selected_record || multiple_selected_record_id){
				
				clicked_action_button = $(this);
				
				ajax_data = {mod:$(this).attr('mod'), id:single_selected_record, ids:multiple_selected_record_id};
				form_method = 'post';
				ajax_data_type = 'json';
				
				//ajax_action = 'action_button_submit_form';
				ajax_action = 'request_function_output';
				ajax_container = '';
				ajax_get_url = $(this).attr('action');
				
				confirm_action_prompt = 1;
				
				$(this).popover('show');
			}else{
				no_record_selected_prompt();
			}
		})
		.addClass("activated-click-event");
		
	};
	
	function set_the_function_click_event($me){
		//Get HTML ID
		clicked_menu = $me.attr('id');
		
		//Last Clicked function from main menu
		switch($me.attr('id')){
		case 'add-new-record':
		case 'generate-report':
		case 'import_excel_table':
		case 'restore-all':
		case 'advance-search':
		case 'navigation-pane':
		case 'clear-search':
		case 'add-new-memo-report-letter':
		break;
		default:
			clicked_main_menu = $me.attr('id');
		break;
		}
		
		//Get function id
		var function_id = $me.attr('function-id');
		var function_name = $me.attr('function-name');
		var function_class = $me.attr('function-class');
		
		var budget_id = '';
		var month_id = '';
		var operator_id = '';
		var department_id = '';
		
		if( $me.attr('budget-id') && $me.attr('month-id') ){
			budget_id = $me.attr('budget-id');
			month_id = $me.attr('month-id');
		}
		
		if( $me.attr('department-id') && $me.attr('operator-id') ){
			operator_id = $me.attr('operator-id');
			department_id = $me.attr('department-id');
		}
		
		column_toggle_table = '';
		column_toggle_num = '';
		column_toggle_name = '';
		
		search_table = '';
		if($me.attr('search-table'))
			search_table = $me.attr('search-table');
		
		if($me.attr('column-toggle-table')){
			column_toggle_table = $me.attr('column-toggle-table');
			column_toggle_name = $me.attr('name');
			column_toggle_num = $me.attr('column-num');
		}	
			
		var module_id = $me.attr('module-id');
		var url = "";
		if( $me.hasClass("custom-action-button-url") ){
			url = $me.attr("href");
		}
		
		if(function_id && function_id!='do-nothing'){
			//Request Function Output
			request_function_output(function_name, function_class, module_id, function_id , budget_id, month_id, operator_id, department_id, url );
			
			//Update name of the active function
			if( $me.attr('module-name') && $me.attr('module-name').length > 3 && $me.text()){
				$('#active-function-name')
				.attr('function-class', function_class)
				.attr('function-id', function_id)
				.html($me.attr('module-name') + ' &rarr; ' + $me.text());
				
				$('#secondary-display-title').html( '<i class="icon-info-sign"></i> ' + $me.attr('module-name') + ' &rarr; ' + $me.text() );
				
				$('title').html($me.attr('module-name') + ' &rarr; ' + $me.text());
			}
		}
	};
	
	function request_function_output(function_name, function_class, module_id, function_id, budget_id, month_id, operator_id, department_id, url ){
		//IF ADVANCE SEARCH - THEN PASS VALUE OF CURRENT TABLE
		
		switch(function_class){
		case "myexcel":
		case "search":
			ajax_data = {action:function_class, todo:function_name, module:module_id, search_table:search_table};
		break;
		case "column_toggle":
			ajax_data = {action:function_class, todo:function_name, module:module_id, column_toggle_table:column_toggle_table, column_toggle_name:column_toggle_name, column_toggle_num:column_toggle_num};
		break;
		default:
			if(function_id){
				ajax_data = {action:function_class, todo:function_name, module:module_id, id:function_id, budget:budget_id, month:month_id, department:department_id, operator:operator_id };
			}else{
				ajax_data = {action:function_class, todo:function_name, module:module_id, budget:budget_id, month:month_id, department:department_id, operator:operator_id };
			}
			
			if( function_name == 'create_new_record' && single_selected_record ){
				ajax_data = {action:function_class, todo:function_name, module:module_id, id:single_selected_record };
			}
		break;
		}
		
		class_action = function_name;
		class_name = function_class;
		module_id = module_id;
		
		form_method = 'get';
		ajax_data_type = 'json';
		
		//if(function_name=='rename_entity' && before==1)ajax_data_type = 'text'; //NEW RECORD
		//if(function_name=='new')ajax_data_type = 'text'; //NEW RECORD
		//if(function_name=='select_audit_trail')ajax_data_type = 'text'; //NEW RECORD
		//if(function_name=='search')ajax_data_type = 'text'; //SEARCH RECORD
		//if(function_name=='clear_search')ajax_data_type = 'text'; //SEARCH RECORD
		//if(function_name=="column_toggle")ajax_data_type = 'text'; //TOGGLE COLUMN RECORD
		//if(function_name=="delete_forever")ajax_data_type = 'text'; //TOGGLE COLUMN RECORD
		
		ajax_action = 'request_function_output';
		ajax_container = '';
		ajax_get_url = '';
		
		if( url ){
			ajax_get_url = url;
			ajax_data = {};
		}
		ajax_send();
	};
	
	function re_process_previous_request( data ){
        
		if( data.re_process && ! cancel_ajax_recursive_function ){
			if( data.re_process_code )trigger_new_ajax_request( data );
			else set_the_function_click_event( $( data.re_process ) );
		}else{
			//Reload DataTable
			if( data.reload_table && oTable ){
				oTable.fnReloadAjax();
			}
		}
	}
	
	function trigger_new_ajax_request( data ){
		
		ajax_data = {mod:data.mod, id:data.id};
		form_method = 'post';
		
		ajax_data_type = 'json';
		ajax_action = 'request_function_output';
		ajax_container = '';
		ajax_get_url = data.action;
		
		ajax_send();
	}
	
	var tmp_data;
	function ajax_request_function_output(data){
		//alert(data);
		//Close Pop-up Menu
		
		data.reload_table = 1;
		
		if( data.status ){
			tmp_data = data;
			
			switch(data.status){
			case "new-status":
				if( data ){
					
					if( data.html ){
						$('#dash-board-main-content-area')
						.html( data.html );
					}
					
					if( data.html_replacement_selector && data.html_replacement ){
						$( data.html_replacement_selector )
						.html( data.html_replacement );
					}
					
					if( data.html_replacement_selector_one && data.html_replacement_one ){
						$( data.html_replacement_selector_one )
						.html( data.html_replacement_one );
					}
					
					if( data.html_replacement_selector_two && data.html_replacement_two ){
						$( data.html_replacement_selector_two )
						.html( data.html_replacement_two );
					}
					
					if( data.html_replacement_selector_three && data.html_replacement_three ){
						$( data.html_replacement_selector_three )
						.html( data.html_replacement_three );
					}
					
					if( data.html_prepend_selector && data.html_prepend ){
						$(data.html_prepend_selector)
						.prepend( data.html_prepend );
					}
					
					if( data.html_append_selector && data.html_append ){
						$(data.html_append_selector)
						.append( data.html_append );
					}
					
					if( data.html_replace_selector && data.html_replace ){
						$(data.html_replace_selector)
						.replaceWith( $(data.html_replace) );
					}
					
					if( data.html_removal ){
						$(data.html_removal).remove();
					}
					
					if( data.javascript_functions ){
						
						$.each( data.javascript_functions , function( key, value ){
							if( data.delay ){
								setTimeout( function(){ eval( value + "()" ); } , data.delay );
							}else{
								eval( value + "()" );
							}
						} );
					}
					
					if(data.clear_saved_record_id){
						single_selected_record = "";
					}
					
					if(data.saved_record_id){
						single_selected_record = data.saved_record_id;
					}
					
					if( data.do_not_reload_table )
						data.reload_table = 0;
				}
			break;
			case "got-quick-details-view":
				//Update Create New School Button Attributes
				if( $('#custom-details-display-container') && data.html ){
					$('#custom-details-display-container')
					.html( data.html );
                    data.reload_table = 0;
				}
			break;
			case "display-appsettings-setup-page":
				//Update Create New School Button Attributes
				if( $('#create_new_appsettings') && data.create_new_appsettings_data ){
					$('#create_new_appsettings')
					.attr('function-class', data.create_new_appsettings_data.function_class )
					.attr('function-name', data.create_new_appsettings_data.function_name )
					.attr('module-id', data.create_new_appsettings_data.module_id );
					
					//Bind Click Event of Button
					$('#create_new_appsettings')
					.bind('click',function(){
						set_the_function_click_event($(this));
					});
				}
				
			break;
			case "display-data-capture-form":
				//Update Create New School Button Attributes
				prepare_new_record_form(data);
				
                if( $('#side-nav') && $('#side-nav').is(':visible') ){
                    //Display Top Accordion
                    if( ! $('#collapseTop').hasClass('in') ){
                        $('#collapseTop')
                        .collapse('show');
                    }
                    
                    $('#collapseBottom')
                    .find('.portlet-body')
                    .hide();
                    
                    $('#collapseBottom')
                    .find('.collapse')
                    .removeClass('collapse')
                    .addClass('expand');
				}
				//Display Form Tab
				$('#form-home-control-handle')
				.click();
			break;
			case "display-advance-search-form":
				//Update Create New School Button Attributes
				prepare_new_record_form(data);
				
                if( $('#side-nav') && $('#side-nav').is(':visible') ){
                    //Display Top Accordion
                    if( ! $('#collapseTop').hasClass('in') ){
                        $('#collapseTop')
                        .collapse('show');
                    }
                    
                    $('#collapseBottom')
                    .find('.portlet-body')
                    .hide();
				}
				//Display Form Tab
				$('#form-home-control-handle')
				.click();
				
				//bind advance search controls
				bind_search_field_select_control();
			break;
			case "modify-appsettings-settings":
				//Update Create New School Button Attributes
				prepare_new_record_form(data);
				
				//Update Application with School Properties
				update_application_with_school_properties( data );
			break;
			case "redirect-to-dashboard":
				//Redirect to dashboard page
				$('#page-body-wrapper')
				.html( data.html );
				
				//Update Application with School Properties
				update_application_with_school_properties( data );
				
				if( data.reload )
					document.location = document.location;
				
				//Get Menus
				generate_modules();
				
				//Activate Tabs
				$('#myTab')
				.find('a')
				.bind('click', function (e) {
				  e.preventDefault();
				  $(this).tab('show');
				  
				   //Link Tab Clicks to Accordion
				   if( ! $('#collapseTop').hasClass('in') ){
						$('#collapseTop')
						.collapse('show');
					}
				});
				
				//bind clear tab contents button
				$('#clear-tab-contents')
				.bind('click', function (e) {
					e.preventDefault();
					
					$('.tab-content')
					.find('div.active.tab-content-to-clear')
					.empty();
						
					$('.tab-content')
					.find('div.active')
					.find('.tab-content-to-clear')
					.empty();
						
				});
			break;
			case "reload-page":
				document.location = document.location;
			break;
			case "redirect-to-login":
				//Redirect to login page
				prepare_new_record_form(data);
				
				//Update Application with School Properties
				update_application_with_school_properties( data );
			break;
			case "authenticate-user":
				//Refresh Form Token
				//refresh_form_token( data );
			break;
			case "displayed-dashboard":
				//Refresh Form Token
				$('#data-table-container')
				.html( data.html );
                
                bind_details_view_control();
			break;
			case "deleted-records":
				var data_table_id = getDataTableID( 1 );
				
				var oTable1 = $('#'+data_table_id).dataTable();
				if( oTable1 ){
					oTable1.fnReloadAjax();
					
					if( data.reload_other_tables ){
						$.each( data.reload_other_tables, function( k, v ){
							var oTable2 = $('#'+v+'-datatable').dataTable();
							oTable2.fnReloadAjax();
						});
					}
				}
			break;
			case "column-toggle":
				ajax_hide_show_column_checkbox( data );
                bind_details_view_control();
			break;
			case "reload-datatable":
				//Activate DataTables Plugin
				if( data.searched_table ){
					class_name = data.searched_table;
				
					$('#search-query-display-container')
					.html( data.search_query )
					.attr( 'title', $('#search-query-display-container').text() );
				}
				
				if( $('#collapseTop').hasClass('in') ){
					$('#collapseTop')
					.collapse('hide');
				}
				if( ! $('#collapseBottom').hasClass('in') ){
					$('#collapseBottom')
					.collapse('show');
				}
				reload_datatable();
			break;
			case "display-datatable":
				
				if( $('#collapseTop').hasClass('in') ){
					$('#collapseTop')
                    .find('.portlet-body')
                    .hide();
                    
                    $('#collapseTop')
                    .find('.collapse')
                    .removeClass('collapse')
                    .addClass('expand');
				}
				if( ! $('#collapseBottom').hasClass('in') ){
					$('#collapseBottom')
					.collapse('show');
				}
				
				//Display HTML
				var html = data.html;
				
				if( data.inline_edit_form ){
					html += data.inline_edit_form;
				}
				
				$('#data-table-container')
				.html( html );
				
				if( data.search_query )
					$('#search-query-display-container')
					.html( data.search_query )
					.attr( 'title', $('#search-query-display-container').text() );
				
				
				//Activate DataTables Plugin
				recreateDataTables();
				
				set_function_click_event();
				
				//UPDATE HIDDEN / SHOWN COLUMNS
				update_column_view_state();
				
			break;
			case "saved-form-data":
				if( data.typ == 'serror' || data.typ == 'uerror' )
					break;
				
				if( $('#collapseTop').hasClass('in') ){
					$('#collapseTop')
					.collapse('hide');
				}
				if( ! $('#collapseBottom').hasClass('in') ){
					$('#collapseBottom')
					.collapse('show');
				}
				
				//Check for saved record id
				if(data.saved_record_id){
					single_selected_record = data.saved_record_id;
				}
				
				if( $('form.quick-edit-form') && data.clear_stepmaxstep ){
					$('form.quick-edit-form')
					.find('input[name="stepmaxstep"]')
					.val( data.clear_stepmaxstep );
				}
				
				//Refresh Token
				if( data.go_to_next_record ){
					$('#'+single_selected_record).parents('tr').next().click();
				}
				
				var data_table_id = getDataTableID( 1 );
				
				if( data.do_not_reload_table ){
					data.reload_table = 0;
					
					$('.dynamic')
					.find('#refresh-datatable')
					.show();
					
				}else{
					//Reload DataTable
					if( $('#'+data_table_id) && $('#'+data_table_id).is(":visible") ){
						var oTable1 = $('#'+data_table_id).dataTable();
						
						oTable1.fnReloadAjax();
						//recreateDataTables();
						
						//Bind form submission event
						select_record_click_function( $('#'+data_table_id) );
					}
					if( data.reload_other_tables ){
						$.each( data.reload_other_tables, function( k, v ){
							var oTable2 = $('#'+v+'-datatable').dataTable();
							oTable2.fnReloadAjax();
						});
					}
					
					//Bind details open and close event to table
					bind_details_button_click();
				}
				
				if( data.javascript_functions ){
					
					$.each( data.javascript_functions , function( key, value ){
						eval( value + "()" );
					} );
				}
			break;
			case "download-report":	
				if( $('#monthly-report-link-con') && $('#monthly-report-link-con').is(':visible') && data.html ){
					$('#monthly-report-link-con').html( data.html );
				}
			break;
			}
		}else{
			data.reload_table = 0;
		}
		
		//Handle / Display Error Messages / Notifications
		display_notification( data );
		
		//Check for re-process command
		re_process_previous_request( data );
		
		tmp_data = {};
	};
	
	function reload_datatable(){
		var data_table_id = getDataTableID( 1 );
		var oTable1 = $('#'+data_table_id).dataTable();
		
		if( oTable1 ){
			oTable1.fnReloadAjax();
		}else{
			recreateDataTables();
		}
	};
	
	//Function to Update Application with School Properties
	function update_application_with_school_properties( data ){
		//Update school properties if set
		if( data.appsettings_properties ){
			$('#appsettings-name')
			.text( data.appsettings_properties.appsettings_name );
		}
	};
	
	//Function to Refresh Form Token After Processing
	function refresh_form_token( data ){
		//Update school properties if set
		if( data.tok && $('form') ){
			$('form')
			.find('input[name="processing"]')
			.val( data.tok );
		}
	};
	
	//Display Notification Message
	var notificationTimerID;
	function display_notification( data ){
		if( data.typ ){
			var theme = 'alert-danger';
			
			if( data.theme ){
				theme = data.theme;
			}
			
			switch(data.typ){
			case "search_cleared":
			case "report_generated":
			case "searched":
			case "saved":
			case "jsuerror":
			case "uwarning":
			case "uerror":
			case "deleted":
			case "serror":
				//Refresh Token
				refresh_form_token( data );
				
				var html = '<div class="alert ' + theme + ' alert-block1 alert-dismissable">';
				  html += '<button type="button" class="close" id="alert-close-button" data-dismiss="alert"></button>';
				  html += '<h4>' + data.err + '</h4>';
				  html += data.msg;
				html += '</div>';
				
				var $notification_container = $('#notification-container');
				
				if( notificationTimerID )clearTimeout( notificationTimerID );
				
				
				$notification_container
				.html( html );
				
				switch(data.typ){
				case "uwarning":
				case "report_generated":
					set_function_click_event();
				break;
				default:
					notificationTimerID = setTimeout( function(){
						$('#notification-container')
						.empty();
					} , 15000 );
				break;
				}
				
				$('#alert-close-button')
				.bind('click', function(){
					$('#notification-container')
					.empty();
				});
				
			break;
			}
		}
	};
		
	function prepare_new_record_form( data ){
		//Bind Html text-editor
		bind_html_text_editor_control();
		
		//Prepare and Display New Record Form
		$('#form-content-area')
		//.html('<div id="form-panel-wrapper1">'+data.html+'</div>')
		.html(data.html);
		
		if( data.status ){
			switch(data.status){
			case "display-data-capture-form":
				//Bind Html text-editor
				bind_html_text_editor_control();
				
				//Activate Client Side Validation / Tooltips
				activate_tooltip_for_form_element( $('#form-content-area').find('form') );
				activate_validation_for_required_form_element( $('#form-content-area').find('form') );
					
			$("a.clear-form-button")
			.on("click", function(e){
				e.preventDefault();
				$(this).parents("div#form-content-area").empty();
			});
			break;
			}
		}
		
		//Bind Form Submit Event
		$('#form-content-area')
		.find('form')
		.bind('submit', function( e ){
			e.preventDefault();
			
			submit_form_data( $(this) );
			
		});
		
		//Bind form submission event
		//action_button_submit_form();
		select_record_click_function();
		
		//Activate Ajax file upload
		createUploader();
		
		handleDatePickers( $('#form-content-area').find('form') );
	};
	
	prepare_new_record_form_new();
	function prepare_new_record_form_new(){
		
		//Bind Html text-editor
		bind_html_text_editor_control();
		
		//Activate Client Side Validation / Tooltips
		activate_tooltip_for_form_element( $('form.activate-ajax').not('.ajax-activated') );
		activate_validation_for_required_form_element( $('form.activate-ajax').not('.ajax-activated') );
		
		//Bind Form Submit Event
		$('form.activate-ajax')
		.not('.ajax-activated')
		.bind('submit', function( e ){
			e.preventDefault();
			submit_form_data( $(this) );
		});
		
		//Bind form submission event
		//action_button_submit_form();
		//select_record_click_function();
		
		//Activate Ajax file upload
		createUploader();
		handleDatePickers( $('form.activate-ajax').not('.ajax-activated') );
		
		$("a.clear-form-button")
		.on("click", function(e){
			e.preventDefault();
			$(this).parent().remove();
		});
		
		$('form.activate-ajax').addClass('ajax-activated');
	};
	
	function handleDatePickers( $form ) {
        if ( $form && jQuery().datepicker) {
			var FromEndDate = new Date();
			
            $form
			.find('input[type="date"]')
			.not(".limit-date")
			.datepicker({
                rtl: App.isRTL(),
                autoclose: true,
				format: 'yyyy-mm-dd',
            });
			
            $form
			.find('input.limit-date')
			.datepicker({
                rtl: App.isRTL(),
                autoclose: true,
				format: 'yyyy-mm-dd',
				endDate: FromEndDate, 
            });
            $('body').removeClass("modal-open"); // fix bug when inline picker is used in modal
        }
    };
	
	var reload_table_after_form_submit = 1;
	
	function submit_form_data( $me ){
		if( $me.data('do-not-submit') ){
			return false;
		}
		
		reload_table_after_form_submit = 1;
		if( $me.data('reload-table') ){
			reload_table_after_form_submit = $me.data('reload-table');
		}
		//console.log('r',reload_table_after_form_submit);
		
		ajax_data = $me.serialize();
	
		form_method = 'post';
		ajax_data_type = 'json';	//SAVE CHANGES, SEARCH
		ajax_action = 'request_function_output';
		//ajax_action = 'submit_form_data';
		
		ajax_container = '';
		ajax_get_url = $me.attr('action');
		
		ajax_notice_container = 'window';
		
		ajax_send();
	};
	
	function bind_html_text_editor_control(){
		return 0;
		$('#myModal')
		.not(".modal-key-down-bind")
		.on('show.bs.modal', function(){
			tinyMCE.activeEditor.setContent( editing_textarea.val() );
		})
		.on('hide.bs.modal', function(){
			editing_textarea
			.val( $("#popTextArea_ifr").contents().find("body").html() );
		})
		.addClass("modal-key-down-bind");
	
		$('textarea')
		.not('.key-down-bind')
		.bind('keydown', function(e){
		
			switch(e.keyCode){
			case 69:	//E Ctrl [17]
				if(e.ctrlKey){
					e.preventDefault();
					
					editing_textarea = $(this);
					
					//Set Contents
					$('#myModal')
					.modal('show');
					
					$(this).attr('tip', '');
					display_tooltip($(this), '');
				}
			break;
			}
			
		})
		.bind('focus', function(){
			$(this).attr('tip', 'Press Ctrl+E to display full text editor');
			
			display_tooltip($(this), '');
		})
		.bind('blur', function(){
			$(this).attr('tip', '');
			
			display_tooltip($(this), '');
		})
		.addClass("key-down-bind");
	};
	
	//File Uploader
	function createUploader(){
		return 0;
		if($('.upload-box').hasClass('cell-element')){
			
			$("a.delete-uploaded-file")
			.not("bound")
			.on("click", function(e){
				e.preventDefault();
				var $e = $( 'input[name="' + $(this).attr("element") + '"]' );
				var val = $(this).attr("id");
				
				if( val ){
					var content = $e.val();
					if( content ){
						var r = content.replace( ":::" + val , "" ).replace( val , "" );
						
						$(this).parents("span.upload-file-wrap").remove();
						$e.val( r );
					}
					
				}
			})
			.addClass("bound");
							
			$('.upload-box').each(function(){
				var id = $(this).attr('id');
				var name = $(this).find('input').attr('name');
				var acceptable_files_format = $(this).find('input').attr('acceptable-files-format');
				var table = $("#"+id).parents('form').find('input[name="table"]').val();
				var form_id = $("#"+id).parents('form').find('input[name="processing"]').val();
				var form_record_id = $("#"+id).parents('form').find('input[name="id"]').val();
				var actual_form_id = $("#"+id).parents('form').attr('id');
				
				//instead of sending processing id | rather send record id
				if( form_record_id && form_record_id.length > 1 )form_id = form_record_id;
				
				$("."+name+"-replace").attr( 'name' , $(this).find('input').attr('name') );
				$("."+name+"-replace").attr( 'id' , $(this).find('input').attr('id') );
				$("."+name+"-replace").attr( 'class' , $(this).find('input').attr('class') );
				$("."+name+"-replace").attr( 'alt' , $(this).find('input').attr('alt') );
				
				var uploader = new qq.FileUploader({
					element: document.getElementById(id),
					listElement: document.getElementById('separate-list'),
					action: pagepointer+'php/upload.php',
					params: {
						tableID: table,
						formID: form_id,
						name:name,
						actualFormID:actual_form_id,
						acceptable_files_format:acceptable_files_format,
					},
					onComplete: function(id, fileName, responseJSON){
						if(responseJSON.success=='true' && responseJSON.stored_name ){
							$('.qq-upload-success')
							.find('.qq-upload-failed-text')
							.html('<span style="color:#ff6600;">Success</span> <a href="#" class="remove-uploaded-file" id="'+responseJSON.stored_name+'" element="'+responseJSON.element+'"><i class="icon-trash"></i> Remove File</a>');
							
							if( $('form.quick-edit-form').is(":visible") && $('form.quick-edit-form').find("."+responseJSON.element+"-row").is(":visible") ){
								$('form.quick-edit-form').data('pending', 1 );
							}
							if( responseJSON.stored_name ){
								var i = $('input[name="'+responseJSON.element+'"]').val();
								if( i && i.length > 1 )i = i + ":::" + responseJSON.stored_name;
								else i = responseJSON.stored_name;
								$('input[name="'+responseJSON.element+'"]').val( i );
							}
							
							$("a.remove-uploaded-file")
							.not("bound")
							.on("click", function(e){
								e.preventDefault();
								var $e = $( 'input[name="' + $(this).attr("element") + '"]' );
								var val = $(this).attr("id");
								
								if( val ){
									var content = $e.val();
									if( content ){
										var r = content.replace( ":::" + val , "" ).replace( val , "" );
										
										$(this).parents("li").remove();
										$e.val( r );
									}
									
								}
							})
							.addClass("bound");
							
						}else{
							//alert('failed');
						}
					}
				});
			});
			
		}
	};
	
	var g_report_title = '';
	var g_all_signatories_html = '';
	
	bind_quick_print_function();
	function bind_quick_print_function(){
		$('button#summary-view')
		.live('click', function(){
			$('#example')
			.find('tbody')
			.find('tr')
			.not('.total-row')
			.toggle();
		});
		
		$('body')
		.on('click', 'a.quick-print', function(e){
			e.preventDefault();
			
			var html = get_printable_contents( $(this) );
			if( $("#datatable-title") && $("#datatable-title").text() ){
				g_report_title = $("#datatable-title").text();
			}
			
			if( ! g_report_title ){
				g_report_title = $('title').text();
			}
			
			
			var x=window.open();
			x.document.open();
			x.document.write( '<link href="'+ $('#print-css').attr('href') +'" rel="stylesheet" />' + '<body style="padding:0;">' + g_report_title + html + g_all_signatories_html + '</body>' );
			x.document.close();
			x.print();
		});
		
		$('input.advance-print-preview, input.advance-print')
		.live('click', function(e){
			e.preventDefault();
			
			var html = get_printable_contents( $(this) );
			
			var report_title = $('title').text();
			if( $("#datatable-title") && $("#datatable-title").text() ){
				report_title = $("#datatable-title").text();
			}
			
			var $form = $('.popover-content').find('form.report-settings-form');
			
			var r_title = $form.find('input[name="report_title"]').val();
			var r_sub_title = $form.find('input[name="report_sub_title"]').val();
			
			var orientation = $form.find('select[name="orientation"]').val();
			var paper = $form.find('select[name="paper"]').val();
			
			var rfrom = $form.find('input[name="report_from"]').val();
			var rto = $form.find('input[name="report_to"]').val();
			var rref = $form.find('input[name="report_ref"]').val();
			
			var opening_text = $form.find('textarea[name="opening_text"]').val();
			var closing_text = $form.find('textarea[name="closing_text"]').val();
			var alignment = $form.find('select[name="alignment"]').val();
			
			var rdepartment_filter_id = "";
			var rdepartment_filter = "";
			if( $('#department-filter') && $('#department-filter').text() )
				rdepartment_filter = $('#department-filter').text();
			
			if( $('#department-filter') && $('#department-filter').attr("jid") )
				rdepartment_filter_id = $('#department-filter').attr("jid");
			
			var r_type = '';
			var r_user_info = '';
			
			if( $(this).hasClass( 'advance-print' ) ){
				var r_type = $form.find('input[name="report_type"]').filter(':checked').val();
				
				if( $form.find('input[name="report_show_user_info"]').is(':checked') ){
					var r_user_info = 'yes';
				}
			}
			
			var r_signatory = $form.find('input[name="report_signatories"]').val();
			
			var r_template = $form.find('select[name="report_template"]').val();
			var r_ainfo = $form.find('input[name="additional_info"]').val();
			
			g_all_signatories_html = '';
			g_report_title = '';
			
			if( r_title ){
				report_title = '<h3 style="text-align:center;">' + r_title + ' ';
				
				if( r_sub_title ){
					report_title += '<small style="display:block;">' + r_sub_title + '</small>';
				}
				
				report_title += '</h3>';
				
				g_report_title = report_title;
			}
			
			var all_signatories_html = '';
			var signatories_html = '';
			if( r_signatory ){
				if( $form.find('#report-signatory-fields').is(':visible') ){
					
					signatories_html = '<table width="100%">';
					
					$form
					.find('.signatory-fields')
					.each( function(){
						if( $(this).val() ){
							signatories_html += '<tr><td width="20%">' + $(this).val() + '</td><td style="border-bottom:1px solid #dddddd;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>';
						}
					} );
					
					signatories_html += '</table>';
				}
				
				all_signatories_html = '<div><table width="100%"><tr>';
				
				for( var i = 0; i < r_signatory; i++ ){
					all_signatories_html += '<td style="padding:10px;">';
						all_signatories_html += signatories_html;
					all_signatories_html += '</td>';
				}
				
				all_signatories_html += '</tr></table></div>';
				
				g_all_signatories_html = all_signatories_html;
			}
			
			switch( r_type ){
			case "mypdf":
				ajax_get_url = '?action='+r_type+'&todo=generate_pdf';
				
				ajax_data = {html:html + all_signatories_html, current_module:$('#active-function-name').attr('function-class'), current_function:$('#active-function-name').attr('function-id'), report_title:report_title, report_show_user_info:r_user_info , orientation:orientation, paper:paper, rfrom:rfrom, rto:rto, rref:rref, report_template:r_template, info:r_ainfo, department_filter:rdepartment_filter, opening_text:opening_text, closing_text:closing_text, alignment:alignment, department_filter_id:rdepartment_filter_id };
		
				form_method = 'post';
				ajax_data_type = 'json';
				ajax_action = 'request_function_output';
				ajax_container = '';
				ajax_send();
			break;
			case "myexcel":
				ajax_get_url = '?action='+r_type+'&todo=generate_excel';
				ajax_data = {html:html, current_module:$('#active-function-name').attr('function-class'), current_function:$('#active-function-name').attr('function-id') , report_title:report_title, rfrom:rfrom, rto:rto, rref:rref, report_template:r_template, info:r_ainfo, department_filter:rdepartment_filter, opening_text:opening_text, closing_text:closing_text, alignment:alignment, department_filter_id:rdepartment_filter_id };
		
				form_method = 'post';
				ajax_data_type = 'json';
				ajax_action = 'request_function_output';
				ajax_container = '';
				ajax_send();
			break;
			default:
				var x=window.open();
				x.document.open();
				if( opening_text )opening_text = "<br />" + opening_text + "<br />";
				if( closing_text )closing_text = "<br />" + closing_text + "<br />";
				x.document.write( '<link href="'+ $('#print-css').attr('href') +'" rel="stylesheet" />' + '<body style="padding:0;"><div id="watermark"></div>' + report_title + opening_text + html + closing_text + all_signatories_html + '</body>' );
				x.document.close();
				
				if( $(this).hasClass( 'advance-print' ) ){
					x.print();
				}
			break;
			}
		});
	};
	
	function get_printable_contents( $printbutton ){
		var html = '';
		
		if( $printbutton.attr('merge-and-clean-data') && $printbutton.attr('merge-and-clean-data') == 'true' ){
			var $content = $( $printbutton.attr('target') ).clone();
			
			//Get Records
			var target_table = $printbutton.attr('target-table');
			var tbody = $content.find(target_table).find('tbody');
			
			//Remove Action Button Column
			tbody.find('.view-port-hidden-table-row').remove();
			tbody.find('.remove-before-export').parents('td').remove();
			
			tbody.find('.hide-custom-view-select-classes').remove();
			
			tbody.find('.line-items-space-row').find("td").html("");
			
			//Get Heading
			var thead = $content.find('.dataTables_scrollHeadInner').find('thead');
			if( thead ){
				thead.find('th').css('width','auto');
				
				//Remove Action Button Column
				thead.find('.remove-before-export').parents('th').remove();
				thead.find('.remove-before-export').remove();
				
				//Adjust Colspan
				thead
				.find('.change-column-span-before-export')
				.attr('colspan', thead.find('.change-column-span-before-export').attr('exportspan') );
			}
			
			//Get Screen Data
			html = '<div id="dynamic"><table class="'+$content.find(target_table).attr('class')+'" width="100%" style="position:relative;" cellspacing="0" cellpadding="0"><thead>'+thead.html()+'</thead><tbody>'+tbody.html()+'</tbody></table></div>';
		}else{
			html = $( $printbutton.attr('target') ).html();
		}
		
		return html;
	};
	
	function no_record_selected_prompt(){
		//alert('display prompt that no record was selected');
		var data = {theme:'alert-info', err:'No Selected Record', msg:'Please select a record by clicking on it', typ:'jsuerror' };
		display_notification( data );
	};
	
	function no_function_selected_prompt(theme, message_title, message_message, auto_close){
		//alert('display prompt that no record was selected');
		
		/*
		var html = '<div data-role="popup" data-dismissible="false" data-transition="slide" id="errorNotice" data-position-to="#" class="ui-content" data-theme="'+theme+'">';
			html += '<a href="" data-rel="back" data-role="button" data-theme="a" data-icon="delete" data-iconpos="notext" class="ui-btn-right no-print">Close</a>';
			html = html + '<h3>'+message_title+'</h3>';
			html = html + '<p>'+message_message+'</p>';
		html = html + '</div>';
		
		ajax_container
		.append(html)
		.trigger("create");
		
		//Display Notification Popup
		display_popup_notice( auto_close );
		*/
	};
	
	function getDataTableID( type ){
		switch( type ){
		case 1:
			if( tmp_data && tmp_data.data_table_name ){
				return tmp_data.data_table_name + '-datatable';
			}
		break;
		}
		return $('#dynamic').attr("data-table") + "-datatable";
	};
	
	function bind_popover_controls(){
		var $parent = $(this).parent();
		
		$('a.pop-up-button-control')
		.not("bound")
		.on("click", function(){
			//if( $(this).data("remove") )
				$(this).attr("function-id","");
			//else
				$(this).data("remove",1);
		});
		
		$('a.pop-up-button-control')
		.not("bound")
		.popover({
			html:true,
			container:$("#form-home-control-handle"),
			content:function(){
				if( ! $(this).data("insert") ){
					var html = $(this).next('div.pop-up-content').html();
					$(this).data("insert", 1);
					$(this).next('div.pop-up-content').remove();
					return html;
				}
			},
		})
		.addClass("bound");;
		
	};
	
	function bind_details_view_control(){
        //Bind Delete Buttons Event
        if( $('a.quick-details-field') ){
            $('a.quick-details-field')
            .bind('click',function(e){
                e.preventDefault();
                
                ajax_data = {};
                form_method = 'post';
                ajax_data_type = 'json';
                
                ajax_action = 'request_function_output';
                ajax_container = '';
                ajax_get_url = $(this).attr('action');
                ajax_send();
            });
        }
    };
	
	//Bind Multi-select option tooltip
	var timer_interval;
	var mouse_vertical_position;
	
	var progress_bar_timer_id;
	function progress_bar_change(){
		var total = 97;
		var step = 1;
		
		if(function_click_process==0){
			var $progress = $('#virtual-progress-bar').find('.progress-bar');
			
			if($progress.data('step') && $progress.data('step')!='undefined'){
				step = $progress.data('step');
			}
			
			var percentage_step = (step/total)*100;
			++step;
			
			if( percentage_step > 100 ){
				$progress
				.css('width', '100%');
				
				$('#virtual-progress-bar')
				.remove();
				
				//Refresh Page
				function_click_process = 1;
				
				//Stop All Processing
				//window.stop();
				
				//Display Timeout Error Message
				var theme = 'a';
				var message_title = 'Server Script Timeout Error';
				var message_message = "The request was taking too long!<br /><br /><h4>Request Parameters</h4>" + ajax_request_data_before_sending_to_server;
				var auto_close = 'no';
				
				no_function_selected_prompt(theme, message_title, message_message, auto_close);
				
			}else{
				$progress
				.data('step',step)
				.css('width', percentage_step+'%');
				
				progress_bar_timer_id = setTimeout(function(){
					progress_bar_change();
				},1000);
			}
		}else{
			$('#virtual-progress-bar')
			.find('.progress-bar')
			.css('width', '100%');
			
			setTimeout(function(){
				$('#virtual-progress-bar')
				.remove();
			},1500);
		}
	};
	
	function display_tooltip(me, name, removetip){
		
		if( removetip ){
			$('#ogbuitepu-tip-con').fadeOut(800);
			return;
		}
		
		//Check if tooltip is set
		if(me.attr('tip') && me.attr('tip').length > 1){
			$('#ogbuitepu-tip-con')
			.find('> div')
			.html(me.attr('tip'));
			
			//Display tooltip
			var offsetY = 8;
			var offsetX = 12;
			
			//var left = me.offset().left - (offsetX + $('#ogbuitepu-tip-con').width() );
			//var top = (me.offset().top + ((me.height() + offsetY)/2)) - ($('#ogbuitepu-tip-con').height()/2);
			
			var left = me.offset().left;
			var top = (me.offset().top + ((me.height() + offsetY)));
			
			if( parseFloat( name ) ){
				top = (name) - ($('#ogbuitepu-tip-con').height()/2);
			}
			
			$('#ogbuitepu-tip-con')
			.find('> div')
			.css({
				padding:me.css('padding'),
			});
			
			$('#ogbuitepu-tip-con')
			.css({
				width:me.width()+'px',
				top:top,
				left:left,
			})
			.fadeIn(800);
		}else{
			//Hide tooltip container
			$('#ogbuitepu-tip-con').fadeOut(800);
		}
		
	};
	
	$('<style>.invalid-data{ background:#faa !important; }</style><div id="ogbuitepu-tip-con"><div></div></div>').prependTo('body');
	$('#ogbuitepu-tip-con')
	.css({
		position:'absolute',
		display:'none',
		top:0,
		left:0,
		backgroundColor:'transparent',
		backgroundImage:'url('+pagepointer+'images/tip-arrow-r.png)',
		backgroundPosition:'top center',
		backgroundRepeat:'no-repeat',
		opacity:0.95,
		paddingTop:'11px',
		/*width:'220px',*/
		height:'auto',
		color:'#fff',
		zIndex:90000,
	});
	$('#ogbuitepu-tip-con')
	.find('> div')
	.css({
		position:'relative',
		background:'#ee1f19',
		opacity:0.95,
		/*padding:'5%',*/
		width:'100%',
		height:'95%',
		color:'#fff',
		textShadow:'none',
		borderRadius:'8px',
		boxShadow:'1px 1px 3px #222',
		fontSize:'0.85em',
		fontFamily:'arial',
	});

	function activate_tooltip_for_form_element( $form ){
		$form
		.find('.form-gen-element')
		.bind('focus',function(){
			display_tooltip($(this) , $(this).attr('name'), false);
		});
		
		$form
		.find('.form-gen-element')
		.bind('blur',function(){
			display_tooltip( $(this) , '', true );
		});
	};
	
	function activate_validation_for_required_form_element( $form ){
		$form
		.find('.form-element-required-field')
		.bind('blur',function(){
			validate( $(this) );
		});
		
		$form
		.not('.skip-validation')
		.bind('submit', function(){
			
			$(this)
			.find('.form-element-required-field')
			.blur();
			
			if( $(this).find('.form-element-required-field').hasClass('invalid-data') ){
				$(this)
				.find('.invalid-element:first')
				.focus();
				
				$(this).data('do-not-submit', true);
				
				//display notification to fill all required fields
				var data = {
					typ:'jsuerror',
					err:'Invalid Form Field',
					msg:'Please do ensure to correctly fill all required fields with appropriate values',
				};
				display_notification( data );
				
				return false;
			}
			
			$(this).data('do-not-submit', false);
			
		});
		
	};
	
	function validate( me ){
		//var e = $('#required'+name);
		//alert(e.attr('alt'));
		
		if( testdata( me.val() , me.attr('alt') ) ){
			if(me.hasClass('invalid-data')){
				me.removeClass('invalid-data').addClass('valid-data');
			}else{
				me.addClass('valid-data');
			}
		}else{
			if(me.hasClass('valid-data')){
				me.addClass('invalid-data').removeClass('valid-data');
			}else{
				me.addClass('invalid-data');
			}
		}
	};
	
	function testdata(data,id){
		
		switch (id){
		case 'text':
		case 'textarea':
		case 'upload':
			if(data.length>0)return 1;
			else return 0;
		break;
		case 'category':
			if(data.length>11)return 1;
			else return 0;
		break;
		case 'number':
		case 'currency':
			/*/[^0-9\-\.]/g*/
			data = ( data.replace( ",", '' ) );
			return (data - 0) == data && data.length > 0;
		break;
		case 'email':
			return vemail(data);
		break;
		case 'password':
			return vpassword(data);
		break;
			if(data.length>6)return 1;
			else return 0;
		break;
		case 'phone':
		case 'tel':
			return vphone(data);
			break;
		case 'select':
		case 'multi-select':
			return data;
			break;
		case 'date':
			return data;
			break;
		default:
			return 0;
		}
	};
	
	function vphone(phone) {
		var phoneReg = /[a-zA-Z]/;
		if( phone.length<5 || phoneReg.test( phone ) ) {
			return 0;
		} else {
			return 1;
		}
	};
	
	function vemail(email) {
		
		var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
		if( email.length<1 || !emailReg.test( email ) ) {
			return 0;
		} else {
			return 1;
		}
	};
	
	var pass = 0;
	function vpassword(data){
		if($('input[type="password"]:first').val()!=pass){
			pass = 0;
		}
		
		if(!pass){
			//VERIFY PASSWORD
			if( data.length > 6 ){
				/*
				//TEST FOR AT LEAST ONE NUMBER
				var passReg = /[0-9]/;
				if( passReg.test( data ) ) {
					//TEST FOR AT LEAST ONE UPPERCASE ALPHABET
					passReg = /[A-Z]/;
					if( passReg.test( data ) ){
						//TEST FOR AT LEAST ONE LOWERCASE ALPHABET
						passReg = /[a-z]/;
						if( passReg.test( data ) ){
							//STORE FIRST PASSWORD
							pass = data;
							return 1;
						}else{
							//NO LOWERCASE ALPHABET IN PASSWORD
							pass = 0;
							return 0;
						}
					}else{
						//NO UPPERCASE ALPHABET IN PASSWORD
						pass = 0;
						return 0;
					}
				}else{
					//NO NUMBER IN PASSWORD
					pass = 0;
					return 0;
				}
				*/
				pass = data;
				return 1;
			}else{ 
				pass = 0;
				return 0;
			}
			/*
			a.	User ID and password cannot match
			b.	Minimum of 1 upper case alphabetic character required
			c.	Minimum of 1 lower case alphabetic character required
			d.	Minimum of 1 numeric character required
			e.	Minimum of 8 characters will constitute the password
			*/
		}else{
			//CONFIRM SECOND PASSWORD
			if(data==pass)return 1;
			else return 0;
		}
	};
	/******************************************************/
	
	function refresh_tree_view(){
		if( $('#ui-navigation-tree') ){
			var instance = $('#ui-navigation-tree').jstree(true);
			if( instance )instance.refresh();
		}
	};
	
	function activate_tree_view_main( selector ){
		var action = "budget";
		var record_id = "";
		var todo = "get_operators";
		var operator_id = "";
		
		if( tmp_data && tmp_data.tree_action && tmp_data.tree_todo ){
			action = tmp_data.tree_action;
			todo = tmp_data.tree_todo;
			
			if( tmp_data.record_id )record_id = tmp_data.record_id;
			if( tmp_data.operator_id )operator_id = tmp_data.operator_id;
		}
		$( selector )
		.on("changed.jstree", function (e, data) {
			if(data.selected.length) {
				switch( $(this).attr("id") ){
				case 'ui-navigation-tree':
					//console.log(data.instance.get_node(data.selected[0]));
					var d = data.instance.get_node(data.selected[0]).id;
					var ids = d.split(':::');
					if( ids.length > 3 ){
						class_name = ids[0];
						var db_class_name = ids[0];
						var mc = '';
						var md = '';
						if( ids[4] ){
							mc = ids[4];
							switch( class_name ){
							case "returns_reporting_view":
							case "cash_calls_reporting_view":
								db_class_name = "cash_calls_" + ids[2] + "_" + ids[3];
							break;
							}
							
							switch( class_name ){
							case "budget_details":
							case "returns":
							case "cash_calls":
							case "returns_reporting_view":
							case "cash_calls_reporting_view":
							case "tendering":
								//check if parent table is visible
								if( ! $('table.display').hasClass( db_class_name ) ){
									var f = data.instance.get_node(data.selected[0]).parent;
									data.instance.deselect_all();
									data.instance.select_node( f );
									
									var ids = f.split(':::');
									
									var data = {theme:'alert-info', err:'Parent Item was not clicked', msg:'Please click item '+data.instance.get_node(data.selected[0]).text+' once more to filter', typ:'jsuerror' };
									display_notification( data );
									return 1;
								}
							break;
							}
						}
						
						if( ids[5] ){
							md = ids[5];
						}
						switch( class_name ){
						case "tenders_and_contracts":
						case "tendering":
						case "tendering_reports":
							if( ids[1] != 'generate_reports'  && ids[1] != 'display_new_tendering_view' )
								ids[1] = "display_datatable_view";
							
							var display_view = $("#tendering-select-tree-view-activator").val();
							ajax_data = { action:ids[0], todo:ids[1], year_and_month:ids[2], tender_filter:ids[3], operator_filter:mc, display_view:display_view };
						break;
						case "exploration":
						case "exploration_drilling":
						case "exploration_activities":
						case "geophysics_plan_and_actual_performance":
						case "resource_volumes":
							if( ids[1] != 'generate_reports'  && ids[1] != 'display_new_record_view' )
								ids[1] = "display_datatable_view";
							
							var display_view = $("select#exploration-select-tree-view-activator").val();
							ajax_data = { action:ids[0], todo:ids[1], year_and_month:ids[2], tender_filter:ids[3], operator_filter:mc, display_view:display_view };
						break;
						case "divisional_reports":
							var display_view = $("select#divisional-reports-select-tree-view-activator").val();
							ajax_data = { action:ids[0], todo:ids[1], month:ids[2], budget_id:ids[3], main_code:mc, department:md, display_view:display_view };
						break;
						default:
							ajax_data = { action:ids[0], todo:ids[1], month:ids[2], budget_id:ids[3], main_code:mc, department:md };
						break;
						}
						
						ajax_get_url = "";
						form_method = 'get';
						ajax_data_type = 'json';
						ajax_action = 'request_function_output';
						ajax_container = '';
						ajax_send();
					}
				break;
				case 'reports-table-of-content-tree-view':
					var d = data.instance.get_node(data.selected[0]).id;
					$('iframe#iframe-container-of-content')
					.attr( 'src', $('iframe#iframe-container-of-content').attr('data-src')+'#'+d );
					
					$(document).scrollTop(0);
				break;
				}
			}
		})
		.jstree({
			'core' : {
				'data' : {
					"url" : pagepointer+'php/ajax_request_processing_script.php?action='+action+'&todo='+todo+'&id='+record_id+'&record_id='+record_id+'&operator='+operator_id,
					"dataType" : "json", // needed only if you do not supply JSON headers
					"data" : function (node) {
						return { "id" : node.id, "method" : node.id };
					}
				}
			}
		});
		
	};
	
	function activate_tree_view(){
		$("select#operators-select-tree-view-activator")
		.bind( "change" , function(e){
			var l = $(this).val();
			if( l ){
				tmp_data.tree_action = "budget";
				tmp_data.tree_todo = "get_operators";
				tmp_data.operator_id = l;
				
				$("#ui-navigation-tree-container")
				.html('<div id="ui-navigation-tree" class="demo"></div>');
				
				activate_tree_view_main( '#ui-navigation-tree' );
				
				tmp_data = {};
			}
		});
	};
	
	function activate_exploration_tree_view(){
		$("select#exploration-select-tree-view-activator")
		.bind( "change" , function(e){
			var l = $(this).val();
			if( l ){
				tmp_data.tree_action = "exploration";
				tmp_data.tree_todo = "get_exploration_tree_view";
				tmp_data.record_id = l;
				
				$("#tree-view-selector-container")
				.html('<div id="ui-navigation-tree" class="demo"></div>');
				
				activate_tree_view_main( '#ui-navigation-tree' );
				
				tmp_data = {};
			}
		}).change();
	};
	
	function activate_tendering_tree_view(){
		$("select#tendering-select-tree-view-activator")
		.bind( "change" , function(e){
			var l = $(this).val();
			if( l ){
				tmp_data.tree_action = "tenders_and_contracts";
				tmp_data.tree_todo = "get_tenders_and_contracts_tree_view";
				tmp_data.record_id = l;
				
				$("#tree-view-selector-container")
				.html('<div id="ui-navigation-tree" class="demo"></div>');
				
				activate_tree_view_main( '#ui-navigation-tree' );
				
				tmp_data = {};
			}
		}).change();
	};
	
	function activate_tree_view_new(){
		if( $("select#divisional-reports-select-tree-view-activator") && $("select#divisional-reports-select-tree-view-activator").is(":visible") ){
			if( tmp_data ){
				tmp_data.operator_id = $("select#divisional-reports-select-tree-view-activator").val();
				
				$("select#divisional-reports-select-tree-view-activator")
				.attr("tree_action", tmp_data.tree_action )
				.attr("tree_todo", tmp_data.tree_todo );
			}
			
			$("select#divisional-reports-select-tree-view-activator")
			.not("activated")
			.on("change", function(e){
				$('#tree-view-selector-container').html('<div id="ui-navigation-tree" class="demo"></div>');
				tmp_data.tree_action = $(this).attr("tree_action");
				tmp_data.tree_todo = $(this).attr("tree_todo");
				tmp_data.operator_id = $(this).val();
				activate_tree_view_main( '#ui-navigation-tree' );
			})
			.addClass("activated");
		}
		activate_tree_view_main( '#ui-navigation-tree' );
	};
	
	function activate_divisional_report_content_tree_view(){
		activate_tree_view_main( '#reports-table-of-content-tree-view' );
	};
	
	function activate_iframe_tinymce(){
		
	};
	
	function activate_export_to_word_button(){
		$("#save-editable-content")
		.bind("click", function(){
			var $clone = $( $(this).attr('iframe-target') ).contents().find("body");
			
			var html = '<div class="head">' + $clone.find(".head").html() + '</div><div class="body">' + $clone.find(".body").html() + '</div><div class="foot">' + $clone.find(".foot").html() + '</div>';
			var report_title = $( $(this).attr('title-target') ).text();
			var report_id = $( $(this).attr('iframe-target') ).attr('report-id');
			
			ajax_get_url = $(this).attr('action');
			ajax_data = { report_id:report_id, html:html, current_module:$('#active-function-name').attr('function-class'), current_function:$('#active-function-name').attr('function-id') , report_title:report_title };

			form_method = 'post';
			ajax_data_type = 'json';
			ajax_action = 'request_function_output';
			ajax_container = '';
			ajax_send();
		});
	};
	
	function activate_export_pdf_button(){
		$("#export-to-pdf")
		.bind("click", function(){
			var html = $( $(this).attr('iframe-target') ).contents().find("body").find(".body").html();
			
			var report_title = $( $(this).attr('title-target') ).text();
			var report_id = $( $(this).attr('iframe-target') ).attr('report-id');
			var exclude_header = "";
			if( $( $(this).attr('iframe-target') ).attr('exclude-header') );
				exclude_header = $( $(this).attr('iframe-target') ).attr('exclude-header');
			
			ajax_get_url = $(this).attr('action');
			ajax_data = { report_id:report_id, html:html, current_module:$('#active-function-name').attr('function-class'), current_function:$('#active-function-name').attr('function-id') , report_title:report_title, exclude_header:exclude_header, rfrom:$(this).attr("data-from"), rto:$(this).attr("data-to"), rref:$(this).attr("data-ref") };

			form_method = 'post';
			ajax_data_type = 'json';
			ajax_action = 'request_function_output';
			ajax_container = '';
			ajax_send();
		});
		
		$("#export-to-ms-word")
		.bind("click", function(){
			var html = $( $(this).attr('iframe-target') ).contents().find("body").find(".body").html();
			var report_title = $( $(this).attr('title-target') ).text();
			var report_id = $( $(this).attr('iframe-target') ).attr('report-id');
			var exclude_header = "";
			if( $( $(this).attr('iframe-target') ).attr('exclude-header') );
				exclude_header = $( $(this).attr('iframe-target') ).attr('exclude-header');
			
			ajax_get_url = $(this).attr('action');
			ajax_data = { report_id:report_id, html:html, current_module:$('#active-function-name').attr('function-class'), current_function:$('#active-function-name').attr('function-id') , report_title:report_title, exclude_header:exclude_header, rfrom:$(this).attr("data-from"), rto:$(this).attr("data-to"), rref:$(this).attr("data-ref") };

			form_method = 'post';
			ajax_data_type = 'json';
			ajax_action = 'request_function_output';
			ajax_container = '';
			ajax_send();
		});
	};
	
	function activate_highcharts(){
		if( tmp_data && Object.getOwnPropertyNames( tmp_data ).length && tmp_data.highchart_data && tmp_data.highchart_container_selector ){
			nwHighCharts.initChart( tmp_data );
		}else{
			alert("Could not Generate Chart, due to invalid data");
		}
	};
	
	function activate_and_export_highcharts(){
		if( tmp_data && Object.getOwnPropertyNames( tmp_data ).length && tmp_data.highchart_data && tmp_data.highchart_container_selector ){
			var dataString = nwHighCharts.initChartAndExport( tmp_data );
			
			$.ajax({
				type: 'POST',
				data: dataString,
				url: pagepointer + 'classes/highcharts/exporting-server/php/php-batik/',
				success: function( data ){
					//console.log( data );
					resume_reprocessing();
				}
			});
		}else{
			alert("Could not Generate Chart, due to invalid data");
		}
	};
	
	function pause_reprocessing(){
		//console.log('pause');
		if( tmp_data && Object.getOwnPropertyNames( tmp_data ).length && tmp_data.re_process_code ){
			if( tmp_data.highchart_data )
				delete tmp_data.highchart_data;
			
			if( tmp_data.html )
				delete tmp_data.html;
			
			$(document).data( 're_process', tmp_data );
			tmp_data.re_process = 0;
		}else{
			alert("Could not Pause Processing, due to invalid data");
		}
	};
	
	function resume_reprocessing(){
		if( $(document).data( 're_process' ) ){
			var data = $(document).data( 're_process' );
			if( data.re_process_code )trigger_new_ajax_request( data );
			$(document).data( 're_process', '' );
		}else{
			alert("Could not Resume Processing");
		}
	};
	
	function show_hidden_columns(){
		$(".hidden-column")
		.removeClass("hidden-column");
		
		$(".hidden-column-shown")
		.removeClass( $(".hidden-column-shown").attr("old-class") )
		.addClass( $(".hidden-column-shown").attr("new-class") )
		.removeClass("hidden-column-shown");
		
		if( $( "table.activated-table") ){
			
			$( "table.activated-table")
			.dataTable()
			.fnAdjustColumnSizing();
		}
	};
	
	var isOverIFrame = false;
	$('body')
	.on('mouseout', 'iframe[name="help"]', function(e){
		$(document).scrollTop(0);
	});
});

var nwResizeWindow = function () {
	
    return {
        //main function to initiate the module
        e1: "#dash-board-main-content-area",
        e2: ".dataTables_scrollBody",
        e3: "#excel-import-form-container",
        e4: "#chart-container-parent",
        e5: ".resizable-height",
        init: function () {
			$(window).on("resize", function(){
				nwResizeWindow.resizeWindow();
			});
        },
		resizeWindow: function () {
			
			var sel = nwResizeWindow.e2;
			if( $(sel).is(":visible") ){
				if( $(sel).length > 1 ){
					$(sel).each(function(){
						nwResizeWindow.resizeWindowAction( $(this) );
					});
				}else{
					nwResizeWindow.resizeWindowAction(sel);
				}
			}else{
				var sel = nwResizeWindow.e3;
				if( $(sel).is(":visible") ){
					nwResizeWindow.resizeWindowAction(sel);
				}else{
					var sel = nwResizeWindow.e4;
					if( $(sel).is(":visible") ){
						nwResizeWindow.resizeWindowAction(sel);
					}
				}
			}
			
			var sel = nwResizeWindow.e5;
			if( $(sel).is(":visible") ){
				nwResizeWindow.resizeWindowAction(sel);
			}
			
			$(document).scrollTop(0);
        },
		resizeWindowAction: function ( sel ) {
			
			var top = $( sel ).offset().top;
			var docHeight = window.innerHeight; //$(window).height();
			
			var h = docHeight - top;
			if( h > 55 ){
				if( $( sel ).hasClass("dataTables_scrollBody") ){
					h -= 55;
				}
				$( sel )
				.css("height", h );
			}else{
				//alert("Screen Height Too Small \n\nPlease Maximize you window");
			}
			
        },
		resizeWindowImport: function () {
			
			var sel = nwResizeWindow.e3;
			nwResizeWindow.resizeWindowAction( sel );
			
        },
		resizeWindowChart: function () {
			
			var sel = nwResizeWindow.e4;
			nwResizeWindow.resizeWindowAction( sel );
			
        },
		adjustColumnSizing: function () {
			setTimeout( function(){
				
			$( "table.activated-table")
			.dataTable()
			.fnAdjustColumnSizing();
			}, 1000 );
        },
		resizeElement: function(){
		  interact('.resize-drag')
		  .draggable({
			onmove: window.dragMoveListener
		  })
		  .resizable({
			preserveAspectRatio: true,
			edges: { left: true, right: true, bottom: true, top: true }
		  })
		  .on('resizemove', function (event) {
			
			var target = event.target,
				x = (parseFloat(target.getAttribute('data-x')) || 0),
				y = (parseFloat(target.getAttribute('data-y')) || 0);

			// update the element's style
			target.style.width  = event.rect.width + 'px';
			target.style.height = event.rect.height + 'px';

			// translate when resizing from top or left edges
			x += event.deltaRect.left;
			y += event.deltaRect.top;

			target.style.webkitTransform = target.style.transform =
				'translate(' + x + 'px,' + y + 'px)';

			target.setAttribute('data-x', x);
			target.setAttribute('data-y', y);
			//target.textContent = Math.round(event.rect.width) + '×' + Math.round(event.rect.height);
			
			var $parent = $(target).parent();
			var $sibling = $(target).next();
			
			$sibling
			.removeClass("col-md-10")
			.addClass("col-md-2")
			.css("width" , $parent.width() - ( $(target).width() + 30 ) + "px" );
		  });
		},
    };
	
}();
