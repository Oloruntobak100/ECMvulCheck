<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpCURL" %>
<%
    String $params = "";
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    if( jget.has( "html_replacement_selector" ) && ! jget.getString( "html_replacement_selector" ).isEmpty() ){
        $params = "&html_replacement_selector=" + jget.getString( "html_replacement_selector" );
    }
    JSONObject allEndPoints = nwpCURL.getEndpointsSettings( new JSONObject() );
%>
<div nwp-file="<% out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
<br />
<div class="row">
    <div class="col-md-10 col-md-offset-1">
        <h4 class="card-title-1"><strong>Admin Control Panel</strong></h4>
        <hr />
        <div class="row" >
            <%
                if( allEndPoints.length() > 0 ){
                    for( Object ep : allEndPoints.names() ){
                        String epk = ep.toString();
                        if( allEndPoints.has( epk ) ){
                            JSONObject epj = allEndPoints.getJSONObject( epk );
                            %>
            <div class="col-md-3">
                <div class="note note-warning">
                    <p>Test API: <% out.print( epj.getString("title") ); %></p>
                    <a href="#"
                       class="btn default btn-block custom-single-selected-record-button"
                       override-selected-record="<% out.print( epk ); %>"
                       action="?action=display_sub_menu&todo=&nwp2_action=audit&nwp2_todo=test_endpoint<% out.print( $params ); %>&menu_title=<% out.print( GlobalFunctions.rawurlencode( epj.getString("title") ) ); %>">
                        <% out.print( epj.getString("title") ); %></a>
                </div>
            </div>
            <%
                        }
                    }
                }
            %>

        </div>
    </div>
</div>