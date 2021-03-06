<%--
  Created by IntelliJ IDEA.
  User: Rene
  Date: 14.02.2018
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //Data for storagetype used below
    ResultSet resSetShoppingList = null;


    HttpSession sess = request.getSession(false);
    String u_id_saved = "";
    String household_id = "";
    if (sess != null) {
        u_id_saved = (String) sess.getAttribute("user_id");
        household_id = (String) sess.getAttribute("household_id");
        resSetShoppingList = Database.GetDataFromDB("SELECT p.description, p.brand, qu.description, pt.description, scp.shopping_cart_id, scp.amount " +
                " FROM shopping_cart s, shopping_cart_pos scp, product p, product_type pt, quantity_unit qu " +
                " WHERE s.household_id='" + household_id + "' AND s.id = scp.shopping_cart_id AND scp.product_type_id = pt.id AND scp.product_id = p.id AND qu.id = scp.quantity_unit_id");
    }

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Homematic | Einkaufsliste</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="../dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="../plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="skin-blue fixed">
<!-- Site wrapper -->
<div class="wrapper">

    <%@include file="header.jsp"%>

    <!-- =============================================== -->

    <!-- Left side column. contains the sidebar -->
    <%@include file="navigation_panel.jsp"%>

    <!-- =============================================== -->

    <!-- Right side column. Contains the navbar and content of the page -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Einkaufsliste
                <small>Alles, was man braucht.</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/index.html"><i class="fa fa-dashboard"></i>Haushalt</a></li>
                <li class="active"><a href="../show/shopping_list.html">Einkaufsliste</a></li>
            </ol>
        </section>

        <!-- TO DO List -->
        <div class="box box-primary">
            <div class="box-header">
                <i class="ion ion-clipboard"></i>
                <h3 class="box-title">Einkaufsliste</h3>
                <div class="box-tools pull-right">
                    <ul class="pagination pagination-sm inline">
                        <li><a href="#">&laquo;</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </div>
            </div><!-- /.box-header -->
            <div class="box-body">
                <ul class="todo-list">
                    <%
                        try{
                            while(resSetShoppingList.next()){
                                out.println("<li> <span class='handle'><i class='fa fa-ellipsis-v'></i>");
                                out.println("<i class='fa fa-ellipsis-v'></i></span>");
                                out.println("<input type='checkbox' value='' name='" + resSetShoppingList.getString(5) + "' />");
                                out.println("<span class='text'>" + resSetShoppingList.getString(1) + " | " + resSetShoppingList.getString(2) + " | " + resSetShoppingList.getString(6) + " " + resSetShoppingList.getString(3) + "</span>");
                                out.println("<div class='tools'> <i class='fa fa-edit'></i> <i class='fa fa-trash-o'></i> </div> </li>");
                            }
                            resSetShoppingList.beforeFirst();
                        } catch(Exception e){}
                    %>
                </ul>
            </div><!-- /.box-body -->
            <div class="box-footer clearfix no-border">
                <button class="btn btn-default pull-right"><i class="fa fa-plus"></i> Add item</button>
            </div>
        </div><!-- /.box -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<%@ include file="footer.jsp" %>
<!-- jQuery 2.1.3 -->
<script src="../plugins/jQuery/jQuery-2.1.3.min.js"></script>
<!-- jQuery UI 1.11.2 -->
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.min.js" type="text/javascript"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- SlimScroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src='../plugins/fastclick/fastclick.min.js'></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js" type="text/javascript"></script>


<!-- Dragfeature -->
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../dist/js/pages/shopping_list.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="../plugins/iCheck/icheck.min.js" type="text/javascript"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js" type="text/javascript"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#main_treeview").removeClass("active");
        $('#shopping_list_treeview').addClass('active');

    });
</script>
</body>
</html>