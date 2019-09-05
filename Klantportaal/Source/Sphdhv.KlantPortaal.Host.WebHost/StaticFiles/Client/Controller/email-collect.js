(function ($) {

    $.fn.jsmvc.controller("email-collect", {
        view: {
            id: "email-collect",
            template: "email-collect",
            path: null
        },
        model: null,
        reloadAfterHashChange: true
    },
        function (instance) {

            instance.registerEvent("emailSubmit");
            instance.registerEvent("emailOptOut");

            instance.viewrendered(function (e, data) {

            });

            instance.viewhandler('email-collect',
                function (view) {
                    
                    view.events.emailSubmit(function (e, data) {

                        var optIn = (data.email != '');

                        $.ajax({
                            type: "GET",
                            url: instance.app.endpoints.deelnemer.url + "OpslaanAanvulling?csrf=" + instance.app.endpoints.deelnemer.csrf() + "&email=" + encodeURIComponent(data.email),
                            dataType: instance.app.endpoints.deelnemer.dataType
                        })
                        .done(function (a, b, c) {
                            (a.StatusCode == 200 && optIn) ? view.app.renderTemplate(instance, "email-collect-bedankt", null, {}, function () { }) : view.app.navigate("profiel");
                        });

                    });

                });

        });


})(jQuery);
//# sourceURL=email-collect.js