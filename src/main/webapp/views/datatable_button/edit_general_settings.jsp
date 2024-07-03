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
        jdata.put("todo", "edit");
        jdata.put("popup", true);

        if (jget.has("html_replacement_selector")) {
            htmlReplacementSelector = jget.getString("html_replacement_selector");
        }

        if (jpet.has("id")) {
            jdata.put("id", jpet.getString("id"));

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

                        if ($line.getString("field_identifier").equals("value")) {

                        } else if ($line.getString("field_identifier").equals("description")) {
                            $line.put("readonly", true );
                        } else if ($line.getString("field_identifier").equals("key")) {
                            $line.put("readonly", true );
                        } else {
                            $line.put("hidden_records", true);
                        }
                    }
                }
            }
            jdata.put("html_replacement_selector", htmlReplacementSelector);
            jdata.put("table_settings", dep);

            out.print( getDataForm(jdata) );
        }else{
            out.print( "Unable to Retrieve User ID" );
        }
    }else{
        out.print( "No table specified" );
    }
%>