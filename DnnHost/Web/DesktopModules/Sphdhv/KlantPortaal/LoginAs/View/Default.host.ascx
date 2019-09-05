<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Register TagPrefix="dnn"
    Namespace="DotNetNuke.Web.Client.ClientResourceManagement"
    Assembly="DotNetNuke.Web.Client" %>



<div id="loginForm">
    <div class="grid">
        <div class="col-span-12-sm col-span-12-md col-span-12-lg">
            <div class="action-title">
                <h1>Login als deelnemer</h1>
            </div>
            <p id="loginError" style="color: red;"></p>
            <dl>
                <dt>gebruikersnaam</dt>
                <dd><input type="text" name="username" /></dd>
                <dt>wachtwoord</dt>
                <dd><input type="password" name="password" /></dd>
                <dt>dossiernummer</dt>
                <dd><input type="text" name="dossierNr" /></dd>
                <dt></dt>
                <dd> <input type="submit" value="log in" class="button button--primary" onclick="action = '<%= Sphdhv.Dnn.Properties.Settings.Default.KlantportaalEndpoint   %>login/login'; this.form.submit();"></dd>
                <dt><a href="javascript:;" id="toggleWachtwoordWijzigen">wachtwoord wijzigen/aanmaken</a></dt>
                <dd></dd>
            </dl>
        </div>
    </div>
</div>
 
<br /><br />

<div id="requestNewPasswordForm">
    <div class="grid">
        <div class="col-span-12-sm col-span-12-md col-span-12-lg">
            <div class="action-title">
                <h1>Wachtwoord aanmaken/wijzigen</h1>
            </div>
            <p>Heb je nog geen wachtwoord of ben je deze vergeten, vul dan hier je gebruikersnaam in. Je ontvangt dan een mail met een link waarmee je een wachtwoord kan instellen.</p>
            <dl>
                <dt>gebruikersnaam</dt>
                <dd><input type="text" name="user" /></dd>                
                <dt></dt>
                <dd> <input type="submit" value="verstuur" class="button button--primary"  onclick="action = '<%=  Sphdhv.Dnn.Properties.Settings.Default.KlantportaalEndpoint    %>login/resetPasswordToken'; this.form.submit();"></dd>
            </dl>
        </div>
    </div>
</div>



<div id="resetPasswordForm">
    <div class="grid">
        <div class="col-span-12-sm col-span-12-md col-span-12-lg">
            <h1>Wachtwoord aanmaken</h1>
            <dl>
                <dt>wachtwoord</dt>
                <dd><input type="password" name="newpassword" /></dd>
                <dt>bevestig wachtwoord</dt>
                <dd><input type="password" name="newpasswordConfirm" /></dd>    
                <dt></dt>
                <dd>  <input type="submit" value="opslaan" class="button button--primary"  onclick="action = '<%=  Sphdhv.Dnn.Properties.Settings.Default.KlantportaalEndpoint    %>login/ResetPassword'; this.form.submit();"></dd>
            </dl>
            <input type="hidden" name="userId" id="userId" />
            <input type="hidden" name="token" id="token" />
            <p id="passwordResetError" style="color: red;"></p>
        </div>
    </div>
</div>

<script>

    $(function () {

        function getparam(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regexS = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexS);
            var results = regex.exec(window.location.href);
            if (results == null)
                return null;
            else
                return results[1];
        }

        function loadForm() {


            $('#loginForm').hide();
            $('#requestNewPasswordForm').hide();
            $('#resetPasswordForm').hide();
            $('#passwordResetError').hide();
            $('#loginError').hide();

            var userid = getparam("userid");
            var token = getparam("token");
            var passwordResetResult = getparam("passwordResetResult");
            var loginStatus = getparam("loginalsinvalid");

            if (userid != null && token != null) {
                $('#resetPasswordForm').show();
                $('#userId').val(userid);
                $('#token').val(token);
                if (passwordResetResult != null) {
                    $('#passwordResetError').show().text(decodeURI(passwordResetResult));
                }
            }  else {
                $('#loginForm').show();       
                if (loginStatus == "usernamepassword") {
                    $('#loginError').show().text("deze combinatie van wachtwoord gebruikersnaam is onbekend");
                }
                if (loginStatus == "dossiernr") {
                    $('#loginError').show().text("het dossiernummer is onbekend");
                }
            }

            $('#toggleWachtwoordWijzigen').on('click', function () {
                $('#requestNewPasswordForm').show();
            });

        }

        loadForm();

    });
</script>
