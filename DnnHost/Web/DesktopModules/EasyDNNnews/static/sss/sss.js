/** Super Simple Slider by @intllgnt **/

;(function($, window, document) {
var windowLoaded = false;

$.fn.edn_sss = function(options) {
	var settings = $.extend(
			{
				slideShow : true,
				startOn : 0,
				speed : 3500,
				transition : 400,
				arrows : true
			},
			options
		),
		sliderInitializedKey = 'sliderInitialized';

	return this.each(function () {
		var wrapper = $(this),
			init = function () {
				var slides = wrapper.children().wrapAll('<div class="edn_sss"/>').addClass('edn_ssslide'),
					slider = wrapper.find('.edn_sss'),
					slide_count = slides.length,
					transition = settings.transition,
					starting_slide = settings.startOn,
					target = starting_slide > slide_count - 1 ? 0 : starting_slide,
					animating = false,
					clicked,
					timer,
					key,
					prev,
					next,

					reset_timer = settings.slideShow
						? function() {
							clearTimeout(timer);
							timer = setTimeout(next_slide, settings.speed);
						}
						: $.noop;

				function get_height(target) {
					return ((slides.eq(target).height() / slider.width()) * 100) + '%';
				}

				function animate_slide(target) {
					var target_slide;

					if (!animating) {
						animating = true;
						target_slide = slides.eq(target);

						target_slide.fadeIn(transition);
						slides.not(target_slide).fadeOut(transition);

						slider.animate(
							{
								paddingBottom: get_height(target)
							},
							transition,
							function() {
								animating = false;
							}
						);

						reset_timer();
					}
				};

				function next_slide() {
					target = target === slide_count - 1 ? 0 : target + 1;
					animate_slide(target);
				}

				function prev_slide() {
					target = target === 0 ? slide_count - 1 : target - 1;
					animate_slide(target);
				}

				function initSlider() {
					slider
						.css('paddingBottom', get_height(target))
						.click(function(e) {
							var clicked = $(e.target);

							if (clicked.is(next))
								next_slide();
							else if (clicked.is(prev))
								prev_slide();
						});

					animate_slide(target);

					$(document).keydown(function(e) {
						key = e.keyCode;

						if (key === 39)
							next_slide();
						else if (key === 37)
							prev_slide();
					});
				}

				if (settings.arrows) {
					slider.append('<div class="edn_sssprev"/>', '<div class="edn_sssnext"/>');
				}

				next = slider.find('.edn_sssnext');
				prev = slider.find('.edn_sssprev');

				if (windowLoaded)
					initSlider();
				else
					$(window).load(function () {
						windowLoaded = true;
						initSlider();
					});
			};

		if (wrapper.data(sliderInitializedKey))
			return;

		wrapper.data(sliderInitializedKey, true);
		init();
});

};
})(jQuery, window, document);