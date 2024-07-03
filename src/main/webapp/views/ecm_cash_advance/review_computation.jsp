<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="static codes.nwpCashAdvance.reviewComputation" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        String error = "";

        if( jpet.has("id") ){
            jget.put("id", jpet.getString("id"));
            JSONObject jr = reviewComputation( jget );
            if( jr.has("error") ){
                error = jr.getString("error");
            }else {
                out.print(jr.getString("html"));
            }
        }else{
            //out.print( "Invalid Cash Advance Reference" );
            error = "Invalid Cash Advance Reference...computation could not be reviewed";
        }

        if( ! error.isEmpty() ){
            GlobalFunctions.app_notice_type = "error";
            GlobalFunctions.app_notice = error;
            GlobalFunctions.app_notice_only = true;
        }
    %>
</div>