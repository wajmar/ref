<!DOCTYPE html>

<html lang="en">
<head>
	<meta charset="utf-8">

	<title>@yield('title') - {{ Laralum::settings()->website_title }}</title>
	<meta name="description" content="Laralum - Laravel administration panel">
	<meta name="author" content="Èrik Campobadal Forés">

	{!! Laralum::includeAssets('laralum_header') !!}

	{!! Laralum::includeAssets('charts') !!}

  @yield('css')

  <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

  </head>

  <body class="nav-md">

   <form id="logout-form" action="{{ url('/logout') }}" method="POST" style="display: none;">
    {{ csrf_field() }}
  </form>

  @if(session('success'))
  <script>
    $(document).ready(function() {
      swal({
        title: "",
        text: "{!! session('success') !!}",
        type: "success",
        confirmButtonText: "Fermer"
      });     
    });			
		</script>
   @endif
   @if(session('error'))
   <script>    
    $(document).ready(function() {
      swal({
      title: "",
      text: "{!! session('error') !!}",
      type: "error",
      confirmButtonText: "Fermer"
    });
    });
  </script>
  @endif
  @if(session('warning'))
  <script>
  $(document).ready(function() {
      new PNotify({
        title: "Erreur!",
        type: "worning",
        text: "{!! session('warning') !!}",
        nonblock: {
          nonblock: true
        },
        addclass: 'dark',
        styling: 'bootstrap3'
      });
    });
   /*swal({
    title: "Watch out!",
    text: "{!! session('warning') !!}",
    type: "warning",
    confirmButtonText: "Okai"
  });*/
</script>
@endif
@if(session('info'))
<script>
 /*swal({
  title: "Watch out!",
  text: "{!! session('info') !!}",
  type: "info",
  confirmButtonText: "{{ trans('laralum.okai') }}"
});*/
$(document).ready(function() {
      new PNotify({
        title: "info",
        type: "worning",
        text: "{!! session('info') !!}",
        nonblock: {
          nonblock: true
        },
        addclass: 'dark',
        styling: 'bootstrap3'
      });
    });
</script>
@endif
@if (count($errors) > 0)
<script>
$(document).ready(function() {
 swal({
    title: "Erreur!",
    text: "<?php foreach($errors->all() as $error){ echo "$error<br>"; } ?>",
    type: "error",
    confirmButtonText: "Fermer",
    html: true
  });
 });
</script>
@endif




<div class="container body">
  <div class="main_container">
    <div class="col-md-3 left_col">
      <div class="left_col scroll-view">
        <div class="navbar nav_title" style="border: 0;">
          <a href="admin_index.html" class="site_title"><i class="fa fa-archive"></i> <span><b class="red">Ref</b> 'ARC</span></a>
        </div>

        <div class="clearfix"></div>

            <!-- menu profile quick info
            <div class="profile">
              <div class="profile_pic">
                <img src="images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Bonjour,</span>
                <h2>John Doe</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <!-- /menu profile quick info -->
            <br>
            <!-- sidebar menu -->
            <!--<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <ul class="nav side-menu">
                  <li><a href="javascript:;"><i class="fa fa-home"></i>Dashboard</a></li>
                  @if(Laralum::loggedInUser()->hasPermission('refarc.users.access'))
                          <li><a href="javascript:void(0)"><i class="fa fa-users"></i> {{ trans('laralum.user_manager') }} <span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                          <li><a href="{{ route('Laralum::users') }}" >{{ trans('laralum.user_list') }}</a></li>
                      @if(Laralum::loggedInUser()->hasPermission('refarc.users.create'))
                          <li><a href="{{ route('Laralum::users_create') }}">{{ trans('laralum.create_user') }}</a></li>
                      @endif
                      @if(Laralum::loggedInUser()->hasPermission('refarc.users.settings'))
                      <li><a href="{{ route('Laralum::users_settings') }}">{{ trans('laralum.users_settings') }}</a></li>
                      @endif
                  @endif
                    </ul>
                  </li>
                  @if(Laralum::loggedInUser()->hasPermission('refarc.projects.access'))
                          <li><a><i class="fa fa-user"></i> {{ trans('laralum.projects_list') }} <span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                          <li><a href="{{ route('Laralum::projects') }}">{{ trans('laralum.projects_list') }}</a></li>
                      @if(Laralum::loggedInUser()->hasPermission('refarc.projects.create'))
                          <li><a href="{{ route('Laralum::projects_create') }}" class="item">{{ trans('laralum.projects_create') }}</a></li>
                      @endif                      
                  @endif
                    </ul>
                  </li>

                  </ul>
              </div>

            </div>-->
            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <ul class="nav side-menu">
                  <li><a href="{{ route('Laralum::dashboard') }}"><i class="fa fa-home"></i>Tableau de bord</a>
                  </li>
                  <li><a><i class="fa fa-folder"></i>Projets<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{ route('Laralum::projects') }}"><i class="fa fa-list-ul"></i>Listes des DAH</a></li>
                      <li><a href="{{ route('Laralum::projects_create') }}"><i class="fa fa-plus"></i>Creer un nouveau DAH</a></li>  
                    </ul>
                  </li>
                  <li><a><i class="fa fa-users"></i>Utilisateurs<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{ route('Laralum::users') }}"><i class="fa fa-list-ul"></i>Listes des utilisateurs</a></li>
                      <li><a href="{{ route('Laralum::users_create') }}"><i class="fa fa-plus"></i>Creer un nouvel utilisateur</a></li>
                      <li><a href="{{ route('Laralum::users_settings') }}"><i class="fa fa-cogs"></i>Configuration</a></li> 
                    </ul>
                  </li>
                  @if(Laralum::loggedInUser()->hasPermission('refarc.roles.access'))
                  <li><a><i class="fa fa-tags"></i>Roles<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{ route('Laralum::roles') }}"><i class="fa fa-list-ul"></i>Listes des roles</a></li>
                      @if(Laralum::loggedInUser()->hasPermission('refarc.roles.create'))
                      <li><a href="{{ route('Laralum::roles_create') }}"><i class="fa fa-plus"></i>Creer un nouvel role</a></li>
                      @endif
                    </ul>
                  </li>
                  @endif
                  <li><a><i class="fa fa-toggle-on"></i>Permissions<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{ route('Laralum::permissions') }}"><i class="fa fa-list-ul"></i>Listes des permissions</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-newspaper-o"></i>Templates<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{ route('Laralum::templates') }}"><i class="fa fa-cogs"></i>Gestion du template</a></li>
                       <li><a href="{{ route('Laralum::fusion') }}"><i class="fa fa-filter"></i>Fusioner templates</a></li> 
                    </ul>
                  </li>
                </ul>
              </div>

            </div>
            <!-- /sidebar menu -->
          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav class="" role="navigation">
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-user"></i> {{ Auth::user()->name }}
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <li><a href="{{ route('Laralum::profile') }}">{{ trans('laralum.profile') }}</a></li>
                    <li>
                      <a href="{{ url('/logout') }}"
                      onclick="event.preventDefault();document.getElementById('logout-form').submit();">
                      <i class="fa fa-sign-out pull-right"></i>
                      {{ trans('laralum.logout') }}
                      
                    </a></li>
                  </ul>
                </li>

                <li role="presentation" class="dropdown">
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green">6</span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                    <li>
                      <a>

                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <a>
                        <span>
                          <span>John Smith</span>
                          <span class="time">3 mins ago</span>
                        </span>
                        <span class="message">
                          Film festivals used to be do-or-die moments for movie makers. They were where...
                        </span>
                      </a>
                    </li>
                    <li>
                      <div class="text-center">
                        <a>
                          <strong>See All Alerts</strong>
                          <i class="fa fa-angle-right"></i>
                        </a>
                      </div>
                    </li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col" role="main" style="min-height: 905px;">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>@yield('breadcrumb')</h3>
              </div>              
            </div>
            <div class="page-content">
              @yield('content')
            </div>
          </div>
        </div>
        <!-- /page content -->

        <!-- footer content -->
        
        <!-- /footer content -->
      </div>
    </div>

    



    @yield('js')



  </body>
  {!! Laralum::includeAssets('laralum_bottom') !!}
  </html>
