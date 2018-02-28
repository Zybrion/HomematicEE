<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.ZonedDateTime" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.lang.*" %>
<%--

  Created by IntelliJ IDEA.
  User: Rene
  Date: 17.02.2018
  Time: 00:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    //Loading Data for Calendar
    //Data for storagetype used below
    ResultSet resSetMeals = null;

    HttpSession sess = request.getSession(false);
    String u_id_saved = "";
    String household_id = "";
    if (sess != null) {
        u_id_saved = (String) sess.getAttribute("user_id");
        household_id = (String) sess.getAttribute("household_id");

        resSetMeals = Database.GetDataFromDB("SELECT distinct m.id, m.recipe_id, m.date, m.daytime_id, r.description, d.description FROM meal m, recipe r, daytime d WHERE m.household_id='" + household_id + "' and m.recipe_id = r.id and m.daytime_id = d.id ORDER BY m.date asc, m.daytime_id asc");
    }



%>

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
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link href="../dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- fullCalendar 2.2.5-->
    <link href="../plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
    <link href="../plugins/fullcalendar/fullcalendar.print.css" rel="stylesheet" type="text/css" media='print' />

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
            <h1>Speiseplan
                <small>Die Übersicht über die Mahlzeiten</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="/index.html"><i class="fa fa-dashboard"></i>Haushalt</a></li>
                <li class="active"><a href="meal_plan.html">Speiseplan</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row>"
                <div class="col-md-12">
                    <div class="box box-success">
                        <div class="box-header">
                            <h3 class='box-title'>Menüplan erstellen</h3>
                        </div>
                            <form role='form' action='redirect_meal_plan' method='post'>
                                <div class='box-footer'>
                                    <input type="text" hidden name="from_date" value="<%
                                    out.println(LocalDateTime.now().toString().substring(0,10));%>"></input>
                                    <input type="text" hidden name="to_date" value="<%
                                    out.println(LocalDateTime.now().plusDays(7).toString().substring(0,10));%>"></input>
                                    <button type='submit' class='btn btn-success btn-block' name='create_menu_Plan'>Menüvorschlag erstellen</button>
                                </div>
                             </form>
                    </div>
                </div>

            <div class="row">
                <%--<div class="col-md-3">
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h4 class="box-title">Draggable Events</h4>
                        </div>
                        <div class="box-body">
                            <!-- the events -->
                            <div id='external-events'>
                                <div class='external-event bg-green'>Lunch</div>
                                <div class='external-event bg-yellow'>Go home</div>
                                <div class='external-event bg-aqua'>Do homework</div>
                                <div class='external-event bg-light-blue'>Work on UI design</div>
                                <div class='external-event bg-red'>Sleep tight</div>
                                <div class="checkbox">
                                    <label for='drop-remove'>
                                        <input type='checkbox' id='drop-remove' />
                                        remove after drop
                                    </label>
                                </div>
                            </div>
                        </div><!-- /.box-body -->
                    </div><!-- /. box -->
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">Create Event</h3>
                        </div>
                        <div class="box-body">
                            <div class="btn-group" style="width: 100%; margin-bottom: 10px;">
                                <!--<button type="button" id="color-chooser-btn" class="btn btn-info btn-block dropdown-toggle" data-toggle="dropdown">Color <span class="caret"></span></button>-->
                                <ul class="fc-color-picker" id="color-chooser">
                                    <li><a class="text-aqua" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-blue" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-light-blue" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-teal" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-yellow" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-orange" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-green" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-lime" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-red" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-purple" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-fuchsia" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-muted" href="#"><i class="fa fa-square"></i></a></li>
                                    <li><a class="text-navy" href="#"><i class="fa fa-square"></i></a></li>
                                </ul>
                            </div><!-- /btn-group -->
                            <div class="input-group">
                                <input id="new-event" type="text" class="form-control" placeholder="Event Title">
                                <div class="input-group-btn">
                                    <button id="add-new-event" type="button" class="btn btn-primary btn-flat">Add</button>
                                </div><!-- /btn-group -->
                            </div><!-- /input-group -->
                        </div>
                    </div>
                </div><!-- /.col -->--%>
                <div class="col-md-12">
                    <div class="box box-primary">
                        <div class="box-body no-padding">
                            <!-- THE CALENDAR -->
                            <div id="calendar"></div>
                        </div><!-- /.box-body -->
                    </div><!-- /. box -->
                </div><!-- /.col -->
            </div><!-- /.row -->

        </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
    <!-- Modal -->
    <div class="modal fade" id="modal_menu_created" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Menüvorschlag</h4>
                </div>
                <div class="modal-body">
                    Ihr Menüvorschlag wurde nun erstellt oder angepasst.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Schließen</button>
                </div>
            </div>
        </div>
    </div>
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

<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js" type="text/javascript"></script>
<!-- fullCalendar 2.2.5 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.7.0/moment.min.js" type="text/javascript"></script>
<script src="../plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
<!-- jQuery UI 1.11.1 -->
<script src="//code.jquery.com/ui/1.11.1/jquery-ui.min.js" type="text/javascript"></script>
<!-- Page specific script -->
<script type="text/javascript">
    $(function () {

        /* initialize the external events
         -----------------------------------------------------------------*/
        function ini_events(ele) {
            ele.each(function () {

                // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
                // it doesn't need to have a start or end
                var eventObject = {
                    title: $.trim($(this).text()) // use the element's text as the event title
                };

                // store the Event Object in the DOM element so we can get to it later
                $(this).data('eventObject', eventObject);

                // make the event draggable using jQuery UI
                $(this).draggable({
                    zIndex: 1070,
                    revert: true, // will cause the event to go back to its
                    revertDuration: 0  //  original position after the drag
                });

            });
        }
        ini_events($('#external-events div.external-event'));



        /* initialize the calendar
         -----------------------------------------------------------------*/
        //Date for the calendar events (dummy data)
        var date = new Date();
        var d = date.getDate(),
            m = date.getMonth(),
            y = date.getFullYear();
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            buttonText: {
                today: 'today',
                month: 'month',
                week: 'week',
                day: 'day'
            },
            //Random default events
            events: [
/*               {
                    title: 'All Day Event',
                    start: new Date(y, m, 1),
                    backgroundColor: "#f56954", //red
                    borderColor: "#f56954" //red
                },
                {
                    title: 'Long Event',
                    start: new Date(y, m, d - 5),
                    end: new Date(y, m, d - 2),
                    backgroundColor: "#f39c12", //yellow
                    borderColor: "#f39c12" //yellow
                },
                {
                    title: 'Meeting',
                    start: new Date(y, m, d, 10, 30),
                    allDay: false,
                    backgroundColor: "#0073b7", //Blue
                    borderColor: "#0073b7" //Blue
                },
                {
                    title: 'Lunch',
                    start: new Date(y, m, d, 12, 0),
                    end: new Date(y, m, d, 14, 0),
                    allDay: false,
                    backgroundColor: "#00c0ef", //Info (aqua)
                    borderColor: "#00c0ef" //Info (aqua)
                },
                {
                    title: 'Birthday Party',
                    start: new Date(y, m, d + 1, 19, 0),
                    end: new Date(y, m, d + 1, 22, 30),
                    allDay: false,
                    backgroundColor: "#00a65a", //Success (green)
                    borderColor: "#00a65a" //Success (green)
                },
                {
                    title: 'Click for Google',
                    start: new Date(y, m, 28),
                    end: new Date(y, m, 29),
                    url: 'http://google.com/',
                    backgroundColor: "#3c8dbc", //Primary (light-blue)
                    borderColor: "#3c8dbc" //Primary (light-blue)
                },*/

                <%
    try{
        while(resSetMeals.next()){
            String title = resSetMeals.getString(5);
            int rec_id = resSetMeals.getInt(2);
            int meal_id = resSetMeals.getInt(1);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy:M:dd");
            String date = sdf.format(resSetMeals.getDate(3));
            String[] datumparts = date.split(":");
            String jahr = datumparts[0];
            String monat = datumparts[1];
            int temp = Integer.parseInt(monat);
            temp--;
            monat = ", " + temp;
            String tag = ", " + datumparts[2];

            String zeit = resSetMeals.getString(6);
            String stunde;
            String minuten;

            switch(zeit){
                case "Frühstück":
                    stunde = ", 08";
                    minuten = ", 00";
                    break;
                case "Mittagessen":
                    stunde = ", 12";
                    minuten = ", 00";
                    break;
                 case "Abendessen":
                     stunde = ", 18";
                     minuten = ", 00";
                     break;
                 case "Snack":
                     stunde = ", 16";
                     minuten = ", 30";
                     break;
                 default:
                     String[] zeitparts = zeit.split(":");
                     stunde = ", " + zeitparts[0];
                     minuten = ", " + zeitparts[1];
                    break;
            }



            String url = "/show/manage_recipe.html?recipe=" + rec_id;


        out.println("{");
        out.println("title: '" + title + "',");
        out.println("start: new Date(" + jahr + monat + tag + stunde + minuten + "),");
        out.println("url: '" + url + "'," );
        out.println("backgroundColor: '#3c8dbc'");
        out.println("}");
        if(resSetMeals.next()){
            out.println(",");
            resSetMeals.previous();
        }

    }
    } catch(Exception e){}
%>

            ],

            timeFormat: 'H:mm',
            editable: true,
            droppable: true, // this allows things to be dropped onto the calendar !!!
            drop: function (date, allDay) { // this function is called when something is dropped

                // retrieve the dropped element's stored Event Object
                var originalEventObject = $(this).data('eventObject');

                // we need to copy it, so that multiple events don't have a reference to the same object
                var copiedEventObject = $.extend({}, originalEventObject);

                // assign it the date that was reported
                copiedEventObject.start = date;
                copiedEventObject.allDay = allDay;
                copiedEventObject.backgroundColor = $(this).css("background-color");
                copiedEventObject.borderColor = $(this).css("border-color");

                // render the event on the calendar
                // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                // is the "remove after drop" checkbox checked?
                if ($('#drop-remove').is(':checked')) {
                    // if so, remove the element from the "Draggable Events" list
                    $(this).remove();
                }

            }
        });

        /* ADDING EVENTS */
        var currColor = "#3c8dbc"; //Red by default
        //Color chooser button
        var colorChooser = $("#color-chooser-btn");
        $("#color-chooser > li > a").click(function (e) {
            e.preventDefault();
            //Save color
            currColor = $(this).css("color");
            //Add color effect to button
            $('#add-new-event').css({"background-color": currColor, "border-color": currColor});
        });
        $("#add-new-event").click(function (e) {
            e.preventDefault();
            //Get value and make sure it is not null
            var val = $("#new-event").val();
            if (val.length == 0) {
                return;
            }

            //Create events
            var event = $("<div />");
            event.css({"background-color": currColor, "border-color": currColor, "color": "#fff"}).addClass("external-event");
            event.html(val);
            $('#external-events').prepend(event);

            //Add draggable funtionality
            ini_events(event);

            //Remove event from text input
            $("#new-event").val("");
        });
    });
</script>
<script type="text/javascript">
   /* $(document).delay(1).queue(function () {
        $("#main_treeview").removeClass("active");
        $('#meal_plan_treeview').addClass('active');
    });
    */
   $(document).ready(function () {
       $("#main_treeview").removeClass("active");
       $('#meal_plan_treeview').addClass('active');
   });
</script>

<%--<c:>
    <script>
        if( test="${not empty MenuCreated"){
        window.addEventListener("load",function(){
            alert("${MenuCreated}");
        }
        }
    </script>


</c:if>--%>

<script>
    $(document).ready(function(){
        var menuCreated = getCookie('menuCreated');
        if(menuCreated != ""){
            setCookie('menuCreated', "", 0);
            //alert('Menüplan wurde kreiiert');
            $('#modal_menu_created').modal('show');
        }
    });

    function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays*24*60*60*1000));
        var expires = "expires="+ d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/show/";
    }

    function getCookie(cname) {
        var name = cname + "=";
        var decodedCookie = decodeURIComponent(document.cookie);
        var ca = decodedCookie.split(';');
        for(var i = 0; i <ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
</script>


</body>
</html>
