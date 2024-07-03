<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="static codes.nwpDataTable.getDataForm" %>
<%@ page import="codes.nwpWorkflow" %>
<%@ page import="codes.nwpEcm2" %>

<div nwp-file="<% out.print( request.getAttribute("filename") );%>" class="hyella-source-container">

    <%
        GlobalFunctions.app_popup = true;
        GlobalFunctions.app_popup_title = "Move Job";
        JSONObject jget = new JSONObject( request.getAttribute( "nwp_gdata" ).toString() );

        if( jget.has( "id" ) && jget.has( "workflow" ) && jget.has( "table" ) ){
            JSONObject jdata = new JSONObject();
            String ecmtb = ( ! jget.getString( "table" ).isEmpty() )?jget.getString( "table" ):nwpEcm2.table_name;

            JSONObject dep = GlobalFunctions.get_json( ecmtb );
            if( dep.has( "labels" ) && dep.has( "form_order" ) ){
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
                            $line.put( "hidden_records", true );
                        }
                    }
                }

                // Custom status field from workflow
                $key1 = "workflow_status";
                JSONObject dep2 = GlobalFunctions.get_json( nwpWorkflow.table_name );

                JSONObject $item = GlobalFunctions.get_record( new JSONObject().put( "id", jget.getString( "workflow" ) ).put( "table", nwpWorkflow.table_name ) );

                if( dep2.has( "labels" ) && dep2.has( "form_order" ) && $item.has( "workflow_settings" ) ){
                    // Get Workflow Settings Data
                    JSONObject $es = GlobalFunctions.get_record( new JSONObject().put( "id", $item.getString( "workflow_settings" ) ).put( "table", nwpWorkflow.workflow_settings_table_name ) );

                    JSONObject st = nwpWorkflow.get_workflow_status( $es );
                    // out.println( st );

                    if( st.length() > 0 ){
                        $line = dep2.getJSONObject( "labels" ).getJSONObject( dep2.getJSONObject( "fields" ).getString( "status" ) );
                        $line.put( "options_array", st );
                        $line.put( "required_field", "yes" );
                        $line.put( "add_empty", 1 );
                        $line.put( "form_field", "select" );
                        $line.put( "field_label", "Workflow Status" );

                        labels2.put( $key1, $line );
                        dep.getJSONObject( "labels" ).put( $key1, $line );
                        dep.getJSONObject( "fields" ).put( $key1, $key1 );
                        dep.getJSONArray( "form_order" ).put( $key1 );
                    }
                }
            }

            jdata.put( "table_settings", dep );

            jdata.put( "table", ecmtb );
            jdata.put( "replace_popup", true );
            jdata.put( "todo", "update_ecm_record" );
            //jdata.put( "params", "&source=" +  ecmtb );
            jdata.put( "record_id", jget.getString( "id" ) );
            // jdata.put( "popup", true );

            out.print( getDataForm( jdata ) );

        }else{
            out.print( "No table specified" );
        }
    %>

</div>