$(function () {

    /* Mobile menus */

    var menuSlideTime = 300;

    $('.js-menu-toggle').on('click', function (e) {

        e.preventDefault();

        var self = $(this);
        var target = self.attr('data-target');
        var nav = $('#pageNav');

        if (nav.is(':visible')) {

            if (nav.attr('data-toggled') !== target) {

                nav.slideUp(menuSlideTime, function () {

                    nav
                        .attr('data-toggled', target)
                        .slideDown(menuSlideTime);

                });

            } else {

                nav.slideUp(menuSlideTime);

            }

        } else {

            nav
                .attr('data-toggled', target)
                .slideDown(menuSlideTime);

        }

    });

    /* Equal height columns */



    function equalHeightBlocks() {

        if ($(window).width() >= 720) {

            $('.grid').each(function () {

                var grid = $(this);
                var blocks = grid.find('.block');
                var highest = 0;

                if (!grid.find('.sidebar').length) {

                    blocks.each(function () {

                        var block = $(this);
                        var height = block.outerHeight();

                        if (height > highest) {

                            highest = height;

                        }

                    });

                    blocks.css({
                        'height': highest
                    });

                }

            });

        }

    }

    setTimeout(function () {

        equalHeightBlocks();

    }, 1);

    var resizeTimer;

    $(window).on('resize', function (e) {

        if (!$('body').hasClass('dnnEditState')) {

            $('.block').css('height', 'auto');

            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function () {

                equalHeightBlocks();

            }, 250);

        }

    });

    /* Dropdowns */

    $('.js-dropdown').each(function () {

        var button = $(this);
        var menu = button.next();

        button.on('click', function (e) {

            e.preventDefault();

            $('.dropdown__menu').not(menu).hide();

            menu.toggle();

        });

    });

    $('.has-dropdown a').on('click', function () {

        var anchor = $(this);
        var menu = anchor.next('ul');

        if ($(window).width() >= 720) {

            $('.nav__dropdown').not(menu).hide();

            menu.toggle();

        } else {

            menu.slideToggle(500);

        }


    });

    $(document).on('click', function (event) {

        if (!$(event.target).closest('.dropdown').length) {

            $('.dropdown__menu').hide();

        }

        if (!$(event.target).closest('.has-dropdown').length) {

            $('.nav__dropdown').hide();

        }

    });

});