<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.saveDataForm" %>
<%@ page import="static codes.nwpCURL.callURL" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jget.has("nwp2_source") && jget.has("nwp2_todo") ){
        JSONObject jdata = new JSONObject();
        jdata.put("table", jget.getString("nwp2_source") );
        jdata.put("todo", jget.getString("nwp2_todo") );
        jdata.put("post_data", jpet );
        jdata.put("return_data", true );
        jdata.put("return_keys", true );

        JSONObject rd = saveDataForm( jdata );
        if( rd.has("form_data") ){
            //out.print( rd.getJSONObject("form_data") );
            JSONObject curlRes = callURL(
                    rd.getJSONObject("form_data").getJSONObject("url").getString("value"),
                    rd.getJSONObject("form_data").getJSONObject("request_method").getString("value"),
                    rd.getJSONObject("form_data").getJSONObject("content_type").getString("value"),
                    rd.getJSONObject("form_data").getJSONObject("pay_load").getString("value"),
                    new JSONObject( rd.getJSONObject("form_data").getJSONObject("header_options").getString("value") )
            );

            String h = "";
            h += "<label>Pay Load</label>";
            h += "<textarea class=\"form-control\" readonly>"+ rd.getJSONObject("form_data").getJSONObject("pay_load").getString("value") +"</textarea>";
            h += "<br>";
            if( curlRes.has("string") ) {
                h += "<br>";
                h += "<label>Response (Raw)</label>";
                h += "<textarea class=\"form-control\" readonly>" + curlRes.getString("string") + "</textarea>";
            }
            if( curlRes.has("json") && curlRes.getJSONObject("json").length() > 0 ) {
                h += "<br>";
                h += "<label>Response (JSON)</label>";
                h += "<textarea class=\"form-control\" readonly>" + curlRes.getJSONObject("json").toString() + "</textarea>";
            }
            if( curlRes.has("error") && ! curlRes.getString("error").isEmpty() ) {
                h += "<br>";
                h += "<label>Error</label>";
                h += "<textarea class=\"form-control\" readonly>" + curlRes.getString("error") + "</textarea>";
            }
            out.print( h );
        }else if( rd.has("error") ){
            out.print( rd.getString("error") );
        }
    }else{
        out.print( "No table specified" );
    }
%>