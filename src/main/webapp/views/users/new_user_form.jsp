<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataForm" %>
<%@ page import="codes.GlobalFunctions" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jget.has("nwp2_source") ) {
        JSONObject jdata = new JSONObject();
        JSONObject formData = new JSONObject();
        String htmlReplacementSelector = "";
        jdata.put("table", jget.getString("nwp2_source"));
        jdata.put("todo", "create_new_record");
        //jdata.put("popup", true);

        if (jget.has("html_replacement_selector")) {
            htmlReplacementSelector = jget.getString("html_replacement_selector");
        }

        if (jpet.has("data")) {
            formData = new JSONObject(jpet.getString("data"));
        }

        if (formData.has("id")) {
            //enable to use md5 hash of ad username as id in users table
            //jdata.put("tmp_id", formData.getString("id"));

            JSONObject dep = GlobalFunctions.get_json(jdata.getString("table"));
            if (dep.has("labels") && dep.has("form_order")) {
                JSONObject labels = dep.getJSONObject("labels");
                JSONObject labels2 = new JSONObject();
                String $key1 = "";
                JSONObject $line;

                if (labels.names().length() > 0) {

                    for (int i2 = 0; i2 < labels.names().length(); i2++) {
                        $key1 = labels.names().getString(i2);
                        $line = labels.getJSONObject($key1);
                        if (formData.has($line.getString("field_identifier"))) {
                            $line.put("value", formData.getString($line.getString("field_identifier")));
                        }
                        if( $line.has("no_ad_value") && $line.has("value") ){
                            $line.remove("value");
                        }

                        if ($line.getString("field_identifier").equals("email")) {

                        } else if ($line.getString("field_identifier").equals("grade_level")) {
                            if( $line.has("no_create") ){
                                $line.put("hidden_records", true);
                            }
                        } else if ($line.getString("field_identifier").equals("employee_no")) {
                            if( $line.has("no_create") ){
                                $line.put("hidden_records", true);
                            }
                        } else if ($line.getString("field_identifier").equals("phone_number")) {
                        } else if ($line.getString("field_identifier").equals("username")) {
                            $line.put("hidden_records_css", true);
                        } else if ($line.getString("field_identifier").equals("name")) {
                            $line.put("hidden_records_css", true);
                        } else if ($line.getString("field_identifier").equals("role")) {
                        } else if ($line.getString("field_identifier").equals("prole")) {
                        } else if ($line.getString("field_identifier").equals("prole_expiry_date")) {
                        } else if ($line.getString("field_identifier").equals("department")) {

                        } else if ($line.getString("field_identifier").equals("group")) {
                            if( $line.has("no_create") ){
                                $line.put("hidden_records", true);
                            }
                        } else if ($line.getString("field_identifier").equals("team")) {
                            if( $line.has("no_create") ){
                                $line.put("hidden_records", true);
                            }
                        } else if ($line.getString("field_identifier").equals("status")) {
                            $line.put("value", "active");
                            $line.put("hidden_records_css", true);
                        } else if ($line.getString("field_identifier").equals("locked")) {
                            $line.put("value", "no");
                            $line.put("hidden_records_css", true);
                        } else {
                            $line.put("hidden_records", true);
                        }
                    }


                }
            }
            jdata.put("html_replacement_selector", htmlReplacementSelector);
            jdata.put("table_settings", dep);


            //jdata.put( "title", "Add New User from Active Directory" );
            out.print("<h4>New User Assignment!</h4>");

            out.print( getDataForm(jdata) );
        }else{
            out.print( "Unable to Retrieve User ID" );
        }
    }else{
        out.print( "No table specified" );
    }
%>