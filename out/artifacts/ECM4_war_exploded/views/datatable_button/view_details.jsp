<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="org.json.JSONArray" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jpet.has("id") && ! jpet.getString("id").isEmpty() ) {
        if (jget.has("nwp2_source") && jget.has("nwp2_todo")) {
            String html = "";
            GlobalFunctions.app_popup = true;
            GlobalFunctions.app_popup_title = "View #" + jpet.getString("id");

            html = GlobalFunctions.view_details(new JSONObject().put("id", jpet.getString("id") ).put("table", jget.getString("nwp2_source") ), new JSONObject() );
            out.print(html);

        } else {
            out.print("No table specified");
        }
    }else{
        out.print( "No record was selected" );
    }
%></div>