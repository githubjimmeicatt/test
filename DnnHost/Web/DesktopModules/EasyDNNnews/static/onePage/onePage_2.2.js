(function ($, window) {
	'use strict';
	var viewportCheckerKey = 'viewportCheckedInstance',
		activeArticleClass = 'edNews__active',
		$window = $(window),
		defaultOptions = {
			tabId: 0,
			portalId: 0,
			moduleId: 0,
			websiteClientRoot: '',
			comments: {
				requireAuthorInfo: true
			}
		},
		scrollAnimationElement = 'scrollAnimationElement';

	$.fn.edNewsOnePage = function (options) {
		options = $.extend({}, defaultOptions, options);

		var $secondaryListWrappers = $('.edNews__secondaryArticleList_' + options.moduleId);

		if ($secondaryListWrappers.length == 0)
			return;

		$secondaryListWrappers.map(function (i, el) {
			$(el).parents('.edNews__secondaryArticleList').eq(0).eds_tinyscrollbar();
		});

		var $mainListWrapper = $('.edn_' + options.moduleId + '_article_list_wrapper');
		var oldArticleIndex = -2;
		var activeArticleIndex = 0;
		var activeArticleUrl = '';
		var activeArticleTitle = '';
		var blockScrollEvent = false;

		var activateViewportChecker = function () {
			$('>', $mainListWrapper).each(function () {
				var $articleWrapper = $(this);

				if ($articleWrapper.data(viewportCheckerKey))
					return;

				$articleWrapper
					.data(viewportCheckerKey, true)
					.viewportChecker({
						classToAdd: '',
						classToRemove: '',
						classToAddForFullView : '',
						repeat: true,
						offset: '40%',
						callbackFunction: function ($el) {
							var articleMeta = $el.data('articleMeta');

							if (!articleMeta)
								return;

							activeArticleIndex = $el.index('.edn_' + options.moduleId + '_article_list_wrapper > .edNews__article');
							activeArticleUrl = articleMeta.url;
							activeArticleTitle = articleMeta.pageArticleTitle;
						}
					});
			});
		};
		activateViewportChecker();

		$mainListWrapper.on('contentLoaded', function () {
			activateViewportChecker();
		});

		var updateSecondaryLists = function (init) {
			$secondaryListWrappers.each(function () {
				var $this = $(this),
					$wrapper = $this.parents('.edNews__secondaryArticleList').eq(0),
					$activeElement = $('>', $this).eq(activeArticleIndex),
					$scrollToElement = $('>', $this).eq(activeArticleIndex > 0 ? activeArticleIndex - 1 : 0);

				$activeElement
					.addClass(activeArticleClass)
					.siblings()
						.removeClass(activeArticleClass);

				var tinyscrollbar = $wrapper.data('plugin_eds_tinyscrollbar');

				if (!tinyscrollbar.hasContentToSroll)
					return;

				var topPosition = $scrollToElement.position().top,
					maxTopPosition = tinyscrollbar.contentSize - tinyscrollbar.viewportSize;

				if (topPosition > maxTopPosition)
					topPosition = maxTopPosition;

				var $oldAnimationWrapper = $wrapper.data(scrollAnimationElement);

				if ($oldAnimationWrapper && $oldAnimationWrapper.length > 0) {
					$oldAnimationWrapper.stop();
					$wrapper.data(scrollAnimationElement, '');
				}

				if (tinyscrollbar.contentPosition == topPosition || init)
					return;

				$wrapper.data(
					scrollAnimationElement,
					$({p: tinyscrollbar.contentPosition})
						.animate(
							{
								p: topPosition
							},
							{
								duration: 400,
								step: function (currentPosition) {
									tinyscrollbar.update(currentPosition);
								},
								complete: function () {
									$wrapper.data(scrollAnimationElement, '');
								}
							}
						)
				);
			});
		};

		var scrollTrigger = function (init) {
			if (blockScrollEvent || activeArticleIndex == oldArticleIndex)
				return;

			if (oldArticleIndex != -2) {
				history.pushState({articleIndex: activeArticleIndex}, '', activeArticleUrl);
				document.title = activeArticleTitle;
			}

			oldArticleIndex = activeArticleIndex;

			updateSecondaryLists(init);
		};
		scrollTrigger(true);

		$window
			.on('scroll.edNewsOnePage', function () {
				scrollTrigger();
			})
			.on('popstate', function (ev) {
				var state = ev.originalEvent.state,
					newArticleIndex = 0;

				if (state)
					newArticleIndex = state.articleIndex;

				activeArticleIndex = oldArticleIndex = newArticleIndex;

				updateSecondaryLists();

				blockScrollEvent = true;

				$('html, body')
					.stop()
					.animate(
						{
							scrollTop: $('>', $mainListWrapper).eq(newArticleIndex).offset().top
						},
						{
							duration: 400,
							complete: function () {
								blockScrollEvent = false;
								$window.trigger('scroll.edNewsOnePage');
							}
						}
					);
			});

		$secondaryListWrappers.on('click', '.edNews__articleTrigger', function (ev) {
			ev.preventDefault();

			var $articleWrapper = $(this).parents('.edNews__article').eq(0);

			if ($articleWrapper.hasClass(activeArticleClass))
				return;

			$articleWrapper
				.addClass(activeArticleClass)
				.siblings()
					.removeClass(activeArticleClass);

			activeArticleIndex = $articleWrapper.index();

			updateSecondaryLists();

			blockScrollEvent = true;

			$('html, body')
				.stop()
				.animate(
					{
						scrollTop: $('>', $mainListWrapper).eq(activeArticleIndex).offset().top
					},
					{
						duration: 400,
						complete: function () {
							blockScrollEvent = false;
							$window.trigger('scroll.edNewsOnePage');
						}
					}
				);
		});
		return this;
	};
})(eds3_5_jq, window);

/*
	The MIT License (MIT)

	Copyright (c) 2014 Dirk Groenen

	Permission is hereby granted, free of charge, to any person obtaining a copy of
	this software and associated documentation files (the "Software"), to deal in
	the Software without restriction, including without limitation the rights to
	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
	the Software, and to permit persons to whom the Software is furnished to do so,
	subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.
*/

(function($){
	$.fn.viewportChecker = function(useroptions){
		// Define options and extend with user
		var options = {
			classToAdd: 'visible',
			classToRemove : 'invisible',
			classToAddForFullView : 'full-visible',
			removeClassAfterAnimation: false,
			offset: 100,
			repeat: false,
			invertBottomOffset: true,
			callbackFunction: function(elem, action){},
			scrollHorizontal: false,
			scrollBox: window
		};
		$.extend(options, useroptions);

		// Cache the given element and height of the browser
		var $elem = this,
			boxSize = {height: $(options.scrollBox).height(), width: $(options.scrollBox).width()},
			scrollElem = ((navigator.userAgent.toLowerCase().indexOf('webkit') != -1 || navigator.userAgent.toLowerCase().indexOf('windows phone') != -1) ? 'body' : 'html');

		/*
		 * Main method that checks the elements and adds or removes the class(es)
		 */
		this.checkElements = function(){
			var viewportStart, viewportEnd;

			// Set some vars to check with
			if (!options.scrollHorizontal){
				viewportStart = $(scrollElem).scrollTop();
				viewportEnd = (viewportStart + boxSize.height);
			}
			else{
				viewportStart = $(scrollElem).scrollLeft();
				viewportEnd = (viewportStart + boxSize.width);
			}

			// Loop through all given dom elements
			$elem.each(function(){
				var $obj = $(this),
					objOptions = {},
					attrOptions = {};

				//  Get any individual attribution data
				if ($obj.data('vp-add-class'))
					attrOptions.classToAdd = $obj.data('vp-add-class');
				if ($obj.data('vp-remove-class'))
					attrOptions.classToRemove = $obj.data('vp-remove-class');
				if ($obj.data('vp-add-class-full-view'))
					attrOptions.classToAddForFullView = $obj.data('vp-add-class-full-view');
				if ($obj.data('vp-keep-add-class'))
					attrOptions.removeClassAfterAnimation = $obj.data('vp-remove-after-animation');
				if ($obj.data('vp-offset'))
					attrOptions.offset = $obj.data('vp-offset');
				if ($obj.data('vp-repeat'))
					attrOptions.repeat = $obj.data('vp-repeat');
				if ($obj.data('vp-scrollHorizontal'))
					attrOptions.scrollHorizontal = $obj.data('vp-scrollHorizontal');
				if ($obj.data('vp-invertBottomOffset'))
					attrOptions.scrollHorizontal = $obj.data('vp-invertBottomOffset');

				// Extend objOptions with data attributes and default options
				$.extend(objOptions, options);
				$.extend(objOptions, attrOptions);

				// If class already exists; quit
				if ($obj.data('vp-animated') && !objOptions.repeat){
					return;
				}

				// Check if the offset is percentage based
				if (String(objOptions.offset).indexOf("%") > 0)
					objOptions.offset = (parseInt(objOptions.offset) / 100) * boxSize.height;

				// Get the raw start and end positions
				var rawStart = (!objOptions.scrollHorizontal) ? $obj.offset().top : $obj.offset().left,
					rawEnd = (!objOptions.scrollHorizontal) ? rawStart + $obj.height() : rawStart + $obj.width();

				// Add the defined offset
				var elemStart = Math.round( rawStart ) + objOptions.offset,
					elemEnd = (!objOptions.scrollHorizontal) ? elemStart + $obj.height() : elemStart + $obj.width();

				if (objOptions.invertBottomOffset)
					elemEnd -= (objOptions.offset * 2);

				// Add class if in viewport
				if ((elemStart < viewportEnd) && (elemEnd > viewportStart)){

					// Remove class
					$obj.removeClass(objOptions.classToRemove);
					$obj.addClass(objOptions.classToAdd);

					// Do the callback function. Callback wil send the jQuery object as parameter
					objOptions.callbackFunction($obj, "add");

					// Check if full element is in view
					if (rawEnd <= viewportEnd && rawStart >= viewportStart)
						$obj.addClass(objOptions.classToAddForFullView);
					else
						$obj.removeClass(objOptions.classToAddForFullView);

					// Set element as already animated
					$obj.data('vp-animated', true);

					if (objOptions.removeClassAfterAnimation) {
						$obj.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
							$obj.removeClass(objOptions.classToAdd);
						});
					}

				// Remove class if not in viewport and repeat is true
				} else if ($obj.hasClass(objOptions.classToAdd) && (objOptions.repeat)){
					$obj.removeClass(objOptions.classToAdd + " " + objOptions.classToAddForFullView);

					// Do the callback function.
					objOptions.callbackFunction($obj, "remove");

					// Remove already-animated-flag
					$obj.data('vp-animated', false);
				}
			});

		};

		/**
		 * Binding the correct event listener is still a tricky thing.
		 * People have expierenced sloppy scrolling when both scroll and touch
		 * events are added, but to make sure devices with both scroll and touch
		 * are handles too we always have to add the window.scroll event
		 *
		 * @see  https://github.com/dirkgroenen/jQuery-viewport-checker/issues/25
		 * @see  https://github.com/dirkgroenen/jQuery-viewport-checker/issues/27
		 */

		// Select the correct events
		if( 'ontouchstart' in window || 'onmsgesturechange' in window ){
			// Device with touchscreen
			$(document).bind("touchmove MSPointerMove pointermove", this.checkElements);
		}

		// Always load on window load
		$(options.scrollBox).bind("load scroll", this.checkElements);

		// On resize change the height var
		$(window).resize(function(e){
			boxSize = {height: $(options.scrollBox).height(), width: $(options.scrollBox).width()};
			$elem.checkElements();
		});

		// trigger inital check if elements already visible
		this.checkElements();

		// Default jquery plugin behaviour
		return this;
	};
})(eds3_5_jq);