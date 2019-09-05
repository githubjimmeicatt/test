(function ($) {

    $.fn.jsmvc.controller("alert", {
        view: {
            id: "alert",
            template: "alert",
            path: null
        },
        model: null,
        reloadAfterHashChange: true
    },
    function (instance) {

        instance.viewrendered(function (e, data) {});

        instance.viewhandler('alert',
            function (view) {}
        );

    });


})(jQuery);
//# sourceURL=alert.js