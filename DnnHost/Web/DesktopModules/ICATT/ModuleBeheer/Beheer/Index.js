    (function($) {

        $(function() {
            $('#<%=UniquePrefix%> > tbody > tr > td.bttn-plusmin')
                .click(function () {
                    var $btn = $(this);

                    if ($btn.text() == '-' || $btn.data('open') == true ) {
                        $btn.parent().next().hide();
                        $btn.text('+');
                        $btn.data('open', false);
                    } else {
                        $btn.parent().next().show();
                        $btn.text('-');
                        $btn.data('open', true);
                    }
                });

        });
        
    })(jQuery);
