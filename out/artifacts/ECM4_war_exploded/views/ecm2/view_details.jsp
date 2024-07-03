<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpEcm2" %>
<%@ page import="codes.nwpWorkflow" %>
<div nwp-file="<% out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        GlobalFunctions.app_popup = true;
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

        if( jpet.has("id") && ! jpet.getString("id").isEmpty() ) {
            GlobalFunctions.app_popup_title = "Process #" + jpet.getString("id");

            JSONObject tmpData = new JSONObject();
            tmpData.put("id", jpet.getString("id") );
            tmpData.put("title", "Process Info");
            tmpData.put("set_popup_title", true);
            tmpData.put("hide_buttons", true);
            out.print( nwpEcm2.getDetailsView(tmpData) );


            if( jget.has( "workflow" ) && ! jget.getString("workflow").isEmpty() ) {
                tmpData = new JSONObject();
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