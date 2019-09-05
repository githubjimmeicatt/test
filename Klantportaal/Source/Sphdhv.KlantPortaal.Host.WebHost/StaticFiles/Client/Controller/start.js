(function ($) {

    $.fn.jsmvc.controller("start", {
        view: null,
        model: function (e, context) {
            var controller = this;

            var csrf = controller.app.endpoints.deelnemer.csrf();
            if (!csrf) {
                
                return {
                    object: { redirectTo: "login"}
                };
            }


            var action = context.route.action;
            if ('verifyemail' == action) {
                var guid = '';
                if (context.route.params.length > 0) {
                    guid = context.route.params[0];
                }
                return {
                    url: controller.app.endpoints.deelnemer.url + "VerifyEmail?csrf=" + csrf + "&guid=" + guid,
                    dataType: controller.app.endpoints.deelnemer.dataType
                };

            } else {
                return {
                    url: controller.app.endpoints.deelnemer.url + "VraagAanvulling?csrf=" + csrf,
                    dataType: controller.app.endpoints.deelnemer.dataType
                };
            }
        },
        reloadAfterHashChange: true
    },
        function (instance) {

            instance.modelloadcompleted(function (e, data) {
                var page = 'profiel';
                var action = instance.app.context.route.action;
                var model = data.result.data;
                
                if ('verifyemail' == action) {
                    instance.app.state.store('verifyemail-result', model.Response);
                } else {
                    instance.app.state.store('verifyemail-result', undefined);

                    if (200 == model.StatusCode && model.Response) {
                        page = "email";
                    }

                    if (401 == model.StatusCode ) {
                        page = "login";
                    }
                }
                instance.app.navigate(data.result.data.redirectTo ? data.result.data.redirectTo : page);
            });



        });


})(jQuery);
//# sourceURL=start.js