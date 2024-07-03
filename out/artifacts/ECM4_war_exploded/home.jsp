<%@ page import="static codes.NavBar.getNvaigationTabs" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
<div class="app-container app-theme-white body-tabs-shadow fixed-sidebar fixed-header">

    <div class="app-header header-shadow" >
        <div class="app-header__logo">
            <div class="logo-src"></div>
            <div class="header__pane ml-auto">
                <div>
                    <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar" onclick="">
                            <span class="hamburger-box">
                                <span class="hamburger-inner"></span>
                            </span>
                    </button>
                </div>
            </div>
        </div>
        <div class="app-header__mobile-menu">
            <div>
                <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
                        <span class="hamburger-box">
                            <span class="hamburger-inner"></span>
                        </span>
                </button>
            </div>
        </div>
        <div class="app-header__menu">
                <span>
                    <button type="button" class="btn-icon btn-icon-only btn btn-success btn-sm mobile-toggle-header-nav">
                        <span class="btn-icon-wrapper">
                            <i class="fa fa-ellipsis-v fa-w-6"></i>
                        </span>
                    </button>
                </span>
        </div>    <div class="app-header__content">
        <div class="app-header-left" >
            <!--
            <div class="search-wrapper">
                <div class="input-holder">
                    <input type="text" class="search-input" placeholder="Type to search">
                    <button class="search-icon"><span></span></button>
                </div>
                <button class="close"></button>
            </div>
            -->
            <ul id="main-tabs" class="body-tabs body-tabs-layout tabs-animated body-tabs-animated nav">
            <%out.println(getNvaigationTabs( "home" ));%>
            </ul>
        </div>
        <div class="app-header-right">
            <div class="header-btn-lg pr-0">
                <div class="widget-content p-0">
                    <div class="widget-content-wrapper">
                        <div class="widget-content-left">
                            <div class="btn-group">
                                <a data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="p-0 btn">
                                    <img width="42" class="rounded-circle" src="" alt="">
                                    <i class="fa fa-angle-down ml-2 opacity-8"></i>
                                </a>
                                <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-right">
                                    <a href="#" tabindex="0" class="custom-single-selected-record-button dropdown-item" action="?action=users&todo=display_my_profile_manager" title="My Profile Manager" override-selected-record="-" >My Profile</a>

                                    <div tabindex="-1" class="dropdown-divider"></div>

                                    <a href="switch-user.html" class="dropdown-item">
                                        <small><i class="icon-key"></i> Switch User</small>
                                    </a>
                                    <div tabindex="-1" class="dropdown-divider"></div>
                                    <a href="../engine/sign_out?action=signout" class="dropdown-item">
                                        <small><i class="icon-power-off"></i> Sign Out</small>
                                    </a>

                                    <div tabindex="-1" class="dropdown-divider"></div>
                                    <a href="#"class="dropdown-item" tabindex="0" onclick="alert( '' );">About</a>
                                </div>
                            </div>
                        </div>
                        <div class="widget-content-left  ml-3 header-user-info">
                            <div class="widget-heading">

                            </div>
                            <div class="widget-subheading">

                            </div>
                        </div>
                        <!--
                        <div class="widget-content-right header-user-info ml-3">
                            <button type="button" class="btn-shadow p-1 btn btn-success btn-sm show-toastr-example">
                                <i class="fa text-white fa-calendar pr-1 pl-1"></i>
                            </button>
                        </div>
                        -->
                    </div>
                </div>
            </div>
        </div>

    </div>
    </div>
    <div class="app-main" id="dash-board-main-content-area">
        <div style="text-align:center;">
            <br />
            <br />
            <br />
            <img src="hospital-assets/img/ajax-loading.gif" />
            <br />
            <br />
            <br />
        </div>

    </div>
</div>
<script type="text/javascript">

    $('ul#main-tabs')
        .find("a.nav-link")
        .add("a.empty-tab")
        .on("click", function( e ){

            $('ul#main-tabs')
                .find("a.nav-link")
                .add("a.empty-tab")
                .removeClass("active");

            $(this)
                .addClass("active");

        });

    $('button.mobile-toggle-header-nav')
        .on("click", function( e ){
            if( $('ul#main-tabs').is(":visible") ){
                $('.app-header__content')
                    .add('.app-header-left')
                    .css("visibility", "hidden")
                    .css("opacity", 0);

                $('.app-header__content')
                    .css("top", "0");
                //.css("position", "relative")

                $('ul#main-tabs')
                    .hide();
            }else{
                $('.app-header__content')
                    .add('.app-header-left')
                    .css("visibility", "visible")
                    .css("opacity", 1);

                //.css("position", "relative")

                $('ul#main-tabs')
                    .show();

                $('.app-header__content')
                    .css("top", "70px")
                    .css("height", "auto")
                    .css("width", "100%")
                    .css("left", "0");
            }
        });

    $('button.close-sidebar-btn')
        .add('button.mobile-toggle-nav')
        .add('button.mobile-toggle-header-na')
        .on("click", function( e ){

            if( $('.app-sidebar').css('transform') == "none" ){
                $('.fixed-sidebar .app-main .app-main__outer').css('padding-left', "0px");
                $('.app-sidebar').css('transform', "translateX(-280px)");
            }else{
                $('.fixed-sidebar .app-main .app-main__outer').css('padding-left', "280px");
                $('.app-sidebar').css('transform', "none");
            }

            $nwProcessor.reload_datatable();
        });

    $('body')
        .on("click", 'li.app-sidebar__heading', function( e ){

            $(this)
                .siblings()
                .find("i")
                .removeClass("icon-caret-down")
                .addClass("icon-caret-left");

            $(this)
                .siblings()
                .next()
                .find("ul")
                .addClass("hidden");

            $(this)
                .find("i")
                .removeClass("icon-caret-left")
                .addClass("icon-caret-down");

            $(this)
                .next()
                .find("ul:first")
                .hide()
                .removeClass("hidden")
                .slideDown();

        });
</script>
</div>