(function ($) {

    $.fn.jsmvc.controller("mijnpensioen-berichten", {
        view: {
            id: "mijnpensioen-berichten",
            template: "mijnpensioen-berichten",
            path: null
        },
        model: function (e, context) {
            var controller = this;

            var csrf = controller.app.endpoints.berichten.csrf();

            return {
                url: controller.app.endpoints.berichten.url + "CorrespondentieOverzicht?csrf=" + csrf,
                dataType: controller.app.endpoints.mijnpensioen.dataType
            };
        },
        reloadAfterHashChange: true

   },
    function (instance) {

        instance.modelloadcompleted(function (e, d) {
            d.result.data["url"] = instance.app.endpoints.berichten.url ;
        });

        instance.viewrendered(function (e, data) {


        });

        instance.viewhandler('mijnpensioen-berichten',
            function (view) {

                view.events.downloadDocument(function (e, data) {
                                      
 

                });

            }
        );


    });


})(jQuery);
//# sourceURL=mijnpensioen-berichten.js