<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpCashAdvance" %>
<%@ page import="codes.nwpWorkflow" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        JSONObject $opt = new JSONObject();

        if( jget.has("html_replacement_selector") && ! jget.getString("html_replacement_selector").isEmpty() ) {

        }else{
            GlobalFunctions.app_popup = true;
            $opt.put("buttons","");
        }

        if( jpet.has("id") && ! jpet.getString("id").isEmpty() ) {
            GlobalFunctions.app_popup_title = "Cash Advance #" + jpet.getString("id");

            jget.put("table", nwpCashAdvance.table_name );
            //out.print( GlobalFunctions.view_details( jget, $opt ) );
            out.print( nwpCashAdvance.getSingleDetailsView( jget ) );

            if( jget.has( "workflow" ) && ! jget.getString("workflow").isEmpty() ) {
                JSONObject tmpData = new JSONObject();
                tmpData.put("id", jget.getString("workflow") );
                //tmpData.put("title", "Approval Info");
                tmpData.put("hide_buttons", true);
                tmpData.put("show_history", true);
                out.print( "<br /><br /><h4>Approval Info</h4>" );
                out.print( nwpWorkflow.getDetailsView(tmpData) );
            }
        }else{
            out.print( "Invalid Reference" );
        }

    %>
</div>