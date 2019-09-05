<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Register TagPrefix="dnn" 
    Namespace="DotNetNuke.Web.Client.ClientResourceManagement" 
    Assembly="DotNetNuke.Web.Client" %>

<%

    var model = Newtonsoft.Json.JsonConvert.SerializeObject(Model as Sphdhv.Dnn.Extensions.KlantPortaal.Modules.MijnPensioenController.ViewModel ?? new Sphdhv.Dnn.Extensions.KlantPortaal.Modules.MijnPensioenController.ViewModel());
    
%>

<%-- JS Header scripts --%>
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/js/dust/2.0.0/dust-full-2.0.0.min.js" ForceProvider="DnnPageHeaderProvider" Priority="50" />
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/js/dust-helpers/1.1.1/dust-helpers-1.1.1.min.js" ForceProvider="DnnPageHeaderProvider" Priority="51" />
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/js/jquery.paging/1.2.0/jquery.paging.js" ForceProvider="DnnPageHeaderProvider" Priority="55" />
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/js/jquery.query-object/1.0.0/jquery.query-object.min.js" ForceProvider="DnnPageHeaderProvider" Priority="56" />


<%-- JS Body scripts --%>
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/jsmvc/1.1/application-1.1.1.js" ForceProvider="DnnBodyProvider" Priority="101" />

<script language="javascript" type="text/javascript">

    (function($) {

        $(function() {
            //on document ready

            var data = <%= model %>;

            function getCookie(cname) {
                var name = cname + "=";
                var decodedCookie = decodeURIComponent(document.cookie);
                var ca = decodedCookie.split(';');
                for (var i = 0; i < ca.length; i++) {
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

            var extensionMethods = {

                messenger: (function () {
                    var current;
                    return {
                        error: function (message, timeout) {
                            if ("undefined" === typeof timeout)
                                timeout = 3000;
                            if (0 === timeout)
                                timeout = "0";
                            toastr.clear(current);
                            current = toastr.error(message, '', { closeButton: true, timeOut: timeout, extendedTimeout: 0 });
                        },
                        success: function (message, useCloseButton) {
                            toastr.clear(current);
                            if (typeof useCloseButton == "undefined") {
                                useCloseButton = false;
                            }
                            var settings = { closeButton: useCloseButton };
                            if (useCloseButton)
                                $.extend(settings, { timeOut: "0" });

                            current = toastr.success(message, '', settings);
                        },
                        warning: function (message) {
                            if ("undefined" === typeof timeout)
                                timeout = 3000;
                            if (0 === timeout)
                                timeout = "0";
                            toastr.clear(current);
                            current = toastr.warning(message, '', { closeButton: true, timeOut: timeout, extendedTimeout: 0 });
                        }

                    };

                })(),
                spinner: (function () {
                    var timeout;
                    return {
                        spin: function (app) {

                            if(!timeout) {
                                timeout = setTimeout(function () {

                                    $('body').addClass('jsmvc-is-loading');

                                }, 1000);
                            }

                        },
                        stop: function (app) {

                            if (timeout) {
                                clearTimeout(timeout);
                                timeout = undefined;
                            }

                            $('body').removeClass('jsmvc-is-loading');

                        }
                    }
                })()

            };

            var getCSRFCookie = function () {
                return getCookie('KP_CSRF_CLIENT');
            }

            var pages = {
                start: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-content",
                    controllers: [
                        {
                            placeholder: '#content',
                            controller: 'start'
                        }]
                },
                pensioen: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-tabcontroller",
                    controllers: [{
                        placeholder: '#tabContent',
                        controller: 'mijnpensioen-actueelpensioen'
                    }]
                },
                profiel: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-tabcontroller",
                    controllers: [
                    {
                        placeholder: '#tabContent',
                        controller: 'mijnpensioen-profiel'
                    }]
                },
                berichten: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-tabcontroller",
                    controllers: [
                    {
                        placeholder: '#tabContent',
                        controller: 'mijnpensioen-berichten'
                    }]
                },
                email: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-content",
                    controllers: [
                    {
                        placeholder: '#content',
                        controller: 'email-collect'
                    }]
                },
                404: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-tabcontroller",
                    controllers: [
                    {
                        placeholder: '#tabContent',
                        controller: '404'
                    }]
                },
                DigidStoring: {
                    placeholder: "#phMijnPensioenSpa",
                    controller: "mijnpensioen-tabcontroller",
                    controllers: [
                        {
                            placeholder: '#tabContent',
                            controller: 'DigidStoring'
                        }]
                }
            };

            var endpoints = {
                controllers: {
                    url: data.KlantportaalEndpoint + 'api/Client/Controller/',
                    dataType: 'jsonp'
                },
                views: {
                    url: data.KlantportaalEndpoint + 'api/Client/View/',
                    dataType: 'jsonp'
                },
                models: {
                    url: '',
                    //dataType: 'jsonp'
                },
                mijnpensioen: {
                    url: data.KlantportaalEndpoint + 'api/MijnPensioen/',
                    dataType: 'jsonp',
                    csrf: getCSRFCookie
                },
                deelnemer: {
                    url: data.KlantportaalEndpoint + 'api/Deelnemer/',
                    dataType: 'jsonp',
                    csrf: getCSRFCookie                    
                },
                berichten: {
                    url: data.KlantportaalEndpoint + 'api/Correspondentie/',
                    dataType: 'jsonp',
                    csrf: getCSRFCookie
                },
            };

            var application = $(document).jsmvc({
                logAjaxErrors: false,
                logenabled: true,
                endpoints: endpoints,
                shared: {
                    views: []
                },
                routes: {
                },
                pages: pages,
                //controller: 'mijnpensioen-actueelpensioen',
                //container: '', 
                defaultModelFileName: '',
                start: function (app) {
                    //show spinner before first step is loaded
                    application.log('application startup =>start spinner');
                    application.spinner.spin(app);
                },
                appnavigate: function (app) {
                    app.log('application.appnavigate=>start spinner');
                    app.spinner.spin(app);
                },
                renderComplete: function (app, context) {
                    app.log('application.renderComplete=>stop spinner');
                    if (!context.expired) app.spinner.stop(app);
                },
                modelLoadException: function (app) {
                    app.log('application.modelLoadException=>stop spinner');
                    //app.spinner.stop(app);
                    //application.messenger.error('Er is een fout opgetreden. Probeer het opnieuw');
                    // app.navigate("error");
                },
                unauthorized: function (app) {
                    //  app.navigate("login");
                },
                notfound: function (app) {
                    app.navigate('404');
                }
            });

            //add spinner feature to application obejct
            $.extend(application, extensionMethods);

            application.start({
                page: 'start'
            });



        });


    })(jQuery);

</script>

<div id="phMijnPensioenSpa"></div>