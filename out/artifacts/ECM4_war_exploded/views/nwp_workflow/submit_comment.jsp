<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpWorkflow._view_details2" %>
<%@ page import="static codes.nwpWorkflow.validate_workflow_status" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        // Change Status
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        String $error = "";

        if( jget.has("id") && jget.has("nwp2_action") && jget.has("nwp2_type") ){
            if( jget.has("nwp_wf_cur_state") && ! jget.getString("nwp_wf_cur_state").isEmpty() ){
                if( validate_workflow_status( jget.getString("id").trim(), jget.getString("nwp_wf_cur_state").trim() ) ){

                }else{
                    $error = "<h4>Access Denied</h4>The workflow status has changed";
                }
            }else{
                $error = "<h4>Access Denied</h4>Security violation of workflow status";
            }
        }else{
            $error = "Invalid Input Parameters ID & Type";
        }

        if( $error.isEmpty() ){
        JSONObject jdata = new JSONObject();
        jdata.put( "id", jget.getString("id").trim() );
        jdata.put( "action_to_perform", jget.getString("nwp2_type").trim() );
        //jdata.put( "action_to_perform", "submit_comment" );
        JSONObject $dx = _view_details2( jdata );
        JSONObject $data = $dx.has( "data" ) ? $dx.getJSONObject( "data" ) : new JSONObject();

        String $action = $data.has( "action" ) ? $data.getString( "action" ) : "";
        String $todo = $data.has( "todo" ) ? $data.getString( "todo" ) : "";
        String $plugin = $data.has( "plugin" ) ? $data.getString( "plugin" ) : "";

        //String $table = $data.has( "table" ) ? $data.getString( "table" ) : "";
        String $table = jget.getString("nwp2_type").trim();

        String $action_to_perform = $data.has( "action_to_perform" ) ? $data.getString( "action_to_perform" ) : "";

        String $datatable = $data.has( "datatable" ) ? "comment-workflow-con" : "";

        String $html_replacement_selector = jget.has( "html_replacement_selector" ) ? jget.getString( "html_replacement_selector" ) : "";
        String $empty_container = jget.has( "empty_container" ) ? jget.getString( "empty_container" ) : "";

        String $workflow = $data.has( "workflow" ) ? $data.getString( "workflow" ) : "";
        JSONObject $workflow_settings = $data.has( "workflow_settings" ) ? $data.getJSONObject( "workflow_settings" ) : new JSONObject();

        String $caption = ( $data.has( "params2" ) && $data.getJSONObject( "params2" ).has( "title" ) && ! $data.getJSONObject( "params2" ).getString( "title" ).isEmpty() ? $data.getJSONObject( "params2" ).getString( "title" ) : $todo ).toUpperCase();
        // out.print( $data.getJSONObject( "params2" ) );

        String $cls = "";
        Integer $complete = 0;

        if( $data.has( "params2" ) && $data.getJSONObject( "params2" ).has( "next_state" ) && $data.getJSONObject( "params2" ).getString( "next_state" ).equals( "complete" ) ){
            $complete = 1;
            $cls = " confirm-prompt ";
        }

        GlobalFunctions.app_popup = true;
        GlobalFunctions.app_popup_title = $caption;
        GlobalFunctions.app_popup_handle = $html_replacement_selector;
        String $action_to_perform2 = "?action=display_sub_menu&todo=&nwp2_action=" +  $table + "&nwp2_todo=" + $todo + "&html_replacement_selector=" + $html_replacement_selector + "&empty_container=" + $empty_container + "&datatable=" + $datatable;
    %>
    <div id="<% out.print( $datatable ); %>">
        <form id="workflow-filter-form" class="activate-ajax <% out.print( $cls ); %>" action="<% out.print( $action_to_perform2 ); %>" >
            <%
                JSONObject $hdata = new JSONObject();
                $hdata.put("table", $table );
                $hdata.put("id", $workflow );
                $hdata.put("uid", GlobalFunctions.app_user );
                $hdata.put("action", $action_to_perform2 );
                //$hdata.put("action", $more_data );

                out.print( GlobalFunctions.get_form_headers( $hdata ) );
            %>
            <!--<input type="hidden" name="id" value="<% //echo $workflow %>" />-->
            <textarea name="data" class="form-control" type="text" style="display:none;"><% if( $data.has( "params2" ) ){ out.print( $data.getJSONObject( "params2" ) ); } %></textarea>

            <%
                if( $data.has( "params2" ) && $data.getJSONObject( "params2" ).has( "before_html" ) && ! $data.getJSONObject( "params2" ).getString( "before_html" ).isEmpty() ){
                    out.print( "<div class=\"row\"><div class=\"col-md-12\">" + $data.getJSONObject( "params2" ).getString( "before_html" ) + "</div></div><br />" );
                }
            %>

            <div class="row">
                <div class="col-md-12">
                    <label>Recommendation <sup>*</sup></label>
                    <textarea required name="nwp_wf_comment" class="form-control" type="text" ></textarea>
                </div>
            </div>
            <br />

            <%
                if( $data.has( "content" ) && ! $data.getString( "content" ).isEmpty() ){
                    out.print( "<div class=\"row\"><div class=\"col-md-12\">" + $data.getString( "content" ) + "</div></div>" );
                }
            %>

            <%
                if( $data.has( "params2" ) && $data.getJSONObject( "params2" ).has( "option" ) && $data.getJSONObject( "params2" ).getJSONObject( "option" ).length() > 0 ){
                    $caption = $todo;
                    // $caption = ucwords( $todo );
            %>
            <div class="row">
                <div class="col-md-12">
                    <label><% out.print( $caption + " To" ); %>  <sup>*</sup></label>
                    <select required name="nwp_wf_next_state" class="form-control">
                        <%
                            out.print( "<option value=\"\"></option>" );

                            for( Integer i1 = 0; i1 < $data.getJSONObject( "params2" ).getJSONObject( "option" ).names().length(); i1++ ){
                                String $ok = $data.getJSONObject( "params2" ).getJSONObject( "option" ).names().getString( i1 );
                                String $ov = $data.getJSONObject( "params2" ).getJSONObject( "option" ).getString( $ok );

                                out.print( "<option value=\""+ $ok +"\">" +  $ov.toUpperCase() + "</option>" );
                            }
                        %>
                    </select>
                </div>
            </div>
            <br />
            <%
                }

                if( $data.has( "params2" ) && $data.getJSONObject( "params2" ).has( "after_html" ) && ! $data.getJSONObject( "params2" ).getString( "after_html" ).isEmpty() ){
                    out.print( "<div class=\"row\"><div class=\"col-md-12\">" + $data.getJSONObject( "params2" ).getString( "after_html" ) + "</div></div><br />" );
                }

                if( $complete > 0 ){
                    $caption = "Save as Completed";
                    out.print( "<div class=\"row\"><div class=\"col-md-12\"><p class=\"text-danger\">NB: This is an irreversible action, upon completion this action cannot be reversed</p></div></div>" );
                }

                if( $dx.has( "html" ) ){
                    out.print( $dx.getString( "html" ) );
                }
            %>

            <div class="row">
                <div class="col-md-12">
                    <input class="btn blue" value="<% out.print( $caption ); %>" type="submit" />
                </div>
            </div>
        </form>
    </div>
    <%
        }else{
            /*GlobalFunctions.app_notice_only = true;
            GlobalFunctions.app_notice_type = "error";
            GlobalFunctions.app_notice = $error;*/
            out.print( "<div class=\"note note-danger\">" + $error + "</div>" );
        }
    %>
</div>