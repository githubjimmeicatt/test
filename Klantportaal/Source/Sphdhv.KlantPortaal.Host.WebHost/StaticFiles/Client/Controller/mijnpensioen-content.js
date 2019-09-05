(function ($) {

    $.fn.jsmvc.controller("mijnpensioen-content", {
        view: {
            id: "mijnpensioen-content",
            template: "mijnpensioen-content",
            path: null
        },
        model: null,
        reloadAfterHashChange: true
    },
    function (instance) {

        instance.viewrendered(function (e, data) {


        });

        instance.viewhandler('mijnpensioen-content',
            function (view) {

            }
        );


    });


})(jQuery);
//# sourceURL=mijnpensioen-content.js