<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.saveDataForm" %>
<%@ page import="static codes.nwpAccessRoles.updateEmployeeDetailsFromAPI" %>
<%@ page import="static codes.nwpAccessRoles.canUpdateEmployeeDetailsFromAPI" %>
<%@ page import="org.json.JSONArray" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jget.has("nwp2_source") && jget.has("nwp2_todo") ){
        JSONObject jdata = new JSONObject();
        jdata.put("table", jget.getString("nwp2_source") );
        jdata.put("todo", jget.getString("nwp2_todo") );
        jdata.put("post_data", jpet );

        //if checking api
        if( canUpdateEmployeeDetailsFromAPI( new JSONObject().put("source", "create_" + jget.getString( "nwp2_source" ) ) ) ){
            jdata.put( "show_view_details", false );
        }

        JSONObject rd = saveDataForm( jdata );

        if( rd.has( "saved_record" ) && rd.getJSONObject( "saved_record" ).has( "id" ) ) {
            //Trigger callback
            JSONObject rd2 = updateEmployeeDetailsFromAPI(
                    new JSONObject()
                            .put("table_settings", new JSONObject()
                                    .put("display_fields", rd.has("display_fields") ? rd.getJSONArray("display_fields") : new JSONArray())
                            )
                            .put("source", "create_" + jget.getString("nwp2_source"))
                            .put("id", rd.getJSONObject("saved_record").getString("id"))
                            .put("employee_no", rd.getJSONObject("saved_record").has("employee_no") ? rd.getJSONObject("saved_record").getString("employee_no") : "")
                            .put("grade_level", rd.getJSONObject("saved_record").getString("grade_level"))
            );

            if (rd2.length() > 0) {
                rd = rd2;
            }
        }

        if( rd.has("view_details") ){
            out.print( rd.getString("view_details") );
        }else {
            out.print("<pre>" + rd + "</pre>");
        }
    }else{
        out.print( "No table specified" );
    }
%>