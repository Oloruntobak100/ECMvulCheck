<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.nwpCashAdvance" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        if( jpet.has("id") ){
            jget.put("id", jpet.getString("id"));
            out.print( nwpCashAdvance.getDetailsView( jget ) );
        }else{
            //out.print( "Invalid Cash Advance Reference" );
            GlobalFunctions.app_notice_type = "error";
            GlobalFunctions.app_notice = "Invalid Cash Advance Reference...could not be opened";
            GlobalFunctions.app_notice_only = true;
        }
    %>
</div>