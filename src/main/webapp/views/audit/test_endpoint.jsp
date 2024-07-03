<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpDataTable" %>
<%@ page import="codes.nwpCURL" %>

<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

        if( jpet.has( "id" ) && ! jpet.getString( "id" ).isEmpty() ){

            JSONObject endPoint = nwpCURL.getEndpointsSettings(
                    new JSONObject()
                    .put("key", jpet.getString( "id" ) )
            );

            String source_table = "ecm_test_endpoint";
            String rep = jget.has( "html_replacement_selector" ) ? jget.getString( "html_replacement_selector" ) : "";

            JSONObject jdata = new JSONObject();
            JSONObject $fs = new JSONObject();

            JSONObject $line = new JSONObject();
            String $key1 = "";

            JSONObject dep = GlobalFunctions.get_json( source_table );
            if( dep.has( "labels" ) && dep.has( "form_order" ) ) {
                JSONObject labels = dep.getJSONObject("labels");
                JSONObject labels2 = new JSONObject();

                if( labels.names().length() > 0 ){

                    for( int i2 = 0; i2 < labels.names().length(); i2++ ){
                        $key1 = labels.names().getString( i2 );
                        $line = labels.getJSONObject( $key1 );
                        String $fd = $line.has( "field_identifier" )?$line.getString( "field_identifier" ):"";

                        if( $fd.equals("response") ) {

                        }else{
                            if( endPoint.has( $fd ) ){
                                $line.put("value", endPoint.get($fd).toString() );
                            }
                            labels2.put($key1, $line);
                        }
                    }
                }


                dep.put( "labels", labels2 );
            }
            GlobalFunctions.app_popup = true;
            GlobalFunctions.app_popup_title = "Test Endpoint: " + ( jget.has( "menu_title" ) ? GlobalFunctions.urldecode( jget.getString( "menu_title" ) ) : "" );

            jdata.put( "table_settings", dep );
            jdata.put( "table", source_table );
            jdata.put( "action", "?action=display_sub_menu&nwp2_action=audit&nwp2_todo=save_test_endpoint&nwp2_source="+ source_table +"&html_replacement_selector=modal-replacement-handle" );

            out.print( nwpDataTable.getDataForm( jdata ) );

        }else{
            out.print( "Undefined Test Endpoint ID" );
        }
    %>
</div>