<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.GlobalFunctions.get_file_upload_form_field" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <style>
        .inbox {
            margin-bottom: 20px
        }

        .inbox .inbox {
            margin-bottom: 0
        }

        .inbox .tab-content {
            overflow: inherit
        }

        .inbox .inbox-loading {
            display: none;
            font-size: 22px;
            font-weight: 300
        }

        .inbox .inbox-nav {
            margin: 0;
            padding: 0;
            list-style: none
        }

        .inbox .inbox-nav li {
            position: relative
        }

        .inbox .inbox-nav li a {
            color: #4d82a3;
            display: block;
            font-size: 15px;
            border-left: none;
            text-align: left !important;
            padding: 8px 14px;
            margin-bottom: 1px;
            background: #f4f9fd
        }

        .inbox .inbox-nav li.active a, .inbox .inbox-nav li.active:hover a {
            color: #fff;
            border-left: none;
            background: #169ef4 !important;
            text-decoration: none
        }

        .inbox .inbox-nav li.active b {
            top: 0;
            right: -4px;
            width: 8px;
            height: 35px;
            position: absolute;
            display: inline-block;
            background: /*url(../../img/inbox-nav-arrow-blue.png)*/ no-repeat
        }

        .inbox .inbox-nav li:hover a {
            color: #4d82a3;
            background: #eef4f7 !important;
            text-decoration: none
        }

        .inbox .inbox-nav li.compose-btn a {
            color: #fff;
            text-shadow: none;
            text-align: center;
            margin-bottom: 18px;
            background: #35aa47
        }

        .inbox .inbox-nav li.compose-btn i, .inbox .inbox-nav li.compose-btn:hover i {
            top: 1px;
            color: #fff;
            font-size: 15px;
            position: relative;
            background: none !important
        }

        .inbox .inbox-nav li.compose-btn a:hover {
            background-color: #1d943b !important
        }

        .inbox .inbox-header {
            overflow: hidden
        }

        .inbox .inbox-header h1 {
            margin: 0;
            color: #666;
            margin-bottom: 10px
        }

        .inbox .pagination-control {
            text-align: right
        }

        .inbox .pagination-control .pagination-info {
            display: inline-block;
            padding-right: 10px;
            font-size: 14px;
            line-height: 14px
        }

        .inbox tr {
            color: #777;
            font-size: 13px
        }

        .inbox tr label {
            display: inline-block;
            margin-bottom: 0
        }

        .inbox tr.unread td {
            font-weight: 600
        }

        .inbox td i.icon-paper-clip {
            top: 2px;
            color: #d8e0e5;
            font-size: 17px;
            position: relative
        }

        .inbox tr i.icon-star, .inbox tr i.icon-trash {
            cursor: pointer
        }

        .inbox tr i.icon-star {
            color: #eceef0
        }

        .inbox tr i.icon-star:hover {
            color: #fd7b12
        }

        .inbox tr i.inbox-started {
            color: #fd7b12
        }

        .inbox .table th, .inbox .table td {
            border: 0
        }

        .inbox .table th {
            background: #eef4f7;
            border-bottom: solid 5px #fff
        }

        .inbox th.text-right {
            text-align: right
        }

        .inbox th label.inbox-select-all {
            color: #828f97;
            font-size: 13px;
            padding: 1px 4px 0
        }

        .inbox ul.inbox-nav {
            margin-bottom: 0
        }

        .inbox ul.inbox-nav li {
            padding: 0
        }

        .inbox ul.inbox-nav li span {
            color: #828f97;
            font-size: 12px;
            margin-right: 10px
        }

        .inbox ul.inbox-nav i {
            color: #fff;
            padding: 1px 0;
            font-size: 15px;
            cursor: pointer;
            background: #d0dde4 !important
        }

        .inbox ul.inbox-nav i:hover {
            background: #169ef4 !important
        }

        .inbox td.text-right {
            width: 100px;
            text-align: right
        }

        .inbox td.inbox-small-cells {
            width: 10px
        }

        .inbox .table-hover tbody tr:hover > td, .inbox .table-hover tbody tr:hover > th, .inbox .table-striped tbody > tr:nth-child(odd) > td, .inbox .table-striped tbody > tr:nth-child(odd) > th {
            background: #f8fbfd;
            cursor: pointer
        }

        .inbox .table-hover tbody tr:hover > td, .inbox .table-hover tbody tr:hover > th {
            background: #eef4f7
        }

        .inbox .inbox-drafts {
            padding: 8px 0;
            text-align: center;
            border-top: solid 1px #eee;
            border-bottom: solid 1px #eee
        }

        .inbox-view-header {
            margin-bottom: 20px
        }

        .inbox-view-header h1 {
            color: #666;
            font-size: 22px;
            line-height: 24px;
            margin-bottom: 0 !important
        }

        .inbox-view-header h1 a {
            top: -2px;
            color: #fff;
            cursor: pointer;
            font-size: 13px;
            padding: 2px 7px;
            line-height: 16px;
            position: relative;
            background: #b0bcc4;
            display: inline-block
        }

        .inbox-view-header h1 a:hover {
            background: #aab5bc;
            text-decoration: none
        }

        .inbox-view-header i.icon-print {
            color: #94a4ab;
            cursor: pointer;
            font-size: 14px;
            display: inline-block;
            padding: 6px 8px !important;
            background: #edf1f4 !important
        }

        .inbox-view-header i.icon-print:hover {
            background: #e7ebef !important
        }

        .inbox-view-info {
            color: #666;
            padding: 5px 0;
            margin-bottom: 10px;
            border-top: solid 1px #eee;
            border-bottom: solid 1px #eee
        }

        .inbox-view-info strong {
            color: #666;
            margin: 0 10px 0 5px
        }

        .inbox-view-info .inbox-info-btn {
            text-align: right
        }

        .inbox-view-info .inbox-info-btn ul {
            text-align: left
        }

        .inbox-view-info button {
            top: 2px;
            color: #94a4ab;
            font-size: 13px;
            margin-left: 4px;
            padding: 3px 10px;
            position: relative;
            background: #edf1f4
        }

        .inbox-view-info button:hover {
            color: #94a4ab;
            background: #e7ebef
        }

        .inbox-view {
            color: #666;
            padding: 15px 0 0
        }

        .inbox-view a {
            color: #169ce9
        }

        .inbox-attached {
            line-height: 16px
        }

        .inbox-attached a {
            margin: 0 2px
        }

        .inbox-attached img {
            height: auto;
            max-width: 250px;
            margin-bottom: 5px
        }

        .inbox-attached span {
            margin-right: 3px
        }

        .inbox-attached strong {
            color: #555;
            display: block;
            font-size: 13px
        }

        .inbox-attached .margin-bottom-25 {
            margin-bottom: 25px
        }

        .inbox-attached .margin-bottom-15 {
            margin-bottom: 15px
        }

        .inbox-compose {
            margin-top: 1px;
            border: solid 1px #eee
        }

        .inbox-compose-btn {
            padding: 8px 4px;
            background: #f0f6fa
        }

        .inbox-compose-attachment {
            padding: 8px 8px
        }

        .inbox-compose-attachment .btn {
            padding: 4px 10px
        }

        .inbox-compose-btn button {
            color: #fff;
            font-size: 14px;
            margin-left: 4px;
            padding: 4px 10px;
            background: #c0cfdd
        }

        .inbox-compose-btn button:hover {
            color: #fff;
            background: #4d90fe
        }

        .inbox-compose-btn button i {
            margin-right: 3px
        }

        .inbox-compose .inbox-form-group {
            margin-bottom: 0;
            position: relative;
            border-bottom: solid 1px #eee
        }

        .inbox-compose .controls {
            margin-left: 85px
        }

        .inbox-compose .inbox-form-group > label {
            width: 80px;
            float: left;
            color: #979797;
            text-align: right
        }

        .inbox-compose .controls > input {
            border: none !important
        }

        .inbox-compose .controls-to {
            padding-right: 55px
        }

        .inbox-compose .controls-cc {
            padding-right: 20px
        }

        .inbox-compose .controls-bcc {
            padding-right: 20px
        }

        .inbox-compose .inbox-form-group a.close {
            top: 13px;
            right: 10px;
            position: absolute
        }

        .inbox-compose .mail-to .inbox-cc-bcc {
            display: inline-block;
            top: 7px;
            right: 10px;
            color: #979797;
            font-size: 14px;
            cursor: pointer;
            position: absolute
        }

        .inbox-compose .mail-to .inbox-bcc {
            margin-left: 5px
        }

        .inbox-compose .mail-to inbox-cc:hover, .inbox-compose .mail-to inbox-bcc:hover {
            color: #777
        }

        .inbox-compose .wysihtml5 {
            padding: 0 !important;
            margin: 0 !important;
            border: 0 !important
        }

        .inbox-compose .wysihtml5-sandbox {
            padding: 0 !important;
            margin: 0 !important;
            display: block !important;
            border: 0 !important;
            margin-top: 5px;
            width: 100% !important;
            border-left: none;
            border-right: 0;
            border-color: #eee
        }

        .inbox-compose .wysihtml5-toolbar {
            border: 0;
            border-bottom: 1px solid #eee
        }

        .inbox-compose .wysihtml5-toolbar > li {
            height: 34px;
            margin-right: 0;
            margin-bottom: 0
        }

        .inbox-compose .wysihtml5-toolbar > li > a, .inbox-compose .wysihtml5-toolbar > li > div > a {
            background: #fff
        }

        .inbox-compose .wysihtml5-toolbar .dropdown.open .dropdown-toggle, ul.wysihtml5-toolbar a.btn.wysihtml5-command-active {
            background: #eee !important
        }

        @media (max-width: 480px) {
            .inbox-compose .inbox-form-group > label {
                margin-top: 7px
            }
        }

        .wysihtml5-toolbar li {
            margin: 0;
            height: 29px
        }

        .wysihtml5-toolbar li .dropdown-menu {
            margin-top: 5px
        }

        .has-error .wysihtml5-sandbox, .has-error .cke {
            border: 1px solid #b94a48
        }

        .has-success .wysihtml5-sandbox, .has-success .cke {
            border: 1px solid #468847
        }

        .editable-wysihtml5 {
            width: 566px;
            height: 250px
        }

        input.btn {
            width: 100%;
        }
    </style>
    <%
        JSONObject $data = new JSONObject( "{\"reference\":\"ww27160171060\",\"reference_table\":\"workflow\",\"hide_fields\":{\"assigned_to\":1,\"title\":1,\"tag\":1},\"count\":1,\"development\":1}" );

        String $message = ( $data.has( "message" ) && !$data.getString( "message" ).isEmpty() ) ? $data.getString( "message" ) : "";
        JSONObject $hide_fields = ( $data.has( "hide_fields" ) && $data.getJSONObject( "hide_fields" ).length() > 0 ) ? $data.getJSONObject( "hide_fields" ) : new JSONObject();
        String $reference = ( $data.has( "reference" ) && !$data.getString( "reference" ).isEmpty() ) ? $data.getString( "reference" ) : "";
        String $reference_table = ( $data.has( "reference_table" ) && !$data.getString( "reference_table" ).isEmpty() ) ? $data.getString( "reference_table" ) : "";
        GlobalFunctions.app_popup = true;
        GlobalFunctions.app_popup_title = "New Comment";

        $hide_fields.put( "supporting_document", 1 );
        // out.print( '<pre>';print_r( $hide_fields );

        String $btn_caption = "Submit Comment";
        if( !$message.isEmpty() ){
            $btn_caption = "Send Message";
        }
        int $count = $data.has( "count" ) ? $data.getInt( "count" ) : 1;
    %>
    <div id="new_comment_form-container">

        <form name="comments" id="comments-form" method="POST"
              action="?action=comments&todo=save_new_comment_form&html_replacement_selector=new_comment_form-container"
              class="activate-ajax form-horizontal">
            <div class="row">
                <div class="col-md-12">

                    <% if( !$reference.isEmpty() ){ %><input value="<% out.print( $reference ); %>" name="reference"
                                                             style="display:none;"><% } %>
                    <% if( !$reference_table.isEmpty() ){ %><input value="<% out.print( $reference_table ); %>"
                                                                   name="reference_table" style="display:none;"><% } %>
                    <div class="row">
                        <div class="col-md-12 email">

                            <% if( !( $hide_fields.has( "tag" ) ) && !$hide_fields.getString( "tag" ).isEmpty() ){ %>
                            <fieldset>
                                <legend><% out.print( $count ); %> Selected Records</legend>
                                <div id="selectTag">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label>Select Folder</label>

                                            <div class="input-group">
                                                <input class="form-control data-form select2" id="tags_existing"
                                                       action="?action=tags&todo=get_select2" type="text"
                                                       name="tags_name_existing" onchange=""/>

                                                <span class="input-group-btn">
													<a class="btn btn-smx dark" href="#"
                                                       onclick="$.nwCommen.newTag(); return false;"
                                                       title="Create new folder"><i class="icon-folder-close"></i>&nbsp;</a>
												</span>
                                            </div>

                                        </div>
                                    </div>
                                    <br/>
                                </div>

                                <div id="newTag"
                                     style="display: none;  background: #eee; padding: 10px 15px;  margin: 10px 0;">
                                    <a href="#" class="nm btn-sm btn-default pull-right"
                                       onclick="$.nwCommen.newTag2();">x</a><br/>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label>New Folder Name</label>

                                            <input class="form-control data-form" type="text" name="tags_name"
                                                   onchange=""/>

                                        </div>
                                    </div>
                                    <br/>
                                </div>
                            </fieldset>
                            <br/>
                            <br/>
                            <%
                                }
                            %>

                            <fieldset class=" inbox-compose">
                                <legend>Message</legend>
                                <% if( !( $hide_fields.has( "assigned_to" ) ) && !$hide_fields.getString( "assigned_to" ).isEmpty() ){ %>
                                <div class="inbox-form-group mail-to">
                                    <label class="control-label">To:</label>
                                    <div class="controls controls-to">
                                        <input class="form-control select2" type="text" placeholder=""
                                               action="?module=&action=users&todo=get_select2" name="assigned_to"
                                               tags="true" required/>
                                    </div>
                                </div>
                                <%
                                    }
                                %>

                                <% if( !$hide_fields.has( "title" ) && !$hide_fields.getString( "title" ).isEmpty() ){ %>
                                <div class="inbox-form-group">
                                    <label class="control-label">Subject:</label>
                                    <div class="controls">
                                        <input type="text" class="form-control" name="title" required>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <div class="inbox-form-group">
                                    <textarea class="inbox-editor inbox-wysihtml5 form-control" name="message"
                                              rows="12"></textarea>
                                </div>
                            </fieldset>

                        </div>
                    </div>
                    <br/>


                    <% if( !$hide_fields.has( "supporting_document" ) ){ %>
                    <label>Select File</label>
                    <%
                        out.print( get_file_upload_form_field( new JSONObject( "{\"field_id\":\"supporting_document\",\"t\":1,\"attributes\":\" skip-uploaded-file-display=\\\"1\\\" \"}" ) ) );
                    %>
                    <% } %>
                </div>
            </div>
            <%
                /* }*/
            %>
            <br/>

            <div class="row">
                <div class="col-md-12">
                    <input class="btn blue" value="<% out.print( $btn_caption ); %>" type="submit"/>
                </div>
            </div>
        </form>

    </div>


    <% if( !$message.isEmpty() ){ %>
    <hr/>
    <h4><strong>Most Recent Comment</strong></h4>
    <div class="row">
        <div class="col-md-12" id="most-recent-comments">
        </div>
    </div>
    <% } %>

</div>

<script type="text/javascript">
    (function ($) {
        $.nwCommen = {
            newTag2: function () {
                $('#newTag').hide();
                $('#newTag').find('input').val("");
                $('#selectTag').show();
                $('#selectTag').find('input').val("");
            },
            newTag: function () {
                $('#newTag').show();
                $('#selectTag').hide();
                $('#selectTag').find('input').val("");

            },
        };
    }(jQuery));
    <% //if( file_exists( dirname( __FILE__ ).'/script.js' ) )include "script.js"; %>
    var Inbox = function () {
        var content = $('.inbox-content');
        var loading = $('.inbox-loading');
        var loadInbox = function (el, name) {
            var url = 'inbox_inbox.html';
            var title = $('.inbox-nav > li.' + name + ' a').attr('data-title');
            loading.show();
            content.html('');
            toggleButton(el);
            $.ajax({
                type: "GET", cache: false, url: url, dataType: "html", success: function (res) {
                    toggleButton(el);
                    $('.inbox-nav > li.active').removeClass('active');
                    $('.inbox-nav > li.' + name).addClass('active');
                    $('.inbox-header > h1').text(title);
                    loading.hide();
                    content.html(res);
                    App.fixContentHeight();
                    App.initUniform();
                }, error: function (xhr, ajaxOptions, thrownError) {
                    toggleButton(el);
                }, async: false
            });
        }
        var loadMessage = function (el, name, resetMenu) {
            var url = 'inbox_view.html';
            loading.show();
            content.html('');
            toggleButton(el);
            $.ajax({
                type: "GET", cache: false, url: url, dataType: "html", success: function (res) {
                    toggleButton(el);
                    if (resetMenu) {
                        $('.inbox-nav > li.active').removeClass('active');
                    }
                    $('.inbox-header > h1').text('View Message');
                    loading.hide();
                    content.html(res);
                    App.fixContentHeight();
                    App.initUniform();
                }, error: function (xhr, ajaxOptions, thrownError) {
                    toggleButton(el);
                }, async: false
            });
        }
        var initWysihtml5 = function () {
            $('.inbox-wysihtml5').wysihtml5({"stylesheets": ["assets/plugins/bootstrap-wysihtml5/wysiwyg-color.css"]});
        }
        var initFileupload = function () {
            $('#fileupload').fileupload({url: 'assets/plugins/jquery-file-upload/server/php/', autoUpload: true});
            if ($.support.cors) {
                $.ajax({url: 'assets/plugins/jquery-file-upload/server/php/', type: 'HEAD'}).fail(function () {
                    $('<span class="alert alert-error"/>').text('Upload server currently unavailable - ' +
                        new Date()).appendTo('#fileupload');
                });
            }
        }
        var loadCompose = function () {
            loading.show();
            content.html('');
            initWysihtml5();
        }
        var loadReply = function (el) {
            var url = 'inbox_reply.html';
            loading.show();
            content.html('');
            toggleButton(el);
            $.ajax({
                type: "GET", cache: false, url: url, dataType: "html", success: function (res) {
                    toggleButton(el);
                    $('.inbox-nav > li.active').removeClass('active');
                    $('.inbox-header > h1').text('Reply');
                    loading.hide();
                    content.html(res);
                    $('[name="message"]').val($('#reply_email_content_body').html());
                    handleCCInput();
                    initFileupload();
                    initWysihtml5();
                    App.fixContentHeight();
                    App.initUniform();
                }, error: function (xhr, ajaxOptions, thrownError) {
                    toggleButton(el);
                }, async: false
            });
        }
        var loadSearchResults = function (el) {
            var url = 'inbox_search_result.html';
            loading.show();
            content.html('');
            toggleButton(el);
            $.ajax({
                type: "GET", cache: false, url: url, dataType: "html", success: function (res) {
                    toggleButton(el);
                    $('.inbox-nav > li.active').removeClass('active');
                    $('.inbox-header > h1').text('Search');
                    loading.hide();
                    content.html(res);
                    App.fixContentHeight();
                    App.initUniform();
                }, error: function (xhr, ajaxOptions, thrownError) {
                    toggleButton(el);
                }, async: false
            });
        }
        var handleCCInput = function () {
            var the = $('.inbox-compose .mail-to .inbox-cc');
            var input = $('.inbox-compose .input-cc');
            the.hide();
            input.show();
            $('.close', input).click(function () {
                input.hide();
                the.show();
            });
        }
        var handleBCCInput = function () {
            var the = $('.inbox-compose .mail-to .inbox-bcc');
            var input = $('.inbox-compose .input-bcc');
            the.hide();
            input.show();
            $('.close', input).click(function () {
                input.hide();
                the.show();
            });
        }
        var toggleButton = function (el) {
            if (typeof el == 'undefined') {
                return;
            }
            if (el.attr("disabled")) {
                el.attr("disabled", false);
            } else {
                el.attr("disabled", true);
            }
        }
        return {
            init: function () {
            }
        };
    }();

    Inbox.init();
</script>
