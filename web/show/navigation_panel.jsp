<%--
  Created by IntelliJ IDEA.
  User: Rene
  Date: 14.02.2018
  Time: 21:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.homematic.Database" %>
<%@ page import="java.sql.ResultSet" %>
<%
    ResultSet rs2 = null;

    HttpSession session2 = request.getSession(false);
    String u_id2 = "";
    if (session2 != null) {
        u_id2 = (String) session2.getAttribute("user_id");
    }

    String name2 = null;

    rs2 = Database.GetDataFromDB("SELECT name, firstname FROM user WHERE id='" + u_id2 + "';");
    if (rs2.next()) {
        name2 = rs2.getString(2) + " " + rs2.getString(1);
    }
    Database.CloseConnection();

%>

<html>
<head>
    <title></title>
</head>
<body>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="../../dist/img/user2-160x160.jpg" class="img-circle" alt="User Image"/>
            </div>
            <div class="pull-left info">

                <p><%out.println(name2);%></p>

                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search..."/>
                <span class="input-group-btn">
                <button type='submit' name='search' id='search-btn' class="btn btn-flat"><i
                        class="fa fa-search"></i></button>
              </span>
            </div>
        </form>
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header">Hauptnavigation</li>

            <li class="active treeview">
                <a href="/show/manage_stock.jsp">
                    <i class="fa fa-home"></i> <span>Haushalt</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/show/manage_stock.jsp"><i class="fa fa-circle-o"></i> Lagerort verwalten</a></li>
                    <li><a href="/show/manage_user.jsp"><i class="fa fa-circle-o"></i> Haushaltsmitglieder
                        verwalten</a></li>
                    <li><a href="/show/costs.jsp"><i class="fa fa-circle-o"></i> Kostenübersicht
                    </a></li>
                </ul>
            </li>

            <!-- Eigener Speiseplan -->
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-cutlery"></i> <span>Speiseplan</span> <i class="fa pull-right"></i>
                </a>


            </li>

            <!-- Eigene Vorrat -->
            <li class="treeview">
                <a href="/show/manage_stock.jsp">
                    <i class="fa fa-beer"></i> <span>Vorrat</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li class="active"><a href="/show/manage_stock.jsp"><i class="fa fa-circle-o"></i> Vorrat
                        verwalten</a></li>
                </ul>
            </li>

            <!-- Eigene Rezepte -->
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-beer"></i> <span>Rezepte</span> <i class="fa fa-angle-left pull-right"></i>
                </a>
                <ul class="treeview-menu">
                    <li><a href="/show/manage_recipe.jsp"><i class="fa fa-circle-o"></i> Rezept verwalten</a></li>
                    <li class="active"><a href="/show/create_recipe.jsp"><i class="fa fa-circle-o"></i> Rezept
                        erstellen</a></li>
                </ul>
            </li>

            <!-- Eigene Einkaufsliste -->
            <li class="treeview">
                <a href="/show/shopping_list.html">
                    <i class="fa fa-shopping-cart"></i> <span>Einkaufsliste</span> <i class="fa pull-right"></i>
                </a>
            </li>

            <!-- Eigene Kostenübersicht
            <li class="treeview">
                <a href="show/costs.jsp">
                    <i class="fa fa-money"></i> <span>Kostenübersicht</span> <i class="fa pull-right"></i>
                </a>
            </li>
            -->

            <li class="header">HomeMatic</li>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
</body>
</html>
