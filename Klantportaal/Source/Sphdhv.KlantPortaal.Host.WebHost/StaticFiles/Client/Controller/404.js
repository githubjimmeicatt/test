(function ($) {

    $.fn.jsmvc.controller("404", {
        view: {
            id: "404",
            template: "404",
            path: null
        },
        model: null,
        reloadAfterHashChange: true
    },
    function (instance) {

        instance.viewrendered(function (e, data) {


        });

        instance.viewhandler('404',
            function (view) {

            }
        );


    });


})(jQuery);
//# sourceURL=mijnpensioen-berichten.js