<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.GlobalFunctions.GetAccessedFunctions" %>
<%@ page import="static codes.nwpWorkflow.WorkflowGetDataApprovalDashboard" %>

<%@ page import="static codes.GlobalFunctions.rawurlencode" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>"  class="hyella-source-container">
    <%
        JSONObject $data = WorkflowGetDataApprovalDashboard("");
        JSONObject $access = GetAccessedFunctions();
        String $super = "";
        try{
            //JSONObject j2 = new JSONObject( request.getAttribute("nwp_gdata").toString() );
            if( $access.getString("super") == "1" ){
                $super = "1";
            }
        }catch (Exception e) {
            out.println( "<h4>Unable to Read Access Control Data</h4>");
            out.println( $access );
        }

        // out.print( '<pre>'; out.println( $data ); out.print( '</pre>';
        //out.print( '<pre>'; out.println( $data["unprocessed"] ); out.print( '</pre>';
        String $title = "Approval Dashboard";
        String $sel_state = "";
        String $sel_lga = "";
        String $current_tab = $data.getString("current_tab");
        JSONObject $items = new JSONObject( $data.get("items").toString() );
        String $plugin = $data.getString("plugin");
        String $table = $data.getString("table");

        JSONObject $hh = new JSONObject();
        JSONObject $all = new JSONObject();
        JSONObject $color_index = new JSONObject();

        String $key = "";
        JSONObject $val = new JSONObject();
        String $subtext = "";
        String $h1 = "";
        String $h0 = "";
        String $attr = "";

        try{
            //String[] $colors = new String[] {"danger", "primary", "success", "warning"};
            String[] $colors = new String[] {"primary", "primary", "primary", "primary"};
            int $int = 0;
            JSONArray $dataset = new JSONArray();

            if( GlobalFunctions.app_user_data.has("department_text") ){
                $dataset.put( new JSONObject().put("title", "Department").put("value", GlobalFunctions.app_user_data.getString("department_text")  ));
            }

            if( GlobalFunctions.app_user_data.has("grade_level_text") ){
                $dataset.put( new JSONObject().put("title", "Grade Level").put("value", GlobalFunctions.app_user_data.getString("grade_level_text")  ));
            }

            if( $dataset.length() > 0 ) {
                $h1 = "<ul class=\"list-group\" style=\"padding:0.5rem 0;\">";
                for (int i = 0; i < $dataset.length(); i++) {
                    JSONObject $tval = $dataset.getJSONObject(i);
                    String $color_text = (!$colors[$int].isEmpty()) ? $colors[$int] : "danger";
                    String $sub_text = "";

                    $h1 += "<li class=\"list-group-item\">\n" +
                            "          <div class=\"widget-content p-0\">\n" +
                            "            <div class=\"widget-content-outer\">\n" +
                            "              <div class=\"widget-content-wrapper\">\n" +
                            "                <div class=\"widget-content-left\">\n" +
                            "                  <div class=\"widget-heading\">" + $tval.getString("title") + "</div>\n" +
                            "                  <div class=\"widget-subheading\">  </div>\n" +
                            "                </div>\n" +
                            "                <div class=\"widget-content-right\">\n" +
                            "                  <div class=\"widget-numbers text-" + $color_text + " \" style=\"font-size:1.1em;\">" + $tval.getString("value") + " </div>\n" +
                            "                </div>\n" +
                            "              </div>\n" +
                            "            </div>\n" +
                            "          </div>\n" +
                            "        </li>";

                    ++$int;
                    if ($int > 3) {
                        $int = 0;
                    }
                }
                $h1 += "</ul>";
                $hh.put( $key, $h1 );
            }


            if( $items.length() > 0 && $items.names().length() > 0 ){
                for(int i = 0; i < $items.names().length(); i++) {
                    $key = $items.names().getString(i);
                    $hh.put( $key, "" );
                }
                for(int i = 0; i < $items.names().length(); i++){
                    $key = $items.names().getString(i);
                    $val = new JSONObject( $items.get( $key ).toString() );

                    $color_index.put( "color1", "card-shadow-dark border border-info" ).put("color2", "text-white").put( "color3", "bg-warning" );
                    //$index = 0;
                    //out.println( $val );
                    //Integer $total = Integer.parseInt( $val.getString("count") );

                    Integer $total = Integer.parseInt( $val.getString("count") );
                    if( $total > 0 ){

                        $attr = "&callback_start=nwMisDashboard.switch_tab";

                        $h1 = "<div class=\"card mb-3 widget-content card-shadow-dark border border-info\">";
                        $h1 += "<div class=\"widget-content-outer\">";
                        $h1 += "<div class=\"widget-content-wrapper\">";
                        $h1 += "<div class=\"widget-content-left\">";
                        $h1 += "<div class=\"widget-subheading\" style=\"min-height:30px; opacity:1;\"><i>" +  $val.getString("sub_title") + "</i></div>";
                        $h1 += "<div class=\"widget-heading\" style=\"min-height:50px;\">" + $val.getString("title") + "</div>";
                        $h1 += "</div>";
                        $h1 += "<div class=\"widget-content-right\">";
                        $h1 += "<div class=\"widget-numbers text-success\">" + $total + "</div>";
                        $h1 += "</div>";
                        $h1 += "</div>";

                        $h1 += "<div id=\"" + $key + "-tree-con\" style=\"margin-top:10px;\"><a href=\"#\"  id=\"oid-" + $key + "\" data-title=\""+  $val.getString("title") +"\" override-selected-record=\"" + $key + "\" class=\"custom-single-selected-record-button btn btn-sm blue pull-rightx \" action=\"?action=display_sub_menu&todo=execute&nwp2_action=nwp_workflow&nwp2_todo=display_filtered_workflows2&data_id=" + $key + "&table=" + $val.getString("table") + "&html_replacement_selector=tab-2&title=" + rawurlencode( $val.getString("title") )  + $attr + "\">View All</a></div>";


                        $h1 += "</div>";
                        $h1 += "</div>";

                        $h0 = $hh.get( $key ).toString();
                        $h0 = $h0 + $h1;
                        $hh.put( $key, $h0 );
                    }
                    //out.println( $hh );
                }
            }else{

            }
        }catch (Exception e) {
            //out.print( "<h4>No Pending Jobs</h4>");
            out.print( e.getMessage() );
        }


    %>

    <div class="row">
        <div class="col-md-12">
            <h4><strong></strong></h4>
        </div>
    </div>

    <div class="tabbable tabbable-custom" id="transaction-tabs">
        <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#tab-1"><% out.print( $title ); %></a></li>
            <li class=""><a data-toggle="tab" href="#tab-2" id="tab2-handle">View Result</a></li>
        </ul>
        <div class="tab-content resizable-heightx" style="overflow-y:hidden; overflow-x:hidden;">

            <div class="tab-pane active" id="tab-1">
                <div class="row">
                    <%
                        /*if( ! empty( $hh  ) ){
                            foreach( $hh as $hval ){
                                out.print( "<div class=\"col-md-4\">" + $hval + "</div>" );
                            }
                        }*/
                        //out.println( $hh );
                        try{
                           String a1 = "";
                           if( $hh.length() > 0 ) {
                               for (int i1 = 0; i1 < $hh.names().length(); i1++) {
                                   $key = $hh.names().getString(i1);
                                   a1 = $hh.get($key).toString();
                                   if (i1 > 0 && i1 % 3 == 0) {
                                       out.print("</div><div class=\"row\">");
                                   }
                                   out.print("<div class=\"col-md-4\">" + a1 + "</div>");
                               }
                           }else{
                               out.print( "<div class=\"col-md-12\"><div class=\"note note-warning\"><h4>No Pending Jobs Found</h4></div></div>");
                           }
                        }catch (Exception e) {
                            out.print( "<div class=\"col-md-12\"><div class=\"note note-warning\"><h4>No Pending Jobs Found</h4></div></div>");
                        }
                    %>
                </div>
            </div>
            <div class="tab-pane" id="tab-2" style="heighx: 1000px;"></div>
        </div>
    </div>

    <script type="text/javascript" class="auto-remove">
        var plugin = '<% out.print( $plugin ); %>';
        var table = '<% out.print( $table ); %>';
        var g_container = 'tab-2';

        var nwMisDashboard = function () {
            return {
                recordItem: {
                    id:"",
                },
                init: function () {},
                switch_tab: function () {

                    //console.log( $(this) );
                    if( $.fn.cProcessForm.returned_ajax_data && $.fn.cProcessForm.returned_ajax_data.oid && $("#oid-" + $.fn.cProcessForm.returned_ajax_data.oid ) ){
                        $( 'a#tab2-handle' ).removeClass( 'custom-single-selected-record-button activatedRightClick' ).click();
                        $( 'a#tab2-handle' ).addClass( 'custom-single-selected-record-button activatedRightClick' ).attr({
                            'action' : $("#oid-" + $.fn.cProcessForm.returned_ajax_data.oid ).attr("action"),
                            'override-selected-record' : $.fn.cProcessForm.returned_ajax_data.oid,
                        });
                        if( $("#oid-" + $.fn.cProcessForm.returned_ajax_data.oid ).attr("data-title") ){
                            $( 'a#tab2-handle' ).html( $("#oid-" + $.fn.cProcessForm.returned_ajax_data.oid ).attr("data-title") );
                        }
                        // $( '#tab-2' ).html( '' );
                    }

                },
                startTreeview: function ( id ) {
                    var $a = $('a#' + id );

                    $("#"+ id +"-con")
                        .html('<div id="'+ id +'" class="demo"></div>');

                    nwTreeView.selector = "#" + id;
                    nwTreeView.action = plugin;
                    nwTreeView.todo = 'execute';

                    nwTreeView.data = { html_replacement_selector:g_container, table: $a.attr("data-table"), development_mode_off:1, nwp_action:table, nwp_todo : $a.attr("data-todo"), data_id : $a.attr("data-id") };
                    if( $a[0].hasAttribute( 'add-params' ) )nwTreeView.data['add-params'] = $a.attr( 'add-params' );

                    var x = nwTreeView.activate_tree_view_main();

                },
            };

        }();
    </script>
</div>