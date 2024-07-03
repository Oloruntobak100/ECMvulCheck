<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpCashAdvance.saveTripDetailsForm" %>
<%@ page import="codes.GlobalFunctions" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute( "nwp_gdata" ).toString() );
    JSONObject jpet = new JSONObject( request.getAttribute( "nwp_pdata" ).toString() );
    String error = "";

    if( jget.has( "nwp2_source" ) && jget.has( "nwp2_todo" ) ){
        JSONObject jdata = new JSONObject();
        jdata.put( "ca_ad", (jget.has( "ca_ad" )?jget.getString( "ca_ad" ):"") );
        jdata.put( "table", jget.getString( "nwp2_source" ) );
        jdata.put( "todo", jget.getString( "nwp2_todo" ) );
        jdata.put( "post_data", jpet );

        JSONObject rd = saveTripDetailsForm( jdata );

        if( rd.has( "saved_record" ) && rd.getJSONObject( "saved_record" ).has( "id" ) ){

            if( rd.has("view_details") ){
                out.print( rd.getString("view_details") );
            }else {
                error = "<pre>" + rd + "</pre>";
            }

        }else if( rd.has("error") ){
            error = rd.getString("error");
        }else{
            error = "Unable to Save";
        }
    }else{
        error = "No table specified";
    }

    if( ! error.isEmpty() ){
        GlobalFunctions.app_notice_type = "error";
        GlobalFunctions.app_notice = error;
        GlobalFunctions.app_notice_only = true;
    }
%>