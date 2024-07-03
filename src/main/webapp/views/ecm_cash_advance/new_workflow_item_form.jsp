<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpCashAdvance" %>
<%@ page import="static codes.nwpEcm2.new_workflow_item_form" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        String con = "";
        String con2 = "";

        if( jpet.has("id") && ! jpet.getString("id").isEmpty() ) {
            if( jget.has("html_replacement_selector") ){
                con = jget.getString("html_replacement_selector");
                con2 = jget.getString("html_replacement_selector");

                if( jget.has("html_parent") ){
                    con += "&html_parent=" +jget.getString("html_parent");
                }
                jpet.put("html_replacement_selector", con );

            }
            jpet.put("source", nwpCashAdvance.table_name );
            jpet.put("hide_fields", new JSONObject().put("name", true ) );

            out.print( "<a href=\"javascript:;\" title=\"Visualize Workflow\" class=\"btn btn-sm dark pull-right custom-single-selected-record-button\" override-selected-record=\""+ jpet.getString("id").trim() +"\" action=\"?action=display_sub_menu&nwp2_action=workflow_settings&todo=&nwp2_todo=show_process_flow&nwp_view=nwp_workflow&container="+ con2 +"\">Visualize Workflow</a>" );
            out.print( new_workflow_item_form( jpet ) );
        }else{
            out.print( "No record id specified" );
        }
    %>
</div>