(function ($, window, document) {

    $(document).on('click', '.Accordeon-button', function () {

        var btn = $(this);
        var target = $('#' + btn.attr('aria-controls'));
        var expanded = btn.attr('aria-expanded') === 'true' ? true : false;

        if (expanded) {

            target
                .attr('aria-hidden', 'true')
                .slideUp(300);
            btn.attr('aria-expanded', 'false');

        } else {

            target
                .attr('aria-hidden', 'false')
                .slideDown(300);
            btn.attr('aria-expanded', 'true');

        }

    });

}(window.jQuery, window, document));