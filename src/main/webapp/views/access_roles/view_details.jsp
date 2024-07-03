<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        JSONObject $options = new JSONObject();

        if( jpet.has("id") && ! jpet.getString("id").isEmpty() ) {
            if (jget.has("nwp2_action") && jget.has("nwp2_todo")) {
                String html = "";
                //GlobalFunctions.app_popup = true;
                //GlobalFunctions.app_popup_title = "View #" + jpet.getString("id");

                /*JSONObject $btn_data = new JSONObject( "{\"more_actions\":{\"op\":{\"todo\":\"control_panel\",\"title\":\"Open and View Details\",\"text\":\"Open\",\"html_replacement_key\":\"phtml_replacement_selector\"}}}" );
                //JSONObject more_data = new JSONObject();
                //more_data.put("additional_params", "&workflow="+ $item.getString("id"));

                $btn_data.put("hide", "no_split_view" );
                $btn_data.put( "html_replacement_selector", "datatable-split-screen-" + jget.getString("nwp2_action") );
                $btn_data.put( "params", "&html_replacement_selector=" + $btn_data.getString( "html_replacement_selector" ) );
                $btn_data.put( "phtml_replacement_selector", jget.getString("html_replacement_selector") );
                $btn_data.put( "selected_record", jpet.getString("id") );
                $btn_data.put( "table", jget.getString("nwp2_action") );
                //$btn_data.put("more_data", more_data );

                $options.put( "buttons", nwpDataTable.getButtons( $btn_data ) + "<br /><br />" );*/


                html = GlobalFunctions.view_details(new JSONObject().put("id", jpet.getString("id") ).put("table", jget.getString("nwp2_action") ), $options );
                out.print(html);

            } else {
                out.print("No table specified");
            }
        }else{
            out.print( "No record was selected" );
        }
    %></div>