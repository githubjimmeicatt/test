﻿(function ($) {

    $.fn.jsmvc.controller("mijnpensioen-actueelpensioen", {
        view: {
            id: "mijnpensioen-actueelpensioen",
            template: "mijnpensioen-actueelpensioen",
            path: null
        },
        model: function (e, context) {
            var controller = this;

            var csrf = controller.app.endpoints.mijnpensioen.csrf();

            return {
                url: controller.app.endpoints.mijnpensioen.url + "ActueelPensioen?csrf=" + csrf,
                dataType: controller.app.endpoints.mijnpensioen.dataType
            };
        },
        reloadAfterHashChange: true
    },
        function (instance) {

            instance.modelloadcompleted(function (e, data) {
                var model = data.result.data;
                model.emailVerified = instance.app.state.retrieve('verifyemail-result');
               instance.app.state.store('verifyemail-result', undefined);
            });
            instance.viewrendered(function (e, data) {
                instance.app.loadController('alert', '#alertPlaceholder', {
                    title: 'Bedankt voor het bevestigen van je e-mailadres.', body: '',
                });
            });

        });


})(jQuery);
//# sourceURL=mijnpensioen-actueelpensioen.js