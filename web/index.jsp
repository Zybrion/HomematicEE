
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <meta charset="UTF-8">
    <title>AdminLTE 2 | Dashboard</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- FontAwesome 4.3.0 -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet"
          type="text/css"/>
    <!-- Ionicons 2.0.0 -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css"/>
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css"/>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css"/>
    <!-- iCheck -->
    <link href="plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css"/>
    <!-- Morris chart -->
    <link href="plugins/morris/morris.css" rel="stylesheet" type="text/css"/>
    <!-- jvectormap -->
    <link href="plugins/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css"/>--%>
    <!-- Date Picker -->
    <link href="plugins/datepicker/datepicker3.css" rel="stylesheet" type="text/css"/>
    <!-- Daterange picker -->
    <link href="plugins/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css"/>
    <!-- bootstrap wysihtml5 - text editor -->
    <link href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="skin-blue fixed">
<div class="wrapper">

    <!-- Einbindung des Headers -->
    <%@ include file="show/header.jsp"%>
    <!-- Left side column. contains the logo and sidebar -->

    <!-- Einbindung der Navigationsleiste auf der linken Seite -->
        <%@include file="show/navigation_panel.jsp"%>

    <!-- Right side column. Contains the navbar and content of the page -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Haushaltsübersicht
                <small>Dein Zuhause</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/index.html"><i class="fa fa-dashboard"></i> Haushalt</a></li>
                <!--<li class="active"><a href="/index.html">Haushalt</a></li>    -->
            </ol>
        </section>

        <%
            //Data for storagetype used below
            ResultSet resSetShoppingList = null;
            ResultSet resSetUser = null;
            ResultSet resSetStock = null;
            ResultSet resSetRecipe = null;

            HttpSession sess = request.getSession(false);
            String u_id_saved = "";
            String household_id = "";
            if (sess != null) {
                u_id = (String) sess.getAttribute("user_id");
                household_id = (String) sess.getAttribute("household_id");
                resSetShoppingList = Database.GetDataFromDB("SELECT scp.shopping_cart_id from shopping_cart_pos scp, shopping_cart sc " +
                        "WHERE sc.household_id ='" + household_id + "' AND sc.shopping_cart_pos = scp.shopping_cart_id");
                resSetUser = Database.GetDataFromDB("SELECT id FROM user where household_id='" + household_id + "'");
                resSetStock = Database.GetDataFromDB("SELECT sc.id FROM stock_content sc, stock s where s.household_id='" + household_id + "' AND sc.stock_id = s.id");
                resSetRecipe = Database.GetDataFromDB("SELECT distinct r.id from recipe r WHERE r.household_id ='" + household_id + "'");
               /* int shoppingListEntrys = 0;
                try {
                    resSetShoppingList.last();
                    shoppingListEntrys = resSetShoppingList.getRow();
                    resSetShoppingList.beforeFirst();

                }catch(Exception e) {}

                int user_household_entrys = 0;
                try {
                    resSetUser.last();
                    user_household_entrys = resSetUser.getRow();
                    resSetUser.beforeFirst();
                } catch (Exception e) {}

                int stock_entrys = 0;
                try {
                    resSetStock.last();
                    stock_entrys = resSetStock.getRow();
                    resSetStock.beforeFirst();
                } catch (Exception e) {}
                int recipe_entrys = 0;
                try {
                    resSetRecipe.last();
                    recipe_entrys = resSetRecipe.getRow();
                    resSetRecipe.beforeFirst();
                }catch(Exception e){}*/
            }

        %>

        <!-- Main content -->
        <section class="content">
            <!-- Small boxes (Stat box) -->
            <div class="row">
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-aqua">
                        <div class="inner">
                            <h3><%int shoppingListEntrys = 0;
                                try {
                                    resSetShoppingList.last();
                                    shoppingListEntrys = resSetShoppingList.getRow();
                                    resSetShoppingList.beforeFirst();

                                }catch(Exception e) {}

                                out.println(shoppingListEntrys); %></h3>
                            <p>Einträge in der Einkaufsliste</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-bag"></i>
                        </div>
                        <a href="/show/shopping_list.html" class="small-box-footer">Mehr Informationen <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div><!-- ./col -->
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-green">
                        <div class="inner">
                            <h3><%
                                int stock_entrys = 0;
                                try {
                                    resSetStock.last();
                                    stock_entrys = resSetStock.getRow();
                                    resSetStock.beforeFirst();
                                } catch (Exception e) {}
                                out.println(stock_entrys);
                            %></h3>
                            <p>Gegenstände im Vorrat</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-stats-bars"></i>
                        </div>
                        <a href="/show/watch_stock.html" class="small-box-footer">Mehr Informationen <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div><!-- ./col -->
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-yellow">
                        <div class="inner">
                            <h3><% int user_household_entrys = 0;
                                try {
                                    resSetUser.last();
                                    user_household_entrys = resSetUser.getRow();
                                    resSetUser.beforeFirst();
                                } catch (Exception e) {}
                                out.println(user_household_entrys);
                            %></h3>
                            <p>Haushaltsmitglieder</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-person-add"></i>
                        </div>
                        <a href="/show/manage_user.html" class="small-box-footer">Mehr Informationen <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div><!-- ./col -->
                <div class="col-lg-3 col-xs-6">
                    <!-- small box -->
                    <div class="small-box bg-red">
                        <div class="inner">
                            <h3><%
                                int recipe_entrys = 0;
                                try {
                                    resSetRecipe.last();
                                    recipe_entrys = resSetRecipe.getRow();
                                    resSetRecipe.beforeFirst();
                                }catch(Exception e){}
                                out.println(recipe_entrys);
                            %></h3>
                            <p>Einzelne Rezepte</p>
                        </div>
                        <div class="icon">
                            <i class="ion ion-pie-graph"></i>
                        </div>
                        <a href="/show/manage_recipe.html" class="small-box-footer">Mehr Informationen <i class="fa fa-arrow-circle-right"></i></a>
                    </div>
                </div><!-- ./col -->
            </div><!-- /.row -->

            <!-- Main row -->
            <div class="row">
                <!-- Left col -->
                <div class="col-md-4">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <i class="fa fa-bullhorn"></i>
                            <h3 class="box-title">Grundlegende Informationen</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <div class="callout callout-info">
                                <h4>Ersteinrichtung</h4>
                                <p><b>Glückwunsch!</b> Der die erste Hürde wurde bewältigt. Hier einige kleine Informationen: Ihr Vorrat besteht aus einem oder mehreren Lagerorten.
                                    Diesen können sie in der linken Menüleiste unter <b>"Haushalt -> Lagerort verwalten"</b> erstellen.
                                </p>
                                <p>
                                    Anschließend können Produkte diesem Lagerort hinzugefügt werden.
                                    Nun benötigen Sie nur noch ein paar Rezepte und schon generieren wir vollautomatisch aufgrund ihres vorhandenen Lagerbestands und ihren definierten Rezepten
                                    einen Speiseplan.
                                </p>
                                <p>
                                    Die Produkte können Sie unter <b>"Vorrat -> Vorrat verwalten"</b> erstellen und die Rezepte unter <b>"Rezepte -> Rezepte Verwalten"</b>.
                                </p>
                            </div>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->

                <div class="col-md-4">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <i class="fa fa-bullhorn"></i>
                            <h3 class="box-title">Information</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <div class="callout callout-info">
                                <h4>Vielen Dank</h4>
                                <p>Wir bedanken uns für die Nutzung von <b>Homematic</b> und wünschen ihnen viele abwechslungsreiche Mahlzeiten.
                                    Dabei werden <b>keine Vorräte verschwendet</b> und somit weniger Geld in die Tonne geworfen.
                                </p>
                                <p>
                                    Falls Sie Feedback für uns haben, erreichen Sie uns unter <b>info@homematic.online</b>.
                                </p>
                            </div>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->



            </div><!-- /.content-wrapper -->
    </div><!-- ./wrapper -->

    <!-- Einbindung des Footers -->
        <%@ include file="show/footer.jsp"%>

    <!-- jQuery 2.1.3 -->
    <script src="../../plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <!-- jQuery UI 1.11.2 -->
    <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
        $.widget.bridge('uibutton', $.ui.button);
    </script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <%--    <!-- Morris.js charts -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="plugins/morris/morris.min.js" type="text/javascript"></script>--%>
    <!-- Sparkline -->
    <script src="plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
     <!-- jvectormap -->
     <script src="../../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
     <script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
     <!-- jQuery Knob Chart -->
     <script src="plugins/knob/jquery.knob.js" type="text/javascript"></script>
    <!-- daterangepicker -->
    <script src="plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
    <!-- datepicker -->
    <script src="plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <!-- Slimscroll -->
    <script src="plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <!-- FastClick -->
    <script src='plugins/fastclick/fastclick.min.js'></script>
    <!-- AdminLTE App -->
    <script src="dist/js/app.min.js" type="text/javascript"></script>

    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
    <script src="dist/js/pages/dashboard.js" type="text/javascript"></script>

    <!-- AdminLTE for demo purposes -->
    <script src="dist/js/demo.js" type="text/javascript"></script>

</body>
</html>