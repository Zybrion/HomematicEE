<%--
  Created by IntelliJ IDEA.
  User: rener
  Date: 13.02.2018
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HomeMatic | Registrieren</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../../dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="../../plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="register-page">
<div class="register-box">
    <div class="register-logo">
        <a href="../../index.html"><b>Home</b>Matic</a>
    </div>

    <div class="register-box-body">
        <p class="login-box-msg">Registriere einen neuen Haushalt</p>
        <form action="reg" method="post">
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Haushaltsname" name="registration_household_name" required onblur="isHouseholdNameOk(this, document.getElementById('household_help'))"/>
                <span class="glyphicon glyphicon-home form-control-feedback"></span>
                <span id="household_help"></span>
            </div>
            </br>
            <b>Benutzererstellung</b>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Vorname" name="registration_firstname" required onblur="isTheFirstNameOk(this, document.getElementById('firstname_help'))"/>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
                <span id="firstname_help"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Nachname" name="registration_name" onblur="isTheLastNameOk(this, document.getElementById('lastname_help'))"/>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
                <span id="lastname_help"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="date" class="form-control" placeholder="Geburtsdatum" name="registration_birthdate" required/>
                <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Email" name="registration_email" required onblur="isEmailOk(this, document.getElementById('email_help'))"/>
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                <span id="email_help"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" class="form-control" placeholder="Password" name="registration_password" required/>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            </br>
            <b>Adresse</b>
            <div class="form-group has-feedback">
                <!--<input type="text" class="form-control" placeholder="Land" name="registration_country" required/>
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>-->
                <select class="form-control" name="registration_country" required>
                    <option>Austria</option>
                    <option>Belgium</option>
                    <option>Brazil</option>
                    <option>China</option>
                    <option>France</option>
                    <option selected>Germany</option>
                    <option>India</option>
                    <option>Indonesia</option>
                    <option>Netherlands</option>
                    <option>Pakistan</option>
                    <option>Poland</option>
                    <option>Russia</option>
                    <option>Swiss</option>
                    <option>United Kingdom</option>
                    <option>United States</option>
                </select>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Ort" name="registration_city" required onblur="isAddressPlaceOk(this, document.getElementById('address_help'))"/>
                <span class="glyphicon glyphicon-pushpin form-control-feedback"></span>
                <span id="address_help"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Postleitzahl" name="registration_postal_code" required onblur="isAddressPLZOk(this, document.getElementById('plz_help'))" />
                <span class="glyphicon glyphicon-record form-control-feedback"></span>
                <span id="plz_help"></span>

            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Straße" name="registration_street" required onblur="isAddressStreetOk(this, document.getElementById('street_help'))"/>
                <span class="glyphicon glyphicon-flag form-control-feedback"></span>
                <span id="street_help"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="Hausnummer" name="registration_number" required onblur="isAddressNumberOk(this, document.getElementById('addressnumber_help'))"/>
                <span class="glyphicon glyphicon-sound-5-1 form-control-feedback"></span>
                <span id="addressnumber_help"></span>
            </div>
            </br>
            <b>Zahlungsangaben</b>
            <div class="form-group has-feedback">
                <!--  <input type="text" class="form-control" placeholder="Zahlungsmethode" name="registration_payment_method_description" required/>
                <span class="glyphicon glyphicon-log-in form-control-feedback"></span>      -->
                <select class="form-control" required name="registration_payment_method_description" placeholder="Zahlungsmethode">
                    <option selected>Lastschrift</option>
                </select>
            </div>
            <div class="form-group has-feedback">
                <input type="text" class="form-control" placeholder="IBAN" name="registration_iban" required onblur="isIbanOk(this, document.getElementById('iban_help'))"/>
                <span class="glyphicon glyphicon-credit-card form-control-feedback"></span>
                <span id="iban_help"></span>
            </div>
            <div class="checkbox icheck">
                <label>
                    <input type="checkbox" name="registration_sepa_ddm" required> Ich bevollmächtige hiermit das SEPA-Lastschriftmandat
                </label>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox" name="registration_agb" required> Ich bin mit den <a href="../pages/easter_egg.html">AGBs </a> einverstanden
                        </label>
                    </div>
                </div><!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" id="submit_button" class="btn btn-primary btn-block btn-flat">Registrieren</button>
                </div><!-- /.col -->
            </div>
        </form>

        <%--<div class="social-auth-links text-center">
            <p>- OR -</p>
            <a href="#" class="btn btn-block btn-social btn-facebook btn-flat"><i class="fa fa-facebook"></i> Sign up using Facebook</a>
            <a href="#" class="btn btn-block btn-social btn-google-plus btn-flat"><i class="fa fa-google-plus"></i> Sign up using Google+</a>
        </div>--%>

        <a href="login.html" class="text-center">Ich habe bereits einen Haushalt!</a>
    </div><!-- /.form-box -->

    <!-- Modal -->
    <div class="modal fade" id="model_register" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Registrierung</h4>
                </div>
                <div class="modal-body">
                    Ihre E-Mail Adresse ist bereits vergeben! Bitte benutze eine noch freie E-Mail-Adresse um die Registrierung abzuschließen.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal">Schließen</button>
                </div>
            </div>
        </div>
    </div>

</div><!-- /.register-box -->

<!-- jQuery 2.1.3 -->
<script src="../../plugins/jQuery/jQuery-2.1.3.min.js"></script>
<!-- Bootstrap 3.3.2 JS -->
<script src="../../bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!-- iCheck -->
<script src="../../plugins/iCheck/icheck.min.js" type="text/javascript"></script>
<script src="../dist/js/pages/modal_functions.js" type="text/javascript"></script>
<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    });
</script>

<!-- Feld checks auf Richtigkeit -->
<script type="text/javascript">
    var lock = 0;
    function editNodeText(regex, input, helpId, helpMessage)

    {
        // See if the info matches the regex that was defined
        // If the wrong information was entered, warn them
        if (!regex.test(input)) {

            if (helpId != null)
            // We need to show a warning
            // Remove any warnings that may exist
                while (helpId.childNodes[0]){
                lock = lock - 1;
                    helpId.removeChild(helpId.childNodes[0]);
                }

            // Add new warning
            helpId.appendChild(document.createTextNode(helpMessage));
            //document.getElementById("submit_button").disabled = true;
            lock = lock + 1;
            document.getElementById("submit_button").style.cursor = "not-allowed";

        } else {

            // If the right information was entered, clear the help message
            if (helpId != null){

                // Remove any warnings that may exist
                while (helpId.childNodes[0]){
                    helpId.removeChild(helpId.childNodes[0]);
                    lock = lock - 1;
                    if(lock === 0){
                        //ocument.getElementById("submit_button").disabled = false;
                        document.getElementById("submit_button").style.cursor = "default";
                    }
                }

            }

        }
    }

    // inputField – ID Number for the html text box
    // helpId – ID Number for the child node I want to print a warning in
    function isTheFirstNameOk(inputField, helpId) {

        // See if the input value contains any text
        return editNodeText(/^[A-Za-zß]{1}[a-z]{2,15}[-]{0,1}[A-Z]{0,1}[a-z]{0,15}[-]{0,1}[A-Z]{0,1}[a-z]{0,15}$/, inputField.value, helpId, "Geben Sie einen gültigen Vornamen ein.");
    }
    function isTheLastNameOk(inputField, helpId) {

        // See if the input value contains any text
        return editNodeText(/^[A-Za-z]{1}[a-zß]{2,15}[-]{0,1}[A-Z]{0,1}[a-zß]{0,15}[-]{0,1}[A-Z]{0,1}[a-zß]{0,15}$/, inputField.value, helpId, "Geben Sie einen gültigen Nachnamen ein.");
    }
    function isAddressStreetOk(inputField, helpId) {

        return editNodeText(/^[A-Za-zß\.\' \-]{5,70}$/, inputField.value, helpId, "Geben Sie eine gültige Straße ein");
    }
    function isAddressNumberOk(inputField, helpId) {

        //return editNodeText(/^[0-9]{1,5}\/{0,1}[0-9]{0,5}[A-Za-z]{0,2}$/, inputField.value, helpId, "Geben Sie eine gültige Adressnummer ein.");
        return editNodeText(/^[0-9]{1,10}$/, inputField.value, helpId, "Geben Sie eine gültige Adressnummer ein.");
    }
    function isAddressPlaceOk(inputField, helpId) {

        return editNodeText(/^[A-Za-zß\.\' \-]{5,40}$/, inputField.value, helpId, "Geben Sie einen gültigen Ort ein");
    }
    function isAddressPLZOk(inputField, helpId) {

        return editNodeText(/^([A-Za-z0-9]{3,10})$/, inputField.value, helpId, "Geben Sie eine gültige Adressnummer ein.");
    }
    function isEmailOk(inputField, helpId) {

        return editNodeText(/^[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, inputField.value, helpId, "Geben Sie eine gültige E-Mail ein. Beispiel: max.mustermann@gmail.com");
    }
    function isIbanOk(inputField, helpId) {

        return editNodeText(/^[A-Z]{2}[0-9]{10,32}$/, inputField.value, helpId, "Geben Sie einen gültigen IBAN ein. Beispiel: DE12345678987654321234");
    }
    function isHouseholdNameOk(inputField, helpId) {

        return editNodeText(/^^[A-Za-z0-9ß'\/|#+*~"§\$\&\(\)\[\] ]{3,45}$/, inputField.value, helpId, "Geben Sie einen gültigen Haushaltsnamen ein. Beispiel: 'Die Mustermanns'");
    }

</script>

<script>
    $(document).ready(function(){
        var menuCreated = getCookie('aiu');
        if(menuCreated != ""){
            setCookie('aiu', "", 0);
            //alert('Menüplan wurde kreiiert');
            $('#modal_register').modal('show');
        }
    });


</script>

</body>
</html>