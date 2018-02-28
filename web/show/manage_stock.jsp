<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
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
    <title>AdminLTE 2 | Dashboard</title>
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
                <li><a href="/index.html"><i class="fa fa-dashboard"></i> Haushalt</a></li>
                <li class="active"><a href="../show/manage_stock.html">Vorrat verwalten</a></li>
            </ol>
        </section>

        <%
            //Data for storagetype used below
            ResultSet resSetStock = null;
            ResultSet resSetQuant = null;


            HttpSession sess = request.getSession(false);
            String u_id_saved = "";
            String household_id = "";
            if (sess != null) {
                u_id = (String) sess.getAttribute("user_id");
                household_id = (String) sess.getAttribute("household_id");
                resSetStock = Database.GetDataFromDB("" +
                        "SELECT p.description, p.brand, c.bbd, t.description, t.category, c.amount, q.sign, c.id, q.id" +
                        " FROM stock_content c, product p, product_type t, quantity_unit q" +
                        " WHERE c.stock_id ='" + household_id + "' and c.product_id = p.id and p.product_type_id = t.id and p.quantity_unit_id = q.id;");
                resSetQuant = Database.GetDataFromDB("SELECT id, description FROM quantity_unit");
            }

        %>

        <!-- Main content -->
        <section class="content">
            <div class="row">

                <!-- Erstellung der Container mit Inhalt aller Lagerorte -->
                <%

                    out.println("<div class='col-md-4'>");
                    out.println("<div class='box box-success'>");
                    out.println("<div class='box-header'>");
                    out.println("<h3 class='box-title'>Neues Produkt</h3>");
                    out.println("</div><!-- /.box-header -->");
                    out.println("<form role='form' action='changeProduct' method='post'>");
                    out.println("<div class='box-body'>");
                    //Productname
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Produktname</label>");
                    out.println("<input type='text' class='form-control' placeholder='Name' name='product_name' value=''>");
                    out.println("</div>");
                    //Hidden Stock_Cont_ID
                    out.println(" <div class='form-group'>");
                    out.println("<input type='hidden' class='form-control' name='stock_cont_id' value=''>");
                    out.println("</div>");
                    //Brand name
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Marke</label>");
                    out.println("<input type='text' class='form-control' placeholder='Marke' name='brand' value=''>");
                    out.println("</div>");
                    //Best before date
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Mindesthaltbarkeitsdatum</label>");
                    out.println("<input type='date' class='form-control' placeholder='Marke' name='bbd' value=''>");
                    out.println("</div>");
                    //Producttype
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Produkttyp</label>");
                    out.println("<input type='text' class='form-control' placeholder='Marke' name='product_type' value=''>");
                    out.println("</div>");
                    //Product category
                    //Producttype
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Produktkategorie</label>");
                    out.println("<input type='text' class='form-control' placeholder='Marke' name='cat_type' value=''>");
                    out.println("</div>");
                    //Amount
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Menge</label>");
                    out.println("<input type='text' class='form-control' placeholder='Marke' name='amount' value=''>");
                    out.println("</div>");
                    //Einheit
                    out.println(" <div class='form-group'>");
                    out.println("<label for='storage_name'>Einheit</label>");
                    out.println("<select class='form-control' name='quant_id' required>");

                    try {
                        while (resSetQuant.next()){
                            out.println("<option value='" + resSetQuant.getInt(1) + "'>" + resSetQuant.getString(2) + "</option>");
                        }
                        resSetQuant.beforeFirst();
                    } catch(Exception e){}
                    out.println("</select>");
                    out.println("</div>");

                    out.println("</div>");
                    out.println("<div class='box-footer'>");
                    out.println("<button type='submit' class='btn btn-success' name='product_create'>Erstellen</button>");
                    out.println("</div>");
                    out.println("</form>");
                    out.println("</div><!-- /.box -->");
                    out.println("</div>");
                %>

                <!-- left column -->
                <div class="col-md-4">
                    <!-- general form elements -->
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Verwalte ein bestehendes Produkt</h3>
                        </div><!-- /.box-header -->
                        <!-- form start -->
                        <form role="form" method="post" action='createStorage'>
                            <div class="box-body">
                                <div class="form-group">
                                    <label>Produkt</label>
                                    <select class="form-control" name="storage_type" required name="storage_type">
                                        <%
                                            try{
                                                String product;
                                                Date date;
                                                String amount_quant;
                                                String stock_cont_id;
                                                while(resSetStock.next()) {

                                                    if (resSetStock.getString(1) != null)
                                                        product = resSetStock.getString(1);
                                                    else product = "Error. Nicht verfügbar.";
                                                    if (resSetStock.getString(3) != null) {
                                                        date = resSetStock.getDate(3);
                                                    }
                                                    else date = Date.valueOf("1990-01-01");
                                                    if (resSetStock.getString(6) != null && resSetStock.getString(7) != null)
                                                        amount_quant = "" + resSetStock.getDouble(6) + resSetStock.getString(7);
                                                    else amount_quant = "Error. Nicht verfügbar.";
                                                    if(resSetStock.getString(8) != null)
                                                        stock_cont_id = "" + resSetStock.getString(8);
                                                    else stock_cont_id = "Error. Nicht verfügbar.";


                                                    out.println("<option value='" + stock_cont_id + "'>" + product + " | " + date + " | " + amount_quant + "</option>");
                                                }
                                                resSetStock.beforeFirst();
                                            }catch(Exception e){}
                                        %>
                                    </select>
                                </div>
                            </div><!-- /.box-body -->

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary" name="storage_create" id="storage_create_button">Verwalten</button>
                            </div>
                        </form>
                    </div><!-- /.box -->
                </div>

                <div class="col-md-4">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <i class="fa fa-bullhorn"></i>
                            <h3 class="box-title">Information</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <div class="callout callout-info">
                                <h4>Produkt erstellen</h4>
                                <p>Um einen Produkt zu erstellen, fülle bitte das Formular 'Erstelle ein Produkt' aus.
                                    Anschließend drückst du auf den Button 'Erstellen'.
                                </p>
                            </div>
                            <div class="callout callout-info">
                                <h4>Produkt bearbeiten</h4>
                                <p>Bitte wähle ein Produkt aus dem Menü aus und drücke auf "Bearbeiten".
                                </p>
                            </div>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->
            </div>

            <div class="row">
                <!-- Erstellung der Container mit Inhalt aller Produkte -->
                <%
                    try{
                        while(resSetStock.next()){

                            String product;
                            String brand;
                            Date date;
                            String type;
                            String category;
                            String amount;
                            String quant;
                            String stock_cont_id;
                            String quant_id;
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
                            if(resSetStock.getString(6) != null)
                                amount = "" + resSetStock.getDouble(6);
                            else amount = "Error. Nicht verfügbar.";
                            if(resSetStock.getString(7) != null)
                                quant = "" + resSetStock.getString(7);
                            else quant = "Error. Nicht verfügbar.";
                            if(resSetStock.getString(8) != null)
                                stock_cont_id = "" + resSetStock.getString(8);
                            else stock_cont_id = "Error. Nicht verfügbar.";
                            if(resSetStock.getString(9) != null)
                                quant_id = "" + resSetStock.getString(9);
                            else quant_id = "Error. Nicht verfügbar.";



                            out.println("<div class='col-md-2'>");
                            out.println("<div class='box box-success'>");
                            out.println("<div class='box-header'>");
                            out.println("<h3 class='box-title'>Dein Produkt</h3>");
                            out.println("</div><!-- /.box-header -->");
                            out.println("<form role='form' action='createProduct' method='post'>");
                            out.println("<div class='box-body'>");
                            //Productname
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Produktname</label>");
                            out.println("<input type='text' class='form-control' placeholder='Name' name='product_name' value='"+ product + "' required>");
                            out.println("</div>");
                            //Hidden Stock_Cont_ID
                            out.println(" <div class='form-group'>");
                            out.println("<input type='hidden' class='form-control' name='stock_cont_id' value='"+ stock_cont_id + "' required>");
                            out.println("</div>");
                            //Brand name
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Marke</label>");
                            out.println("<input type='text' class='form-control' placeholder='Marke' name='brand' value='"+ brand + "' required>");
                            out.println("</div>");
                            //Best before date
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Mindesthaltbarkeitsdatum</label>");
                            out.println("<input type='date' class='form-control' placeholder='Datum' name='bbd' value='"+ date + "' required>");
                            out.println("</div>");
                            //Producttype
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Produkttyp</label>");
                            out.println("<input type='text' class='form-control' placeholder='Typ' name='product_type' value='"+ type + "' required>");
                            out.println("</div>");
                            //Product category
                            //Producttype
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Produktkategorie</label>");
                            out.println("<input type='text' class='form-control' placeholder='Kategorie' name='cat_type' value='"+ category + "' required>");
                            out.println("</div>");
                            //Amount
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Menge</label>");
                            out.println("<input type='text' class='form-control' placeholder='Menge' name='amount' value='"+ amount + "' required>");
                            out.println("</div>");
                            //Einheit
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Einheit</label>");
                            out.println("<select class='form-control' name='quant_id' required>");

                            try {
                                while (resSetQuant.next()){
                                    String gen_quant = resSetQuant.getString(1);
                                    String sel = "";
                                    if(quant_id.equals(gen_quant)){
                                        sel = "selected";
                                    }
                                    out.println("<option value='" + gen_quant + "'" + sel + ">" + resSetQuant.getString(2) + "</option>");
                                    sel = "";
                                }
                                resSetQuant.beforeFirst();
                            } catch(Exception e){}
                            out.println("</select>");
                            out.println("</div>");

                            out.println("</div>");
                            out.println("<div class='box-footer'>");
                            out.println("<button type='submit' class='btn btn-primary' name='product_change'>Ändern</button>");
                            out.println("<button type='submit' class='btn btn-danger' name='product_delete'>Löschen</button>");
                            out.println("</div>");
                            out.println("</form>");
                            out.println("</div><!-- /.box -->");
                            out.println("</div>");
                        }
                        resSetStock.beforeFirst();
                    }catch(Exception e){}
                %>
            </div>

            <div class="row" id="storage_display_container">

            </div>
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
        $('#manage_stock_id').addClass('active');
    });
</script>
</body>
</html>