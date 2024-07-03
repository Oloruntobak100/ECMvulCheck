<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="static codes.nwpDataTable.getDataForm" %>
<%@ page import="codes.nwpWorkflow" %>
<%@ page import="codes.nwpCashAdvance" %>

<div nwp-file="<% out.print( request.getAttribute("filename") );%>" class="hyella-source-container">

    <%
        GlobalFunctions.app_popup = true;
        JSONObject jget = new JSONObject( request.getAttribute( "nwp_gdata" ).toString() );
        JSONObject jpet = new JSONObject( request.getAttribute( "nwp_pdata" ).toString() );

        if( jget.has( "cash_advance" ) && ! jget.getString( "cash_advance" ).isEmpty() && jget.has( "ca_type" ) && ! jget.getString( "ca_type" ).isEmpty() ){
            JSONObject jdata = new JSONObject();
            String ecmtb = nwpCashAdvance.table_name_trip;

            JSONObject dep = GlobalFunctions.get_json( ecmtb );
            /*if( dep.has( "labels" ) && dep.has( "form_order" ) ){
                JSONObject labels = dep.getJSONObject( "labels" );
                JSONObject labels2 = new JSONObject();
                String $key1 = "";
                JSONObject $line;

                if( labels.names().length() > 0 ){

                    for( int i2 = 0; i2 < labels.names().length(); i2++ ){
                        $key1 = labels.names().getString( i2 );
                        $line = labels.getJSONObject( $key1 );

                        if( $line.getString( "field_identifier" ).equals( "comment" ) ){
                            //}else if( $line.getString( "field_identifier" ).equals( "flag" ) ){
                            //}else if( $line.getString( "field_identifier" ).equals( "flag_by" ) ){
                            //}else if( $line.getString( "field_identifier" ).equals( "flag_comment" ) ){
                            //}else if( $line.getString( "field_identifier" ).equals( "priority" ) ){
                            // $line.put( "add_empty", 1    );
                        }else{
                            //$line.put( "hidden_records", true );
                        }
                    }
                }

            }*/

            jdata.put( "table_settings", dep );

            jdata.put( "table", ecmtb );
            //jdata.put( "replace_popup", true );
            jdata.put( "todo", "save_trip_details" );
            //jdata.put( "params", "&source=" +  ecmtb );
            if( jpet.has( "id" ) && ! jpet.getString( "id" ).isEmpty() ) {
                jdata.put( "id", jpet.getString( "id" ) );
                jdata.put( "edit_record", true );
                GlobalFunctions.app_popup_title = "Edit Trip Details";
            }
            //jdata.put( "popup", true );

            //out.print( getDataForm( jdata ) );

            jdata.put( "html_replacement_selector", "multiple-trip-con" );
            jdata.put( "ca_ad", (jget.has( "ca_ad" )?jget.getString( "ca_ad" ):"") );
            jdata.put( "ca_type", jget.getString( "ca_type" ) );
            jdata.put( "cash_advance", jget.getString( "cash_advance" ) );
            out.print( "<div id='multiple-trip-con'>" + nwpCashAdvance.getTripDetailsForm( jdata ) + "</div>" );

        }else{
            out.print( "Invalid Cash Advance Ref & Type" );
        }
    %>

</div>