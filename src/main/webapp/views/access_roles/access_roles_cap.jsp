<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 4/13/2022
  Time: 10:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.GlobalFunctions.*" %>
<%@ page import="static codes.nwpAccessRoles.*" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
    String $title = "New Access Role";
    JSONObject $rd = new JSONObject();

    if( jget.has("nwp2_action") && jpet.has("id") && ! jpet.getString("id").isEmpty() && jget.has("nwp_ub") && jget.getString("nwp_ub").equals("edit") ) {
        JSONObject $qs = new JSONObject();
        $qs.put( "id", jpet.getString("id") );
        $qs.put( "table", jget.getString("nwp2_action") );
        $rd = GlobalFunctions.get_record( $qs );
        $title = "Edit Access Role: " + ($rd.has("name")?$rd.getString("name"):"");
    }else if( jget.has("selected_record") && ! jget.getString("selected_record").isEmpty() ){
        JSONObject $qs = new JSONObject();
        $qs.put( "id", jget.getString("selected_record") );
        $qs.put( "table", jget.getString("nwp2_action") );
        $rd = GlobalFunctions.get_record( $qs );

        if( $rd.has("id") ) {
            $title += " Cloned From: " + ($rd.has("name") ? $rd.getString("name") : "");
            $rd.remove("id");
            $rd.remove("name");
        }
    }

    JSONObject $data = GetManageCapabilitiesData();
    JSONObject $frontend_menus_function = $data.getJSONObject("frontend_menus_function");
    JSONObject $sys_module = new JSONObject();
%>
<div>
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <%
                String $params = "";
                if( jget.has("html_replacement_selector") && ! jget.getString("html_replacement_selector").isEmpty() ){
                    $params = "&html_replacement_selector=" + jget.getString("html_replacement_selector");
                }
            %>
            <div class="portlet grey box">
                <div class="portlet-title">
                    <div class="caption">
                        <small><% out.print( $title ); %></small>
                    </div>
                </div>
                <div class="portlet-body resizable-height auto-scroll" style="padding-bottom:50px;">

                    <style type="text/css">
                        .account-list-form label{font-weight:bold;font-size:.9em}.items-search{max-width:100px}code.green{color:#376b00}.s2-wrapper{clear:both;width:100%}.s2-wrapper .select2{display:block!important}.s2-account-select-2,.s2-account-select-3{display:none}.portlet{margin-bottom:5px}#data-entry-form-container label{font-size:10px;font-weight:600}#data-entry-form-container h3{font-size:12px!important;font-weight:600;margin-top:0}.shopping-cart-table tbody tr th,.shopping-cart-table tbody tr td{font-size:11px;border-color:#9e9e9e}.shopping-cart-table thead tr th{font-size:11px;text-transform:uppercase}.shopping-cart-table tfoot tr th{font-size:11px}.shopping-cart-table tfoot th,.shopping-cart-table thead th{background:#ddd}th.r,td.r{text-align:right}th.c,td.c{text-align:center}.shopping-cart-table .table-striped>tbody>tr:nth-child(even)>td,.table-striped>tbody>tr:nth-child(even)>th{background:#f1f5f9}.shopping-cart-table .table-striped>tbody>tr:nth-child(odd)>td,.table-striped>tbody>tr:nth-child(odd)>th{background:#fff}.allow-scroll-1{max-height:450px;overflow-y:auto;overflow-x:hidden;padding-bottom:20px}.allow-scroll{max-height:500px;overflow-y:auto;overflow-x:hidden;padding-bottom:20px}
                    </style>


                    <div class="row">
                        <div class="col-md-10 col-md-offset-1">
                            <%
                                String i_id = "";
                                String i_name = "";
                                if( $rd.has("id") && !$rd.getString("id").equals("") ){
                                    i_id = $rd.getString("id");
                                    i_name = $rd.getString("name");
                                }
                            %>

                            <br />
                            <form id="access_role-form" action="?action=display_menu&todo=save_access_roles_cap&nwp2_action=access_roles&nwp2_todo=display_all_records_full_view&nwp_action=&nwp_todo=<% out.print( $params ); %>" class="activate-ajax" method="post">

                                <%
                                    //print_r( $data["modules"] );
                                    //print_r( $data["functions"] );
                                    //out.print( '<pre>';print_r( $data["event"] ); out.print( '</pre>';
                                    // out.print( '<pre>';print_r( $data[ 'status_table' ] ); out.print( '</pre>';

                                    JSONObject $dsel = new JSONObject();
                                    if( $rd.has("data") && !$rd.getString("data").isEmpty() ){
                                        try {
                                            $dsel = new JSONObject($rd.getString("data"));
                                        }catch (Exception e){

                                        }
                                    }

                                    JSONArray $selected = new JSONArray();
                                %>
                                <textarea name="data" class="form-control dev1kit-data" style="display:none;"><% out.print( $dsel.toString() ); %></textarea>
                                <input type="hidden" name="id" value="<% out.print( i_id ); %>" />
                                <div class="row">
                                    <div class="col-md-6">
                                        <input type="text" name="name" style="font-weight:bold;" value="<% out.print( i_name ); %>" placeholder="Name of Access Role" class="form-control" required="required" />
                                    </div>
                                </div>
                                <br />
                            </form>
                            <form id="client-form" >
                                <%
                                    JSONObject $stores_modules = new JSONObject();
                                    JSONObject $api_modules = new JSONObject();
                                    JSONObject $sys_modules = new JSONObject();
                                    JSONObject $modules = new JSONObject();
                                    JSONObject $modules2 = new JSONObject();
                                    JSONObject $modules3 = new JSONObject();
                                    JSONObject $m_title = ( $data.has("modules") && ! $data.isNull("modules") ) ? $data.getJSONObject("modules") : new JSONObject();
                                    JSONObject $frontend_menus = ( $data.has("frontend_menus") && ! $data.isNull("frontend_menus") ) ? $data.getJSONObject("frontend_menus") : new JSONObject();

                                    if( $frontend_menus.length() > 0 ){
                                        for( int i = 0; i < $frontend_menus.names().length(); i++ ){
                                            String $bk = $frontend_menus.names().getString(i);
                                            JSONObject $sval = new JSONObject( $frontend_menus.getJSONObject($bk).toString() );
                                            JSONObject $sys_data = new JSONObject();

                                            $sval.put("id", $bk);
                                            $sval.put("label", $sval.has("title") ? $sval.getString("title") : $bk );
                                            $sval.put("function_name", $sval.getString("label"));

//                                            String $sval_module_name = $sval.getString("module_name");
                                            String $sval_module_name = ( ( $sval.has("prefix") ) ? $sval.getString("prefix") : "" ) + $sval.getString("label");
                                            if( $sval.has("sub_menu") && $sval.getJSONObject("sub_menu").length() > 0 ){

                                                //$sys_modules[ $sval["module_name"] ]["data"][ $sval['title'] ][ $sval["id"] ] = $sval;
                                                JSONArray $sub_menu = $sval.getJSONObject("sub_menu").names();
                                                JSONObject sysDataSub = new JSONObject();
                                                for(int i2 = 0; i2 < $sub_menu.length(); i2++ ){
                                                    String $bk2 = $sub_menu.getString(i2);
                                                    if( $frontend_menus_function.has($bk2) && ! $frontend_menus_function.getJSONObject($bk2).getString("title").isEmpty() ){
                                                        JSONObject $sval2 = $data.getJSONObject("frontend_menus_function").getJSONObject($bk2);

                                                        JSONArray $sub_menu2 = ( $sval2.has("sub_menu") && !$sval2.isNull("sub_menu") && $sval2.getJSONObject("sub_menu").length() > 0 ) ? $sval2.getJSONObject("sub_menu").names() : new JSONArray();


                                                        if( $sub_menu2.length() > 0 ){

                                                            for( int i3 = 0; i3 < $sub_menu2.length(); i3++ ){
                                                                String $bk3 = $sub_menu2.getString(i3);

                                                                if( $frontend_menus_function.has($bk3) &&  $frontend_menus_function.getJSONObject($bk3).has("title") && ! $frontend_menus_function.getJSONObject($bk3).getString("title").isEmpty() ){
                                                                    JSONObject $sval3 = $frontend_menus_function.getJSONObject($bk3);

                                                                    $sval3.put("id",$bk3);
                                                                    $sval3.put( "function_name", $sval3.getString("title") );

                                                                    // $sys_data.put($sval2.getString("title"), );
                                                                    //$sys_modules[ $sval["module_name"] ]["data"][ $sval2["title"] ][ $sval3["id"] ] = $sval3;
                                                                    sysDataSub.put( $sval3.getString("id"), $sval3 );

                                                                }
                                                            }

                                                        }else{

                                                            $sval2.put("id", $bk2);

                                                            $sval2.put("function_name", ( $sval2.has("prefix") ? $sval2.getString("prefix") : "" ) + $sval2.getString("title") );
                                                            sysDataSub.put( $sval2.getString("id"), $sval2 );

                                                            /*Check later
                                                            $sys_modules.put($sval.getString("module_name"), new JSONObject().put("data", new JSONObject().put( $sval2.getString("id"), $sval2) ) );*/
                                                            //$sys_modules[ $sval["module_name"] ]["data"][ $ax1 ][ $sval2["id"] ] = $sval2;
                                                        }


                                                    }
                                                }

                                                if( $sval.has("title") ) {
                                                    //System.out.println(sysDataSub);
                                                    $sys_data.put("data", sysDataSub );
                                                    //$sys_data.put($sval.getString("title"), sysDataSub );
                                                }
                                            }else{
                                                //$sys_modules[ '*Other Menus' ]["data"][ $sval["id"] ] = $sval;
                                            }

                                            if( ! $sval_module_name.isEmpty() && $sys_data.length() > 0 ){
                                                //System.out.println($sys_data);
                                                $sys_module.put( $sval_module_name, $sys_data );
                                            }

                                        }
                                    }

                                    JSONObject $customModules = new JSONObject();

                                    if( $data.has("frontend_tabs") && $data.getJSONObject("frontend_tabs").length() > 0 ){
                                        JSONObject fmm = new JSONObject();

                                        for(int i = 0; i < $data.getJSONObject("frontend_tabs").length(); i++ ){
                                            String $bk = $data.getJSONObject("frontend_tabs").names().getString(i);

                                            JSONObject $sval = $data.getJSONObject("frontend_tabs").getJSONObject($bk);
                                            if( ! $sval.has("no_access") ){
                                                $sval.put("id", "frontend_tabs." + $bk);
                                                $sval.put("label", $sval.getString("title"));
                                                $sval.put("function_name", $sval.getString("title"));

                                                fmm.put( $sval.getString("id"), $sval );
                                            }
                                        }

                                        $customModules.put("Frontend Modules", fmm );
                                        $data.remove("frontend_tabs");
                                    }

                                    if( $data.has("home_menu") && $data.getJSONArray("home_menu").length() > 0 ){
                                        JSONObject fmm = new JSONObject();

                                        for(int i = 0; i < $data.getJSONArray("home_menu").length(); i++ ){

                                            JSONObject $sval = $data.getJSONArray("home_menu").getJSONObject(i);
                                            if( ! $sval.has("no_access") && $sval.has("menu_key") ){
                                                $sval.put("id", "home_menu." + $sval.getString("menu_key") );
                                                $sval.put("label", $sval.getString("text"));
                                                $sval.put("function_name", $sval.getString("text"));

                                                fmm.put( $sval.getString("id"), $sval );
                                            }
                                        }

                                        $customModules.put("Home Menu", fmm );
                                        $data.remove("home_menu");
                                    }

                                    if( $customModules.length() > 0 ){
                                        $modules2.put("Modules", new JSONObject().put("data", $customModules ) );
                                    }

                                    if( $data.has("basic_crud") && $data.getJSONObject("basic_crud").length() > 0 ){
                                        JSONObject basicCrudData = new JSONObject();

                                        JSONObject $basic_crud_methods = new JSONObject("{\"create_new_record\":\"Create\", \"edit\" : \"Edit\", \"delete\": \"Delete\", \"export\" : \"Export\"}");
                                        for(int i = 0; i < $data.getJSONObject("basic_crud").names().length(); i++ ){
                                            JSONObject basicCrudSub = new JSONObject();
                                            String $bdk = $data.getJSONObject("basic_crud").names().getString(i);
                                            JSONObject $sval = $data.getJSONObject("basic_crud").getJSONObject($bdk);
                                            JSONObject dto = ($sval.has("datatable_options")) ? $sval.getJSONObject("datatable_options") : new JSONObject();
                                            JSONObject $special_actions = (dto.has("special_actions")) ? dto.getJSONObject("special_actions") : new JSONObject();

                                            for( int i2 = 0; i2 < $basic_crud_methods.length(); i2++ ){
                                                String $bk = $basic_crud_methods.names().getString(i2);
                                                String $bv = $basic_crud_methods.getString($bk);

                                                if( ! ( $sval.has("exclude_from_crud") &&  $sval.getJSONObject("exclude_from_crud").has($bk) ) ){
                                                    JSONObject $sval2 = new JSONObject( $sval.toString() );
                                                    $sval2.put("id", $sval.getString("name") + "." + $bk);
                                                    $sval2.put("function_name", $bv);

                                                    //$modules2[ 'Basic CRUD' ]["data"][ $sval["label"] ][ $sval["id"] ] = $sval;
                                                    basicCrudSub.put( $sval2.getString("id"), $sval2 );
                                                    //System.out.println( $sval.getString("table_name") + "." + $bk );
                                                    //System.out.println( basicCrudSub );
                                                }
                                            }

                                            if( $special_actions.length() > 0 ){
                                                for( int i3 = 0; i3 < $special_actions.names().length(); i3++ ){
                                                    String $spk =  $special_actions.names().getString(i3);
                                                    JSONObject $spv = $special_actions.getJSONObject($spk);
                                                    if( $spv.has("type") && $spv.has("todo") ){
                                                        if( $spv.getString("type").equals("function") ) {

                                                            JSONObject $spf = neutralJ($spv.getString("todo"), new JSONObject());
                                                            if ($spf.length() > 0) {
                                                                for (int i2 = 0; i2 < $spf.length(); i2++) {
                                                                    String $spfk = $spf.names().getString(i2);
                                                                    String $spfv = $spf.getString($spfk);
                                                                    JSONObject $sp_val = new JSONObject();
                                                                    $sp_val.put("id", $sval.getString("name") + "." + $spk + "." + $spfk);
                                                                    $sp_val.put("function_name", $spfv);

                                                                    //$modules2[ 'Basic CRUD' ]["data"][ $sval["label"] .' - '. $spv["label"] ][ $sp_val["id"] ] = $sp_val;
                                                                    //$modules2.getJSONObject("Basic CRUD").getJSONObject("data").getJSONObject($sval.getString("label") + " - " + $spv.getString("label")).put($sp_val.getString("id"), $sp_val);
                                                                }
                                                            }
                                                        }else{

                                                            $spv.put("id", $sval.getString("name")  +"." + $spk + "." + $spv.getString("todo"));
                                                            $spv.put("function_name", $spv.getString("title"));

                                                            basicCrudSub.put( $spv.getString("id"), $spv );

                                                            //$modules2.getJSONObject("Basic CRUD").getJSONObject("data").getJSONObject($sval.getString("label")).put($spv.getString("id"), $spv);
                                                        }
                                                    }
                                                }
                                            }

                                            if( $sval.has("label") ) {

                                                basicCrudData.put($sval.getString("label"), basicCrudSub);
                                            }
                                            /*if( dto.has("more_actions") && dto.getJSONObject("more_actions").length() > 0 ){
                                                for( int i3 = 0; i3 < dto.getJSONObject("more_actions").length(); i3++  ){
                                                    if( ! $act2.has("title") ){
                                                        continue;
                                                    }

                                                    if( ( $act2["data"] ) && ! empty( $act2["data"] ) ){
                                                        foreach( $act2["data"] as $act3 ){
                                                            if( ! empty( $act3 ) ){
                                                                foreach( $act3 as $bk1 => $bv1 ){

                                                                    if( isset( $sval["exclude_from_crud"][ $act2k . '.' . $bk1 ] ) ){
                                                                    continue;
                                                                    }

                                                                    if( ! isset( $bv1[ 'text' ] ) ){
                                                                    continue;
                                                                    // out.print( '<pre>';print_r( $sval ); out.print( '</pre>';
                                                                    }

                                                                    $act_val = new JSONObject();
                                                                    $act_val["id"] = $sval["table_name"] . '.' . $act2k . '.' . $bk1;
                                                                    $act_val["function_name"] = ( isset( $bv1["title"] ) && $bv1["title"] )?$bv1["title"]:$bv1["text"];
                                                                    //$act_val["function_name"] = $act2["title"] .' - '. $bv1["text"];

                                                                    $modules2[ 'Basic CRUD' ]["data"][ $sval["label"] ][ $act_val["id"] ] = $act_val;
                                                                }
                                                            }
                                                        }
                                                    }else{
                                                        if( isset( $act2["todo"] ) && ! isset( $sval["exclude_from_crud"][ $act2k ] ) ){

                                                            $act_val = new JSONObject();
                                                            $act_val["id"] = $sval["table_name"] . '.' . $act2k;
                                                            $act_val["function_name"] = ( isset( $act2["title"] ) && $act2["title"] )?$act2["title"]:$act2["text"];

                                                            $modules2[ 'Basic CRUD' ]["data"][ $sval["label"] ][ $act_val["id"] ] = $act_val;
                                                        }
                                                    }

                                                }
                                            }*/
                                        }
                                        //System.out.println(basicCrudData);
                                        $modules2.put("Basic CRUD", new JSONObject().put("data", basicCrudData ));
                                        $data.remove("basic_crud");
                                    }

                                    Boolean hasEmail = true;
                                    if( GlobalFunctions.app_data.has("skip_email_in_workflow_cap")
                                                    && GlobalFunctions.app_data.getBoolean("skip_email_in_workflow_cap") ){
                                                    hasEmail = false;
                                    }

                                    if( $data.has("status_table") && $data.getJSONObject("status_table").length() > 0 ){
                                        JSONObject statusCrudData = new JSONObject();
                                        for( int i = 0; i < $data.getJSONObject("status_table").names().length(); i++ ){
                                            String $ttext  = $data.getJSONObject("status_table").names().getString(i);
                                            JSONObject $dst = $data.getJSONObject("status_table").getJSONObject($ttext);
                                            if( $dst.length() > 0 ){
                                                JSONObject statusCrudDataSub = new JSONObject();

                                                for( int i2 = 0; i2 <$dst.length(); i2++ ){
                                                    // $k1 .= $tp;
                                                    String $k1 = $dst.names().getString(i2);
                                                    JSONObject $sv = $dst.getJSONObject($k1);

                                                    if( $sv.length() > 0 ){
                                                        for( int i3 = 0; i3 < $sv.length(); i3++ ){
                                                            String sbk = $sv.names().getString(i3);
                                                            String sbv = $sv.getString(sbk);
                                                            JSONObject $sval = new JSONObject();

                                                            $sval.put("class", "status-item");
                                                            $sval.put("input_key", "status");
                                                            $sval.put("input_key2", $k1);
                                                            $sval.put("input_name", "status[]");

                                                            $sval.put("label", $ttext);
                                                            $sval.put("table_name", $k1);
                                                            $sval.put("id", sbk );
                                                            $sval.put("function_name", sbv);

                                                            $sval.put("input_attr", " data-table=\""+ $k1 +"\" ");

                                                            //$modules2.getJSONObject("Status").getJSONObject("data").getJSONObject($sval.getString("label")).put($sval.getString("id"), $sval);

                                                            statusCrudDataSub.put(  sbk, $sval );

                                                            if( hasEmail ){
                                                                JSONObject $svale = new JSONObject( $sval.toString() );
                                                                String sbke = "cc_" + sbk;
                                                                $svale.put( "id", sbke );
                                                                $svale.put("function_name", "EMAIL: " + sbv);
                                                                statusCrudDataSub.put(  sbke, $svale );
                                                            }

                                                        }
                                                    }
                                                }
                                                //System.out.println(statusCrudDataSub);
                                                statusCrudData.put( $ttext, statusCrudDataSub );

                                                // unset( $data["status_table"] );
                                            }
                                        }
                                        $modules2.put("Status", new JSONObject().put("data", statusCrudData ));
                                    }
                                    //System.out.println($sys_module);
                                    JSONArray $sections = new JSONArray();
                                    // $sections.put(new JSONObject().put("title", "Custom Modules").put("data", $modules));
                                    $sections.put(new JSONObject().put("title", "System Modules").put("data", $sys_module));
                                    $sections.put(new JSONObject().put("title", "API Modules").put("data", $api_modules));
                                    $sections.put(new JSONObject().put("title", "States & LGA").put("data", $modules3));
                                    $sections.put(new JSONObject().put("title", "Business Units").put("data", $modules3));
                                    $sections.put(new JSONObject().put("title", "").put("data", $modules2));


                                    /*$sections = array(
                                    array(
                                    'title' => 'Custom Modules',
                                    'data' => $modules,
                                    ),
                                    array(
                                    'title' => 'System Modules',
                                    'data' => $sys_modules,
                                    ),
                                    array(
                                    'title' => 'API Modules',
                                    'data' => $api_modules,
                                    ),
                                    array(
                                    'title' => 'States & LGA',
                                    'data' => $modules3,
                                    ),
                                    array(
                                    'title' => 'Business Units',
                                    'data' => $stores_modules,
                                    ),
                                    array(
                                    'data' => $modules2,
                                    ),
                                    );*/
                                    //System.out.println($sections);
                                    for(int i = 0; i < $sections.length(); i++ ){
                                        JSONObject $m1 = $sections.getJSONObject(i);

                                        if( $m1.has("data")  && $m1.getJSONObject("data").length() > 0 ){

                                            if( $m1.has("title") && ! $m1.getString("title").isEmpty() ){
                                %>
                                <details style="border:1px dashed; margin-bottom:20px; padding:10px;">
                                    <summary style="cursor:pointer;"><h4 style="display:inline;"><strong><% out.print( $m1.getString("title") ); %></strong></h4></summary><br />
                                    <%
                                        }

                                        for(int i2 = 0; i2 < $m1.getJSONObject("data").names().length(); i2++ ){
                                            String $module_id = $m1.getJSONObject("data").names().getString(i2);
                                            JSONObject $val = $m1.getJSONObject("data").getJSONObject($module_id);
                                            if( $val.length() > 0 ){
                                    %>
                                    <details style="border:1px dashed; margin-bottom:20px; padding:10px;" <% if( $val.has("id") ){ out.print( " id=\"mod-" + $val.getString("id") + "\"" ); }%> class="<% if( $val.has("class") ){ out.print( " cls-" + $val.getString("class") ); } %>">
                                        <summary style="cursor:pointer;"><strong><big><% out.print(  $m_title.has($module_id) ? $m_title.getString($module_id) : $module_id ); %></big></strong></summary>
                                        <div class="row">
                                            <%
                                                /*$val.get("data").toString; $selected; $dsel;*/
//                                               out.print( neutralS("___format_access_capabilities",  $val.get("data").toString() ) );

//                                                To be reviewed
                                                //System.out.println($val.getJSONObject("data"));
                                                if( $val.has("data") ) {
                                                    out.print(formatAccessRoleCapabilities($val.getJSONObject("data"), $selected, $dsel));
                                                }
                                            %>
                                        </div>
                                    </details>
                                    <%
                                            }
                                        }

                                        if( $m1.has("title") && ! $m1.getString("title").isEmpty() ){
                                    %>
                                </details>
                                <hr />
                                <%
                                            }

                                        }
                                    }
                                %>
                                <br />
                                <input type="submit" value="Save Changes" class="btn blue" />

                            </form>

                            <br />

                        </div>

                    </div>

                    <script type="text/javascript" class="auto-remove">
                        <% // if( file_exists( dirname( __FILE__ ).'/script.js' ) )include "script.js"; %>
                        var nwAccess_roles=function(){return{data:{accessible_functions:{},status:{},states:{},lga:{},},first:1,init:function(){var dj=JSON.parse($("form#access_role-form").find('textarea[name="data"]').val());if(dj&&!$.isEmptyObject(dj)&&dj.accessible_functions){if($.isEmptyObject(dj.accessible_functions)){dj.accessible_functions={};}
                                nwAccess_roles.data=dj;}
                                nwAccess_roles.updateData();$("form#client-form").submit(function(e){e.preventDefault();nwAccess_roles.updateData();$("form#access_role-form").submit();});$(".cls-con-lga").hide();$('input[name="accessible_functions[]"]').change(function(){if($(this).is(":checked")){nwAccess_roles.data.accessible_functions[$(this).val()]=1;}else{if(nwAccess_roles.data.accessible_functions[$(this).val()]){delete nwAccess_roles.data.accessible_functions[$(this).val()];}}
                                    nwAccess_roles.updateDataTimer();});$("input.status-item").change(function(){var $e=$('#mod-'+$(this).val());var s=$(this).attr('data-table');if($.isEmptyObject(nwAccess_roles.data.status)){nwAccess_roles.data.status={};}
                                    if($(this).is(":checked")){if(!nwAccess_roles.data.status[s]){nwAccess_roles.data.status[s]={};}
                                        nwAccess_roles.data.status[s][$(this).val()]=1;}else{if(nwAccess_roles.data.status&&nwAccess_roles.data.status[s]&&nwAccess_roles.data.status[s][$(this).val()]){delete nwAccess_roles.data.status[s][$(this).val()];if($.isEmptyObject(nwAccess_roles.data.status[s])){delete nwAccess_roles.data.status[s];}}}
                                    nwAccess_roles.updateData();}).change();$("input.state-item").change(function(){var $e=$('#mod-'+$(this).val());if($.isEmptyObject(nwAccess_roles.data.states)){nwAccess_roles.data.states={};}
                                    if($(this).is(":checked")){nwAccess_roles.data.states[$(this).val()]=1;$e.show();}else{$e.hide();if(!nwAccess_roles.first){$e.find('input[type="checkbox"]').prop("checked",false);if(nwAccess_roles.data.states[$(this).val()]){delete nwAccess_roles.data.states[$(this).val()];}}}
                                    nwAccess_roles.updateData();}).change();$("input.lga-item").change(function(){var s=$(this).attr('data-state');var a=0;if($(this).hasClass('lga-item-all')){a=1;}
                                    if(s){if($.isEmptyObject(nwAccess_roles.data.lga)){nwAccess_roles.data.lga={};}
                                        if($(this).is(":checked")){if(!nwAccess_roles.data.lga[s]){nwAccess_roles.data.lga[s]={};}
                                            nwAccess_roles.data.lga[s][$(this).val()]=1;if(a){nwAccess_roles.data.lga[s]={};nwAccess_roles.data.lga[s][$(this).val()]=1;$("input.lga-"+s).prop("checked",true).prop("disabled",true);}}else{if(nwAccess_roles.data.lga[s]&&nwAccess_roles.data.lga[s][$(this).val()]){delete nwAccess_roles.data.lga[s][$(this).val()];}
                                            if(a){$("input.lga-"+s).prop("disabled",false);}}
                                        nwAccess_roles.updateDataTimer();}else{var data={theme:'alert-danger',err:'Invalid State',msg:'Please try again',typ:'jsuerror'};$.fn.cProcessForm.display_notification(data);}}).change();nwAccess_roles.first=0;},timer:'',updateDataTimer:function(){if(nwAccess_roles.timer){clearTimeout(nwAccess_roles.timer);}
                                nwAccess_roles.timer=setTimeout(nwAccess_roles.updateData,300);},updateData:function(){nwAccess_roles.timer='';$("form#access_role-form").find('textarea[name="data"]').val(JSON.stringify(nwAccess_roles.data));},};}();nwAccess_roles.init();
                    </script>

                </div>
            </div>
        </div>
    </div>
</div>
</div>