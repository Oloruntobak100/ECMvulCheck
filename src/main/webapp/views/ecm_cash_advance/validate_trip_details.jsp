<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.nwpCashAdvance" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );

        if( jpet.has("id") && ! jpet.getString("id").isEmpty()  ) {
            if( jget.has("container") ) {
                jpet.put("show_workflow_button", true );
                jpet.put("html_replacement_selector", jget.getString("container"));
                GlobalFunctions.app_replace_container = jget.getString("container");
            }

            if( jget.has("workflow") && ! jget.getString("workflow").isEmpty() ) {
                jpet.put("workflow", jget.getString("workflow") );
            }
            jpet.put("isValidateTripDetails", true );
            out.print( nwpCashAdvance.getDetailsView( jpet ) );
        }else{
            out.print("Invalid Cash Advance Reference");
        }
    %>
</div>