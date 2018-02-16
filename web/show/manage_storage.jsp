<%--
  Created by IntelliJ IDEA.
  User: Rene
  Date: 16.02.2018
  Time: 13:42
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
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="../../dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="skin-blue">
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
                Blank page
                <small>it all starts here</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li><a href="#">Examples</a></li>
                <li class="active">Blank page</li>
            </ol>
        </section>

        <%
            //Data for storagetype used below
            ResultSet resSetStorageType = null;
            ResultSet resSetHouseholdNmb = null;
            ResultSet resSetStorage = null;

            HttpSession sess = request.getSession(false);
            String u_id_saved = "";
            if (sess != null) {
                u_id_saved = (String) sess.getAttribute("user_id");
            }

            resSetStorageType = Database.GetDataFromDB("SELECT id, description FROM storage_type ORDER BY id;");
            resSetHouseholdNmb = Database.GetDataFromDB("Select household_id FROM user WHERE id='" + u_id_saved + "';");
            int hhn;
            try {
                if(resSetHouseholdNmb.next()){
                    hhn = resSetHouseholdNmb.getInt(1);
                    resSetStorage = Database.GetDataFromDB("SELECT id, description, household_id, storage_type_id FROM storage where household_id='" + hhn + "';");
                }
            }catch(Exception e){}

        %>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <!-- left column -->
                <div class="col-md-6">
                    <!-- general form elements -->
                    <div class="box box-primary">
                        <div class="box-header">
                            <h3 class="box-title">Erstelle einen Lagerort</h3>
                        </div><!-- /.box-header -->
                        <!-- form start -->
                        <form role="form" method="post" action='createStorage'>
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="storage_name">Lagerortname</label>
                                    <input type="text" class="form-control" id="storage_name" placeholder="Name" name="storage_name" value="" required>
                                </div>
                                <div class="form-group">
                                    <label>Lagertyp</label>
                                    <select class="form-control" name="storage_type" required name="storage_type">
                                        <%
                                            try{
                                                while(resSetStorageType.next()){
                                                    out.println("<option value='" + resSetStorageType.getInt(1) + "'>" + resSetStorageType.getString(2) + "</option>");
                                                }
                                                resSetStorageType.beforeFirst();
                                            }catch(Exception e){}
                                        %>
                                    </select>
                                </div>
                            </div><!-- /.box-body -->

                            <div class="box-footer">
                                <button type="submit" class="btn btn-primary" name="storage_create" id="storage_create_button")">Erstellen</button>
                            </div>
                        </form>
                    </div><!-- /.box -->
                </div>

                <div class="col-md-6">
                    <div class="box box-default">
                        <div class="box-header with-border">
                            <i class="fa fa-bullhorn"></i>
                            <h3 class="box-title">Information</h3>
                        </div><!-- /.box-header -->
                        <div class="box-body">
                            <div class="callout callout-info">
                                <h4>Allgemeine Information</h4>
                                <p>Dein gesamter Vorrat besteht aus einem oder mehreren Lagerorten. Ein Beispiel für einen solchen Lagerort
                                    ist eine 'Speisekammer' als Trockenlager oder auch der 'Kühlschrank' als Kühllager. Dabei kannst du den Lagerortname selbst bestimmen!
                                </p>
                            </div>
                            <div class="callout callout-info">
                                <h4>Lagerort erstellen</h4>
                                <p>Um einen Lagerort zu erstellen, fülle bitte das Formular 'Erstelle einen Lagerort' aus.
                                    Anschließend drückst du auf den Button 'Erstellen'.
                                </p>
                            </div>
                        </div><!-- /.box-body -->
                    </div><!-- /.box -->
                </div><!-- /.col -->

            </div>
            <div class="row">
                <!-- Erstellung der Container mit Inhalt aller Lagerorte -->
                <%
                    try{
                        while(resSetStorage.next()){
                            String storageName = resSetStorage.getString(2);
                            String storageTypeName;
                            int storageTypeValue;
                            int storageID = resSetStorage.getInt(1);
                            switch(resSetStorage.getInt(4)){
                                case 1:
                                    resSetStorageType.next();
                                    storageTypeName = resSetStorageType.getString(2);
                                    storageTypeValue = resSetStorageType.getInt(1);
                                    resSetStorageType.beforeFirst();
                                    break;
                                case 2:
                                    resSetStorageType.next();
                                    resSetStorageType.next();
                                    storageTypeName = resSetStorageType.getString(2);
                                    storageTypeValue = resSetStorageType.getInt(1);
                                    resSetStorageType.beforeFirst();
                                    break;
                                case 3:
                                    resSetStorageType.next();
                                    resSetStorageType.next();
                                    resSetStorageType.next();
                                    storageTypeName = resSetStorageType.getString(2);
                                    storageTypeValue = resSetStorageType.getInt(1);
                                    resSetStorageType.beforeFirst();
                                    break;
                                default:
                                    resSetStorageType.beforeFirst();
                                    storageTypeName = "Unavailable";
                                    storageTypeValue = -1;
                            }

                            out.println("<div class='col-md-4'>");
                            out.println("<div class='box box-success'>");
                            out.println("<div class='box-header'>");
                            out.println("<h3 class='box-title'>Dein Lagerort</h3>");
                            out.println("</div><!-- /.box-header -->");
                            out.println("<form role='form' action='createStorage' method='post'>");
                            out.println("<div class='box-body'>");
                            out.println(" <div class='form-group'>");
                            out.println("<label for='storage_name'>Lagerortname</label>");
                            out.println("<input type='text' class='form-control' placeholder='Name' name='storage_name' value='"+ storageName + "')>");
                            out.println("</div>");

                            out.println(" <div class='form-group'>");
                            out.println("<input type='hidden' class='form-control' name='hid_name' value='"+ storageID + "')>");
                            out.println("</div>");

                            out.println("<div class='form-group'>");
                            out.println("<label>Lagertyp</label>");
                            out.println("<select class='form-control' name='storage_type' required>");
                                try{
                                    while(resSetStorageType.next()){
                                        String sel = "";
                                        if(storageTypeValue == resSetStorageType.getInt(1)){
                                            sel = "selected";
                                        }
                                        out.println("<option value='" + resSetStorageType.getInt(1) + "' " + sel + ">" + resSetStorageType.getString(2) + "</option>");
                                        sel = "";
                                    }
                                    resSetStorageType.beforeFirst();
                                }catch(Exception e){}

                            out.println("</select>");
                            out.println("</div>");
                            out.println("</div>");
                            out.println("<div class='box-footer'>");
                            out.println("<button type='submit' class='btn btn-primary' name='storage_change'>Ändern</button>");
                            out.println("<button type='submit' class='btn btn-danger' name='storage_delete'>Löschen</button>");
                            out.println("</div>");
                            out.println("</form>");
                            out.println("</div><!-- /.box -->");
                            out.println("</div>");
                        }
                        resSetStorage.beforeFirst();
                    }catch(Exception e){}
                %>
            </div>

            <div class="row" id="storage_display_container">

            </div>
        </section>
    </div><!-- /.content-wrapper -->
</div><!-- ./wrapper -->

<%@include file="footer.jsp"%>
<!-- jQuery 2.1.3 -->
<script src="../../plugins/jQuery/jQuery-2.1.3.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="../../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- SlimScroll -->
<script src="../../plugins/slimScroll/jquery.slimScroll.min.js" type="text/javascript"></script>
<!-- FastClick -->
<script src='../../plugins/fastclick/fastclick.min.js'></script>
<!-- AdminLTE App -->
<script src="../../dist/js/app.min.js" type="text/javascript"></script>
</body>
</html>