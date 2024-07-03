<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.saveDataForm" %>
<%@ page import="codes.nwpDataTable" %>
<%@ page import="codes.nwpWorkflow" %>
<%@ page import="codes.nwpEcm2" %>
<%@ page import="codes.GlobalFunctions" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jpet.has("id") && ! jpet.getString("id").isEmpty() ){
        if( jget.has("nwp2_source") && jget.has("nwp2_todo") ){
            String table = jget.has("nwp2_source")?jget.getString("nwp2_source"):nwpEcm2.table_name;
            String update_type = jget.has("update_type")?jget.getString("update_type"):"move_job";
            String success_click_handle = jget.has("success_click_handle")?jget.getString("success_click_handle"):"";

            String did = jpet.getString("id");
            JSONObject jdata = new JSONObject();
            jdata.put("table", table );
            jdata.put("todo", "edit" );
            jdata.put("id", jpet.getString("id") );

            JSONObject dep1 = GlobalFunctions.get_json( table );
            if( dep1.getJSONObject("fields").has("flag_by") ){
                jpet.put(dep1.getJSONObject("fields").getString("flag_by"), GlobalFunctions.app_user ); //date("Y-m-d")
            }

            jdata.put("post_data", jpet );

            JSONObject rd = saveDataForm( jdata );
            //System.out.print( rd );

            if( rd.has( "saved_record" ) && rd.getJSONObject( "saved_record" ).length() > 0 ) {
                JSONObject a = new JSONObject();
                JSONObject update_fields = new JSONObject();

                if ( update_type.equals("flag") ) {
                    if ( rd.getJSONObject( "saved_record" ).has("priority") ) {
                        update_fields.put( "priority", rd.getJSONObject( "saved_record" ).getString("priority") );
                    }
                }else{
                    if (jpet.has("workflow_status") && ! jpet.getString("workflow_status").isEmpty() ) {
                        update_fields.put( "status", jpet.getString("workflow_status") );
                    }
                }

                a.put("update_ref", did );
                a.put("update_ref_table", table );
                a.put("uf_fields", update_fields );
                a.put("success_click_handle", success_click_handle);
                a.put("type", update_type);
                if ( rd.getJSONObject( "saved_record" ).has("flag_comment") ) {
                    a.put( "comment", rd.getJSONObject( "saved_record" ).getString("flag_comment"));
                }

                JSONObject $r = nwpEcm2.directUpdateWorkflow( a );

                if( $r.getJSONObject("saved_record").has("id") ){

                    if( $r.has("html") ){
                        out.print($r.getString("html"));
                    }

                }else{
                    if ($r.has("error")) {
                        out.print($r.getString("error"));
                    }else{
                        out.print("Unable to save workflow record");
                    }
                }
            }else{
                if( rd.has("error") && ! rd.getString("error").isEmpty() ){
                    out.print( rd.getString("error") );
                }else {
                    out.print("Unable to save ecm record");
                }
            }
        }else{
            out.print( "No table specified" );
        }
    }else{
        out.print( "No record id specified" );
    }
%>