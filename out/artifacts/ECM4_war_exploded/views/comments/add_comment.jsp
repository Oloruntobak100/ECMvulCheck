<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="static codes.nwpDataTable.getDataForm" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>

<div nwp-file="<% out.print( request.getAttribute("filename") );%>" class="hyella-source-container">

    <%
        GlobalFunctions.app_popup = true;
        GlobalFunctions.app_popup_title = "Comment";
        JSONObject jget = new JSONObject( request.getAttribute( "nwp_gdata" ).toString() );

        if( jget.has( "id" ) && jget.has( "table" ) ){
            JSONObject jdata = new JSONObject();

            JSONObject dep = GlobalFunctions.get_json( "comments" );
            if( dep.has( "labels" ) && dep.has( "form_order" ) ){
                JSONObject labels = dep.getJSONObject( "labels" );
                String $key1 = "";
                JSONObject $line;

                DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern( "yyyy-MM-dd" );
                DateTimeFormatter myFormatObj2 = DateTimeFormatter.ofPattern( "HH:mm" );
                LocalDateTime myDateObj = LocalDateTime.now();

                if( labels.names().length() > 0 ){

                    for( int i2 = 0; i2 < labels.names().length(); i2++ ){
                        $key1 = labels.names().getString( i2 );
                        $line = labels.getJSONObject( $key1 );

                        if( $line.getString( "field_identifier" ).equals( "reference" ) ){
                            $line.put( "value", jget.getString( "id" ) );
                            $line.put( "hidden_records_css", true );
                        }else if( $line.getString( "field_identifier" ).equals( "reference_table" ) ){
                            $line.put( "value", jget.getString( "table" ) );
                            $line.put( "hidden_records_css", true );
                        }else if( $line.getString( "field_identifier" ).equals( "date" ) ){
                            $line.put( "value", myDateObj.format( myFormatObj ) + "T" + myDateObj.format( myFormatObj2 ) );
                            $line.put( "hidden_records_css", true );
                        }else if( $line.getString( "field_identifier" ).equals( "status" ) ){
                            $line.put( "value", "unread" );
                            $line.put( "hidden_records_css", true );
                        }else if( $line.getString( "field_identifier" ).equals( "title" ) ){
                            if( jget.has( "ctitle" ) ) {
                                $line.put("value", GlobalFunctions.urldecode( jget.getString("ctitle")) );
                                $line.put("hidden_records_css", true);
                            }else{
                                $line.put( "hidden_records", true );
                            }
                        }else if( $line.getString( "field_identifier" ).equals( "type" ) ){
                            $line.put( "value", "parent" );
                            $line.put( "hidden_records_css", true );
                        }else if( $line.getString( "field_identifier" ).equals( "child_reference" ) ){
                            if( jget.has( "workflow" ) ) {
                                $line.put("value", jget.getString("workflow"));
                                $line.put("hidden_records_css", true);
                            }else{
                                $line.put( "hidden_records", true );
                            }
                        }else if( $line.getString( "field_identifier" ).equals( "child_reference_table" ) ){
                            if( jget.has( "workflow" ) ) {
                                $line.put("value", "workflow" );
                                $line.put("hidden_records_css", true);
                            }else{
                                $line.put( "hidden_records", true );
                            }
                        }else if( $line.getString( "field_identifier" ).equals( "message" ) ){
                        }else{
                            $line.put( "hidden_records", true );
                        }
                    }
                }

            }

            jdata.put( "table_settings", dep );

            // JSONObject $rd = new JSONObject().put( "reference" , jget.getString( "id" ) ).put( "reference_table" , jget.getString( "table" ) );
            // jdata.put( "values", $rd );

            jdata.put( "table", "comments" );
            jdata.put( "replace_popup", true );
            jdata.put( "todo", "create_new_record" );
            // jdata.put( "popup", true );

            out.print( getDataForm( jdata ) );

        }else{
            out.print( "No table specified" );
        }
    %>

</div>

