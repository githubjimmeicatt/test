(function ($) {

    $.fn.jsmvc.controller("mijnpensioen-tabcontroller", {
        view: {
            id: "mijnpensioen-tabcontroller",
            template: "mijnpensioen-tabcontroller",
            path: null
        },
        model: null,
        reloadAfterHashChange: true
    },
    function (instance) {

        instance.viewrendered(function (e, data) {


        });

        instance.viewhandler('mijnpensioen-tabcontroller',
            function (view) {

            }
        );


    });


})(jQuery);
//# sourceURL=mijnpensioen-tabcontroller.js