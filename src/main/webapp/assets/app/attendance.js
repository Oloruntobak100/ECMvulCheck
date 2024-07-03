var nwEntryExitLog = {
	data:{},
	gCheck_sum:{},
	init:function(){
    Lock.init();

    var constraints = {
      audio: false,
      video: true
    };

    navigator.mediaDevices.getUserMedia(constraints).
    then(nwEntryExitLog.handleSuccess).catch(nwEntryExitLog.handleError);
      
    // Put variables in global scope to make them available to the browser console.
    var video = window.video = document.querySelector('video');
    var canvas = window.canvas = document.querySelector('canvas');

    $( 'form#sign-in-form' ).on( 'click', 'input[name="pass_code"]', function(){
      canvas.getContext('2d').drawImage(video, 0, 0, video.offsetWidth, video.offsetHeight);
      
      //context.drawImage(video, 0, 0, 320, 240);
      var image = nwEntryExitLog.convertCanvasToImage( canvas );
      
      //post image to server
      $( 'form#sign-in-form' ).find("input[name='image1']").val( image );
    });

    if (!window.DOMTokenList) {
      Element.prototype.containsClass = function(name) {
        return new RegExp("(?:^|\\s+)" + name + "(?:\\s+|$)").test(this.className);
      };

      Element.prototype.addClass = function(name) {
        if (!this.containsClass(name)) {
          var c = this.className;
          this.className = c ? [c, name].join(' ') : name;
        }
      };

      Element.prototype.removeClass = function(name) {
        if (this.containsClass(name)) {
          var c = this.className;
          this.className = c.replace(
            new RegExp("(?:^|\\s+)" + name + "(?:\\s+|$)", "g"), ""
          );
        }
      };
    }

    $.fn.cProcessForm.notifyMe = function ( options, opt ) {
      var permissionLevel = 'unsupported';
      
      if (!window.Notification) {
        console.log('Browser does not support notifications.');
        
      } else {
        var permissionLevel = Notification.permission;
        
        if( opt.show ){
          // check if permission is already granted
          if (Notification.permission === 'granted') {
            // show notification here
            console.log( options );
            var notify = new Notification( options.title ,options);
          } else {
            // request permission from user
            Notification.requestPermission().then(function (p) {
              if (p === 'granted') {
                
              } else {
                permissionLevel = 'user blocked';
                console.log('User blocked notifications.');
              }
            }).catch(function (err) {
              console.error(err);
              permissionLevel = 'permission error';
            });
          }
        }
      }
      
      
      if( opt.get_permission_level ){
        return permissionLevel;
      }
    }

	    $('.b-level').text('Notifications are ' + $.fn.cProcessForm.notifyMe( {}, { get_permission_level : 1 } ) );
	    jQuery(document).ready(function() {    
	      // App.init();
		   
        nwEntryExitLog.submit({
          form: $( 'div#user-attendance' ).find('form[name="sign-in-form"]'),
          back_button: $( 'div#user-attendance' ).find('#back-to-signin'),
          recent_activity: $( 'div#user-attendance' ).find('#chats').find('.chats'),
        });

	    });
	},
  submit: function( options ) {
      // Establish our default settings

      options.form.on('submit', function(e){
        nwEntryExitLog.showProcessing( e );
      });
      options.back_button.on('click', function(e){
        e.preventDefault();
        nwEntryExitLog.hideProcessing( e );
      });
      
      $.fn.cProcessForm.handleSubmission( options.form );
      nwEntryExitLog.populateRecentActivities( options.recent_activity );
  },
  showProcessing: function(){
      $('.pass-code-auth').hide();
      $('.successful-pass-code-auth').hide();
      $('.processing-pass-code-auth').slideDown();
  },
  hideProcessing: function(){
      $('.successful-pass-code-auth').hide();
      $('.processing-pass-code-auth').hide();
      $('.pass-code-auth').slideDown();
  },
  populateRecentActivities: function( $container ){
      $.fn.cProcessForm.ajax_data = {
          ajax_data: {},
          form_method: 'post',
          ajax_data_type: 'json',
          ajax_action: 'request_function_output',
          ajax_container: '',
          ajax_get_url: '?todo=get_recent_activties&action=users_attendance',
      };
      $.fn.cProcessForm.ajax_send.call();
  },
  convertCanvasToImage: function(canvas) {
    var image = new Image();
    return canvas.toDataURL("image/png");
    
    //return image
    image.src = canvas.toDataURL("image/png");
    return image;
  },  
  authenticated_visitor: function(){
      if( $.fn.cProcessForm.returned_ajax_data && $.fn.cProcessForm.returned_ajax_data.error ){

        if( $.fn.cProcessForm.returned_ajax_data.message ){
          var data = {theme:'alert-danger', err:'Error', msg:$.fn.cProcessForm.returned_ajax_data.message, typ:'jsuerror' };
          $.fn.cProcessForm.display_notification( data );
        }
        nwEntryExitLog.hideProcessing();
      }else if( $.fn.cProcessForm.returned_ajax_data && $.fn.cProcessForm.returned_ajax_data.data ){
        var data = $.fn.cProcessForm.returned_ajax_data.data;
        // console.log( data );
        
        if( data.visitor_data.check_sum )gCheck_sum = data.visitor_data.check_sum;
        
        $('.optional-value').hide();
        
        $('.visitor-value').each(function(){
            if( $(this).attr('data-name') && $(this).attr('data-type') ){
                switch( $(this).attr('data-type') ){
                case 'text':
                    if( data.visitor_data[ $(this).attr('data-name') ] ){
                        $(this).text( data.visitor_data[ $(this).attr('data-name') ] );
                        if( $(this).parent().hasClass('optional-value') ){
                            $(this).parent().show();
                        }
                    }
                break;
                case 'src':
                    if( data.visitor_data[ $(this).attr('data-name') ] ){
                        $(this).attr( $(this).attr('data-type') , data.url + 'engine/' + data.visitor_data[ $(this).attr('data-name') ] );
                    }else{
                       $(this).attr( $(this).attr('data-type') , data.url + 'engine/' );
                    }
                break;
                }
            }
        });
        $('.pass-code-auth').hide();
        $('.processing-pass-code-auth').hide();
        $('.successful-pass-code-auth').slideDown();
        
        //add info to recent visitors log
        var h = nwEntryExitLog.get_recent_visitors_html( data );
        if( h ){
            $('#chats').find('.chats').prepend( h );
        }
        
        if( data && data.visitor_data && data.visitor_data.previous_visits && data.visitor_data.previous_visits.data && Object.getOwnPropertyNames(data.visitor_data.previous_visits.data).length ){
            var h = '';
            $.each( data.visitor_data.previous_visits.data , function( key, val ){
                h += nwEntryExitLog.get_previous_visits_html( val );
            });
            if( h ){
                $('tbody#previous-visits').html(h);
                $('.previous-visits-container').show();
            }
        }else{
            $('.previous-visits-container').hide();
        }
      }
  },
  got_recent_activities: function(){
      var h = '';
      if( $.fn.cProcessForm.returned_ajax_data && $.fn.cProcessForm.returned_ajax_data.data && ! $.isEmptyObject( $.fn.cProcessForm.returned_ajax_data.data ) && $.fn.cProcessForm.returned_ajax_data.url ){
          $.each( $.fn.cProcessForm.returned_ajax_data.data, function( key, val ){
              h += nwEntryExitLog.get_recent_visitors_html( { visitor_data: val, url: $.fn.cProcessForm.returned_ajax_data.url } );
          });
      }
      // console.log( h );
      if( h ){
          $('#chats').find('.chats').html( h );
      }
  },
  get_recent_visitors_html: function( d ){
      var data = d.visitor_data;
      
      var html = '';
      var label = 'Department: ';
    
      //&& data.entry_time
    // console.log( data ); 
      if( data.entry && data.date_time && data.full_name && data.department  ){
          html += '<li class="'+data.entry+'">';
        if( data.photograph ){
          html += '<img class="avatar img-responsive" alt="" src="' + d.url + 'engine/' + data.photograph + '">';
        }
      
        html += '<div class="message">';
            html += '<span class="arrow"></span>';
            html += '<a href="#" class="name">'+data.full_name+'</a>';
            html += '<span class="datetime"> at '+data.date_time+'</span>';
            html += '<span class="body">';
            html += label + data.department;
            html += '</span>';
          html += '</div>';
        html += '</li>';
       
       //console.log( 'mike'.html );
     }
     return html;
  },
  get_previous_visits_html: function( data ){
      if( data.entry && data.date && data.time && data.reason_for_visit && data.whom_to_see  ){
          var html = '<tr>';
          html += '<td class="hidden-xs">'+data.date+'</td>';
          html += '<td><a href="#">'+data.time+'</a> ('+data.entry+')</td>';
          html += '<td class="hidden-xs">Host: '+data.whom_to_see+'<br />'+data.reason_for_visit+'</td>';
          html += '</tr>';
         return html;
     }
  },
  closeConnection: function () {
    source.close();
    nwEntryExitLog.updateConnectionStatus('Disconnected', false);
  },
  updateConnectionStatus: function (msg, connected) {
    var el = document.querySelector('#connection');
    if( ! el )return false;
    if (connected) {
      if (el.classList) {
        el.classList.add('connected');
        el.classList.remove('disconnected');
      } else {
        el.addClass('connected');
        el.removeClass('disconnected');
      }
    } else {
      if (el.classList) {
        el.classList.remove('connected');
        el.classList.add('disconnected');
      } else {
        el.removeClass('connected');
        el.addClass('disconnected');
      }
    }
    el.innerHTML = msg + '<div></div>';
  },
  handleSuccess: function(stream) {
    window.stream = stream; // make stream available to browser console
    video.srcObject = stream;
  },
  handleError: function(error) {
    console.log('navigator.getUserMedia error: ', error);
  },
};
nwEntryExitLog.init();