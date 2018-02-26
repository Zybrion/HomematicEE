<%@ page import="java.sql.Date" %><%--
  Created by IntelliJ IDEA.
  User: Rene
  Date: 11.02.2018
  Time: 01:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HomeMatic | Vorrat</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- DATA TABLES -->
    <link href="../plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="../dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />

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

    <%@include file="navigation_panel.jsp"%>

    <!-- =============================================== -->

    <!-- Right side column. Contains the navbar and content of the page -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Vorratsverwaltung
                <small>Verwalte deinen Vorrat</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i>Haushalt</a></li>
                <li class="active"> <a href="../show/watch_stock.html">Vorrat ansehen</a></li>
            </ol>
        </section>

        <%
            //Data for storagetype used below
            ResultSet resSetStock = null;


            HttpSession sess = request.getSession(false);
            String u_id_saved = "";
            String household_id = "";
            if (sess != null) {
                u_id = (String) sess.getAttribute("user_id");
                household_id = (String) sess.getAttribute("household_id");
                resSetStock = Database.GetDataFromDB("" +
                        "SELECT p.description, p.brand, c.bbd, t.description, t.category, c.amount, q.sign" +
                        " FROM stock_content c, product p, product_type t, quantity_unit q" +
                        " WHERE c.stock_id ='" + household_id + "' and c.product_id = p.id and p.product_type_id = t.id and p.quantity_unit_id = q.id;");

            }

        %>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">Vorratstabelle</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>Produkt</th>
                                    <th>Marke</th>
                                    <th>Mindesthaltbarkeitsdatum</th>
                                    <th>Produkttyp</th>
                                    <th>Produktkategorie</th>
                                    <th>Menge</th>
                                </tr>
                                </thead>
                                <tbody>

                                <%
                                    try{
                                        while(resSetStock.next()){
                                            String product;
                                            String brand;
                                            Date date;
                                            String type;
                                            String category;
                                            String amount_quant;
                                            if(resSetStock.getString(1) != null)
                                                product = resSetStock.getString(1);
                                            else product = "Error. Nicht verfügbar.";
                                            if(resSetStock.getString(2) != null)
                                                brand = resSetStock.getString(2);
                                            else brand = "Error. Nicht verfügbar.";
                                            if(resSetStock.getString(3) != null)
                                                date = resSetStock.getDate(3);
                                            else date = Date.valueOf("1990-01-01");
                                            if(resSetStock.getString(4) != null)
                                                type = resSetStock.getString(4);
                                            else type = "Error. Nicht verfügbar.";
                                            if(resSetStock.getString(5) != null)
                                                category = resSetStock.getString(5);
                                            else category = "Error. Nicht verfügbar.";
                                            if(resSetStock.getString(6) != null && resSetStock.getString(7) != null)
                                                amount_quant = "" + resSetStock.getDouble(6) + resSetStock.getString(7);
                                            else amount_quant = "Error. Nicht verfügbar.";



                                            out.println("<tr>");
                                            out.println("<td>" + product + "</td>");
                                            out.println("<td>" + brand + "</td>");
                                            out.println("<td>" + date + "</td>");
                                            out.println("<td>" + type + "</td>");
                                            out.println("<td>" + category + "</td>");
                                            out.println("<td>" + amount_quant + "</td>");
                                            out.println("</tr>");
                                        }
                                    }catch(Exception e){}
                                %>
                                </tbody>
                                <tfoot>
                                <tr>
                                    <th>Produkt</th>
                                    <th>Marke</th>
                                    <th>Mindesthaltbarkeitsdatum</th>
                                    <th>Produkttyp</th>
                                    <th>Produktkategorie</th>
                                    <th>Menge</th>
                                </tr>
                                </tfoot>
                            </table>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->
            </div><!-- /.row -->
        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->
<%@include file="footer.jsp"%>;

<!-- jQuery 2.1.3 -->
<script src="../plugins/jQuery/jQuery-2.1.3.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- SlimScroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src='../plugins/fastclick/fastclick.min.js'></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js" type="text/javascript"></script>
<!-- DATA TABES SCRIPT -->
<script src="../plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
<script src="../plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js" type="text/javascript"></script>

<!-- page script -->
<script type="text/javascript">
    $(function () {
        $("#example1").dataTable();
        $('#example2').dataTable({
            "bPaginate": true,
            "bLengthChange": false,
            "bFilter": false,
            "bSort": true,
            "bInfo": true,
            "bAutoWidth": false
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#main_treeview").removeClass("active");
        $('#manage_stock_treeview').addClass('active');
        $('#watch_stock_id').addClass('active');
    });
</script>
</body>
</html>