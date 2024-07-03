<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpWorkflow._view_details2" %>
<%@ page import="static codes.nwpDataTable.getClosePopup" %>
<%@ page import="codes.GlobalFunctions" %>

<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%

        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

        if( jpet.has("data") && jpet.has("nwp_wf_comment") && jget.has("nwp2_todo")  && jpet.has("id") ) {
            JSONObject a = new JSONObject();
            a.put( "post", jpet );
            a.put( "get", jget );
            a.put( "action_to_perform", jget.getString( "nwp2_todo" ) );
            a.put( "id", jpet.getString( "id" ) );

            JSONObject $dx = _view_details2( a );

            if( $dx.has( "error" ) ){

                GlobalFunctions.app_notice_type = "error";
                GlobalFunctions.app_notice = $dx.getString( "error" );
                GlobalFunctions.app_notice_only = true;

            }else{
                if( $dx.has( "history" ) ){
                    out.print( $dx.getString( "history" ) );
                }
                out.print( getClosePopup() );
            }

        }else{
            out.print( "Unspecified source ID and Table" );
        }
    %>
</div>