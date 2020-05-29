(function ($, window) {
	'use strict';

	var defaultOptions = {
		portalId: 0,
		moduleId: 0,
		tabId: 0,
		autoplayVideo: false,
		userLoggedIn: false,
		googleReCaptchaSiteKey: '',
		websiteRoot: '',
		portfolioMode: false,
		openAt: 0,
		wrapperResizeDuration: 200,
		flowplayerSwf: '',
		flowplayer: {
			key: '',
			logo: ''
		},
		socialButtons: {
			facebook: false,
			gplus: false,
			twitter: false,
			inshare: false,
			pinterest: false
		},
		cssClass: '',
		events: {
			onBeforeClose: function () { }
		},
		comments: {
			requireAuthorInfo: true,
			useReCaptcha: false,
			permissions: {
				show: false,
				commenting: false
			}
		},
		like: {
			permissions: {
				liking: false
			}
		},
		mobile: false,
		i18n: {}
	},

		ajaxState = {
			UNSET: 0,
			SENT: 1,
			DONE: 2
		},

		activeClass = 'activeElement',
		imageNotLoadedClass = 'imageNotLoaded',
		smbLightBodyClass = 'smbLightFixed',

		audioItemTypeClass = 'audioItem',
		videoItemTypeClass = 'videoItem',
		imageItemTypeClass = 'imageItem',
		positionAnimationClass = 'positionAnimation',
		swipeAnimationClass = 'swipeAnimation',
		itemDomInitKey = 'initialized',

		emailVerification = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,

		preloadImage = function (itemIndex, callback) {
			var self = this,
				item = self.items[itemIndex];
			if (!item)
				return;

			if (item.type != 'image')
				return;

			var imageMeta = self.images[item.src];

			if (imageMeta) {
				if (typeof callback == 'function') {
					if (imageMeta.stats.preloadFinished)
						callback(imageMeta.stats);
					else
						imageMeta.callbacks.push(callback);
				}

				return;
			}

			imageMeta = self.images[item.src] = {
				callbacks: [],
				stats: {
					preloadFinished: false,
					isLoaded: false,
					width: 0,
					height: 0
				}
			};

			if (typeof callback == 'function')
				imageMeta.callbacks.push(callback);

			var $img = $('<img class="smbLightImage_' + item.id + '" />');

			$img.imagesLoaded()
				.progress(function (instance, imageInfo) {
					if (self.viewClosed)
						return;

					var imageMeta = self.images[item.src];

					imageMeta.stats.preloadFinished = true;
					imageMeta.stats.isLoaded = imageInfo.isLoaded;

					if (!self.smbPlus && imageInfo.isLoaded)
						self.$imagesWrapper.append($img);

					imageMeta.stats.width = $img.width();
					imageMeta.stats.height = $img.height();

					if (self.smbPlus) {
						$img.css(getItemDimensions.call(self, imageMeta.stats.width, imageMeta.stats.height, false));

						$img.parent().removeClass('loading');
					} else {
						var currentItem = self.items[self.currentItemIndex];

						if (currentItem.type == 'image' && currentItem.src == item.src) {
							self.initialItemLoaded = true;
							showItem.call(self);
						}
					}

					$img = null;

					for (var i = 0, l = imageMeta.callbacks.length; i < l; i++) {
						imageMeta.callbacks[i](imageMeta.stats);
					}
				});

			if (self.smbPlus) {
				$img.appendTo($('> div.item_' + itemIndex, self.$contentWrapper));
			}

			$img.attr('src', item.src);
		},

		preloadImages = function () {
			var self = this,
				i = 0,
				numberOfItems = self.items.length;

			for (; i < numberOfItems; i++) {
				preloadImage.call(self, i);
			};
		},

		getItemDimensions = function (itemWidth, itemHeight, maximizeDimensions, fixedHeight) {
			var self = this,

				containerRatio,
				itemRatio,

				maxItemWidth = self.overlayWidth - self.main.horizontalSpace,
				maxItemHeight = self.overlayHeight - self.main.verticalSpace,
				displayWidth = itemWidth,
				displayHeight = itemHeight;

			if (maximizeDimensions || itemWidth > maxItemWidth || itemHeight > maxItemHeight) {
				containerRatio = maxItemWidth / maxItemHeight;
				itemRatio = itemWidth / itemHeight;

				displayWidth = maxItemWidth;
				displayHeight = maxItemHeight;

				if (itemRatio < containerRatio) {
					displayWidth = Math.round(maxItemHeight / itemHeight * itemWidth);
				} else if (itemRatio > containerRatio) {
					displayHeight = Math.round(maxItemWidth / itemWidth * itemHeight);
				}
			}

			if (fixedHeight)
				displayHeight = itemHeight;

			return {
				width: displayWidth,
				height: displayHeight,
				top: Math.floor((maxItemHeight - displayHeight) / 2),
				left: Math.floor((maxItemWidth - displayWidth) / 2)
			};
		},

		setItemDimensions = function (itemDimensions) {
			var self = this,

				resizeFinished = function () {
					self.$loadingOverlay
						.stop(true)
						.fadeTo(200, 0, function () {
							self.$loadingOverlay.css('display', 'none');
						});

					setItemInfo.call(self);
				},

				doResize = function (properties, complete) {
					if (self.options.wrapperResizeDuration == 0) {
						self.$mainWrapper.css(properties);
						complete();
					} else {
						self.$mainWrapper
							.stop(true)
							.animate(
								properties,
								{
									duration: self.options.wrapperResizeDuration,
									complete: function () {
										self.$mainWrapper.css('overflow', '');
										complete();
									}
								}
							);
					}
				},

				resizeHeight = function () {
					if (self.$mainWrapper.height() != itemDimensions.height)
						doResize(
							{
								height: itemDimensions.height,
								top: itemDimensions.top
							},
							resizeFinished
						);
					else
						resizeFinished();
				};

			self.$loadingOverlay.removeClass('inProgress');

			if (self.$mainWrapper.width() != itemDimensions.width)
				doResize(
					{
						width: itemDimensions.width,
						left: itemDimensions.left
					},
					resizeHeight
				);
			else
				resizeHeight();
		},

		showImage = function (currentItem) {
			var self = this,
				imageInfo = self.images[currentItem.src].stats,
				width,
				height;

			if (!imageInfo.preloadFinished)
				return;

			self.$mainWrapper.addClass(imageItemTypeClass);

			$('> img', self.$imagesWrapper)
				.removeClass(activeClass)
				.filter('.smbLightImage_' + currentItem.id)
					.addClass(activeClass);

			if (imageInfo.isLoaded) {
				width = imageInfo.width;
				height = imageInfo.height;
			} else {
				width = 400;
				height = 400;

				self.$imagesWrapper.addClass(imageNotLoadedClass);
			}

			self.$imagesWrapper.addClass(activeClass);

			setItemDimensions.call(
				self,
				getItemDimensions.call(self, width, height)
			);
		},

		showVideo = function (currentItemIndex) {
			var self = this,
				videoHtml = '',
				videoType = '',
				currentItem = self.items[currentItemIndex];

			if (!self.smbPlus)
				self.$mainWrapper.addClass(videoItemTypeClass);

			switch (currentItem.source) {
				case 'youtube':
					videoHtml = '<iframe src="//www.youtube.com/embed/' +
						currentItem.videoId + (self.options.autoplayVideo ? '?autoplay=1' : '') +
						'" frameborder="0" allowfullscreen></iframe>';
					break;

				case 'vimeo':
					videoHtml = '<iframe src="//player.vimeo.com/video/' +
						currentItem.videoId + (self.options.autoplayVideo ? '?autoplay=1' : '') +
						'" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>';
					break;

				case 'wistia':
					videoHtml = '<iframe name="wistia_embed" src="//fast.wistia.net/embed/iframe/' +
						currentItem.videoId +
						'" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>';
					break;

				case 'flowplayer':
					if (stringEndsWith(currentItem.src, '.mp4')) {
						videoType = 'video/mp4';
					} else if (stringEndsWith(currentItem.src, '.webm')) {
						videoType = 'video/webm';
					} else if (stringEndsWith(currentItem.src, '.ogg')) {
						videoType = 'video/ogg';
					} else if (stringEndsWith(currentItem.src, '.flv')) {
						videoType = 'video/flash';
					}

					videoHtml = '<div class="flowplayerContainer"></div>';
			}

			var $playerContainer = self.$audioVideo;

			if (self.smbPlus) {
				if (currentItem.source != 'flowplayer')
					videoHtml = '<div>' + videoHtml + '</div>';

				$playerContainer = $('> div.item_' + self.currentItemIndex, self.$contentWrapper);
			} else
				$playerContainer.addClass(activeClass);

			$playerContainer
				.html(videoHtml)
				.removeClass('loading');

			if (currentItem.source == 'flowplayer')
				$('> .flowplayerContainer', $playerContainer)
					.flowplayer({
						swf: self.options.flowplayerSwf,
						ratio: currentItem.height / currentItem.width,
						autoplay: self.options.autoplayVideo,
						tooltip: false,
						embed: false,
						clip: {
							sources: [
								{
									type: videoType,
									src: currentItem.src
								}
							]
						},
						key: self.options.flowplayer.key,
						logo: self.options.flowplayer.logo
					});

			var playerCss = getItemDimensions.call(self, currentItem.width, currentItem.height, true);

			if (self.smbPlus)
				$('>', $playerContainer).css(playerCss);
			else
				setItemDimensions.call(
					self,
					playerCss
				);

			self.initialItemLoaded = true;
		},

		showAudio = function (currentItem) {
			var self = this;

			if (!self.smbPlus)
				self.$mainWrapper.addClass(audioItemTypeClass);

			var $playerContainer = self.$audioVideo,
				audioHtml = '<audio src="' + currentItem.src + '" />',
				selector = '> audio';

			if (self.smbPlus) {
				audioHtml = '<div>' + audioHtml + '</div>';
				selector = '> div > audio';
				$playerContainer = $('> div.item_' + self.currentItemIndex, self.$contentWrapper);
			} else
				$playerContainer.addClass(activeClass);

			$playerContainer
				.html(audioHtml)
				.removeClass('loading');

			audiojs.create($(selector, $playerContainer)[0]);

			var playerCss = getItemDimensions.call(self, 460, 36, false, true);

			if (self.smbPlus)
				$('>', $playerContainer).css(playerCss);
			else
				setItemDimensions.call(
					self,
					playerCss
				);

			self.initialItemLoaded = true;
		},

		setItemInfo = function () {
			var self = this,
				currentItem = self.items[self.currentItemIndex];

			if (typeof currentItem.title == 'string' && currentItem.title != '')
				self.$itemTitle
					.html(currentItem.title)
					.stop(true)
					.fadeTo(200, 1);

			if (
				(
					self.options.socialButtons.facebook
					|| self.options.socialButtons.twitter
					|| self.options.socialButtons.gplus
					|| self.options.socialButtons.inshare
					|| (self.options.socialButtons.pinterest && currentItem.type == 'image')
				)
				&& typeof currentItem.socialUrl == 'string'
				&& currentItem.socialUrl != ''
			)
				self.$socialButtonsTrigger.css('display', '');
			else
				self.$socialButtonsTrigger.css('display', 'none');
		},

		validItemIndex = function (index) {
			var numberOfItems = this.items.length;

			if (index < 0)
				index = numberOfItems - 1;
			else if (index >= numberOfItems)
				index = 0;

			return index;
		},

		showItem = function () {
			var self = this;

			self.$itemTitle
				.text('')
				.stop(true)
				.fadeTo(0, 0);

			self.$socialButtonsTrigger.removeClass('show');
			self.$socialButtonsWrapper
				.removeClass('show')
				.html('');

			self.currentItemIndex = validItemIndex.call(self, self.currentItemIndex);

			self.$root.removeClass('firstItem lastItem');

			if (self.currentItemIndex === 0)
				self.$root.addClass('firstItem');

			if (self.currentItemIndex === self.items.length - 1)
				self.$root.addClass('lastItem');

			if (self.smbPlus) {
				var prevItemIndex = validItemIndex.call(self, self.currentItemIndex - 1),
					nextItemIndex = validItemIndex.call(self, self.currentItemIndex + 1);

				$(
					'> div.videoItem.item_' + prevItemIndex + ',' +
					'> div.audioItem.item_' + prevItemIndex + ',' +
					'> div.videoItem.item_' + nextItemIndex + ',' +
					'> div.audioItem.item_' + nextItemIndex,
					self.$contentWrapper
				)
					.html('');

				setItemInfo.call(self);
			}

			var item = self.items[self.currentItemIndex],
				itemTypeClass = 'imageActive';

			if (item.type == 'video')
				itemTypeClass = 'videoActive';
			else if (item.type == 'audio')
				itemTypeClass = 'audioActive';

			self.$root
				.removeClass('imageActive videoActive audioActive')
				.addClass(itemTypeClass);

			self.showItem();
		},

		size = function () {
			var self = this;

			if (self.smbPlus) {
				var windowHeight = self.$window.height();

				if (window.innerHeight)
					windowHeight = window.innerHeight;

				windowHeight += 1;

				self.$root.height(windowHeight);
				self.overlayWidth = self.$root.width();
				self.overlayHeight = windowHeight;
			} else {
				self.overlayWidth = self.$contentWrapper.width();
				self.overlayHeight = self.$contentWrapper.height();
			}

			self.center();
		},

		swipe = function (indexModifier) {
			var self = this;

			if (
				self.skipGestures ||
				indexModifier == -1 && self.currentItemIndex == 0 ||
				indexModifier == 1 && self.currentItemIndex == this.items.length - 1
			)
				return;

			self.skipGestures = true;

			var newX = -self.currentItemIndex * self.overlayWidth;

			if (indexModifier == 1)
				newX -= self.overlayWidth;
			else
				newX += self.overlayWidth;

			self.$contentWrapper
				.removeClass(positionAnimationClass)
				.addClass(swipeAnimationClass)
				.css({
					transform: 'translate3d(' + newX + 'px, 0, 0)'
				});

			setTimeout(function () {
				self.currentItemIndex += indexModifier;
				showItem.call(self);

				self.skipGestures = false;
			}, 250);
		},

		showPrevItem = function () {
			var self = this;

			if (!self.initialItemLoaded)
				return;

			if (self.smbPlus) {
				swipe.call(self, -1);

				return;
			}

			self.currentItemIndex -= 1;
			showItem.call(self);
		},

		showNextItem = function () {
			var self = this;

			if (!self.initialItemLoaded)
				return;

			if (self.smbPlus) {
				swipe.call(self, 1);

				return;
			}

			self.currentItemIndex += 1;
			showItem.call(self);
		},

		close = function () {
			var self = this;

			if (
				typeof self.options.events.onBeforeClose == 'function' &&
				self.options.events.onBeforeClose({
				activeItem: self.currentItemIndex,
				displayItems: self.items
			}) === false
			)
				return;

			self.$document.off('.smbLightEvent');
			self.$window.off('.smbLightEvent');

			self.viewClosed = true;

			self.$root
				.stop(true)
				.fadeOut(200, function () {
					self.$root.remove();

					self.$body.removeClass(smbLightBodyClass);
				});

			if (self.smbPlus) {
				if (self.oldViewportMetaContent === undefined)
					self.$viewportMeta.remove();
				else
					self.$viewportMeta.attr('content', self.oldViewportMetaContent);

				if (self.oldIeTapHighlight === undefined)
					self.$ieTapHighlight.remove();
				else
					self.$ieTapHighlight.attr('content', self.oldIeTapHighlight);
			}
		},

		inFullscreenMode = function () {
			if (document.fullscreenElement && document.fullscreenElement != null)
				return true;
			else if (document.mozFullScreenElement && document.mozFullScreenElement != null)
				return true;
			else if (document.webkitFullscreenElement && document.webkitFullscreenElement != null)
				return true;

			return false;
		},

		eventListener = function (events, callback) {
			var el = this,
				registerEvent = function (ev) {
					if (el.addEventListener)
						el.addEventListener(ev, callback, false);
					else if (el.attachEvent)
						el.attachEvent(ev, callback);
				},
				eventsArray,
				i,
				l;

			if (events.indexOf(' ') == -1) {
				registerEvent(events);
				return;
			}

			eventsArray = events.split(' ');
			i = 0;
			l = eventsArray.length;

			for (; i < l; i++) {
				if (eventsArray[i] == '')
					break;

				registerEvent(eventsArray[i])
			}
		},

		stringEndsWith = function (s, e) {
			return s.indexOf(e, s.length - e.length) !== -1;
		},

		updateCommentsUi = function () {
			var self = this,
				currentItem = self.items[self.currentItemIndex],
				itemCommentMeta = self.comments[currentItem.id],
				commentsHtml = '';

			self.$mainCommentsCount.text(itemCommentMeta.count);
			self.$internalCommentsCount.text(itemCommentMeta.count);

			if (itemCommentMeta.cache.comments.length == 0) {
				self.$commentList.html('');
				self.$commentsModal.addClass('noComments');

				return;
			}

			self.$commentsModal.removeClass('noComments');

			$.each(itemCommentMeta.cache.comments, function () {
				var author = itemCommentMeta.cache.authors[this.author],
					encodedAuthorUrl = encodeURI(author.url),
					commentHtml =
						'<li>' +
							'<a class="authorAvatar" href="' + encodedAuthorUrl + '"><img src="' + encodeURI(author.avatar) + '" alt="" /></a>' +
							'<a class="author" href="' + encodedAuthorUrl + '">' + $('<p />').text(author.name).html() + '</a>' +
							'<div>' + this.content + '</div>' +
							'<p class="datetime">' + this.dateHtml + '</p>' +
						'</li>';

				if (self.commentSorting == 'asc')
					commentsHtml += commentHtml;
				else
					commentsHtml = commentHtml + commentsHtml;
			});

			self.$commentList.html(commentsHtml);
		},

		initEnviroment = function (items, options) {
			var self = this;

			self.$body = $('body');

			if (self.$body.hasClass(smbLightBodyClass) || items.length == 0)
				return false;

			self.$body.addClass(smbLightBodyClass);

			self.$window = $(window);
			self.$document = $(document);
			self.initialItemLoaded = false;
			self.viewClosed = false;
			self.items = items;
			self.options = $.extend(true, {}, defaultOptions, options);

			self.currentItemIndex = self.options.openAt;

			if (self.currentItemIndex < 0 || self.currentItemIndex >= items.length)
				self.currentItemIndex = 0;

			self.images = {};

			return true;
		},

		postInit = function () {
			var self = this;

			self.$window
				.on('resize.smbLightEvent', function () {
					if (self.comments) {
						var currentItem = self.items[self.currentItemIndex],
							itemCommentMeta = self.comments ? self.comments[currentItem.id] : undefined;

						if (self.desktopVersion && itemCommentMeta && itemCommentMeta.state.open)
							self.$root.width(self.$window.width() - self.$commentsModal.outerWidth(true));
					}
					size.call(self);
				});

			self.$document
				.on('keyup.smbLightEvent', function (e) {
					switch (e.keyCode) {
						case 37:
							showPrevItem.call(self);
							break;

						case 39:
							showNextItem.call(self);
							break;

						case 27:
							if (self.commentsOpened) {
								self.closeComments();
								return false;
							}

							close.call(self);
							break;

						default:
					}

					return false;
				});

			self.$root
				.on('click', '.navigation', function () {
					if (self.$root.hasClass('initializing'))
						return;

					if ($(this).hasClass('prev'))
						showPrevItem.call(self);
					else
						showNextItem.call(self);
				})
				.on('click', '.close', function () {
					close.call(self);
				});

			self.$socialButtonsTrigger.on('click', function () {
				if (self.$root.hasClass('initializing'))
					return;

				var currentItem = self.items[self.currentItemIndex];

				var encodedUri = encodeURIComponent(currentItem.socialUrl);
				var escapedTitle = '';
				var encodedTitle = '';
				var twitterTitle = '';

				if (typeof currentItem.title == 'string' && currentItem.title != '') {
					twitterTitle = escapedTitle = currentItem.title
						.replace(/&/g, '&amp;')
						.replace(/"/g, '&quot;')
						.replace(/'/g, '&#39;')
						.replace(/</g, '&lt;')
						.replace(/>/g, '&gt;');

					twitterTitle += ' ' + currentItem.socialUrl
						.replace(/&/g, '&amp;')
						.replace(/"/g, '&quot;')
						.replace(/'/g, '&#39;')
						.replace(/</g, '&lt;')
						.replace(/>/g, '&gt;');

					encodedTitle = encodeURIComponent(currentItem.title);
				}

				var socialButtonsHtml = '';

				if (self.options.socialButtons.facebook)
					socialButtonsHtml = '<div><iframe src="//www.facebook.com/plugins/like.php?href=' + encodedUri + '&amp;width&amp;layout=button_count&amp;action=like&amp;show_faces=false&amp;share=false&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:21px; width: 135px;" allowTransparency="true"></iframe></div>';

				if (self.options.socialButtons.twitter)
					socialButtonsHtml += '<div><a href="//twitter.com/share" class="twitter-share-button" data-url="' + encodedUri + '" data-text="' + twitterTitle + '">Tweet</a><script type="text/javascript">twttr.widgets.load();</script></div>';

				if (self.options.socialButtons.gplus)
					socialButtonsHtml += '<div><div class="g-plusone" data-size="medium" data-href="' + currentItem.socialUrl + '"></div><script type="text/javascript">gapi.plusone.go();</script></div>';

				if (self.options.socialButtons.inshare)
					socialButtonsHtml += '<div><script type="IN/Share" data-url="' + currentItem.socialUrl + '" data-counter="right"></script><script type="text/javascript">if (IN.parse) IN.parse();</script></div>';

				if (self.options.socialButtons.pinterest && currentItem.type == 'image')
					socialButtonsHtml += '<div><a href="//www.pinterest.com/pin/create/button/?url=' + encodedUri + '&media=' + encodeURIComponent(currentItem.src) + '&description=' + encodedTitle + '" data-pin-do="buttonPin" data-pin-config="beside"><img src="//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_gray_20.png" /></a></div>';

				if (socialButtonsHtml == '')
					return;

				self.$socialButtonsWrapper
					.toggleClass('show')
					.html(socialButtonsHtml);

				if (self.options.socialButtons.pinterest && currentItem.type == 'image')
					$.ajax({ url: '//assets.pinterest.com/js/pinit.js', dataType: 'script', cache: true });

				$(this).toggleClass('show');
			});
		},

		_ = function (s) {
			var self = this,
				translation = self.options.i18n[s];

			if (!translation)
				return s;

			return translation;
		};

	function Standard(items, options) {
		var self = this,
			currentItem,
			controlsHtml = '';

		if (!initEnviroment.call(self, items, options))
			return;

		self.$root = $('<div class="smbLightOverlayWrapper initializing"><div class="contentWrapper" /></div>');
		self.$root.addClass(self.options.cssClass);

		self.$contentWrapper = $('> div.contentWrapper', self.$root);

		if (items.length > 1)
			controlsHtml = '<span class="navigation prev"><span /></span>' +
				'<span class="navigation next"><span /></span>';

		controlsHtml += '<span class="close"><span /></span>' +
			'<div class="socialButtonsWrapper"></div>' +
			'<span class="actions socialButtonsTrigger"><span>' + _.call(self, 'Share') + '</span></span>';

		self.$mainWrapper = $(
			'<div class="mainWrapper">' +
				'<div class="viewWrapper">' +
					'<div class="images"><p>' + _.call(self, 'This image is currently unavailable') + '</p></div>' +
					'<div class="audioVideo" />' +
				'</div>' +
				controlsHtml +
			'</div>'
		)
			.appendTo(self.$contentWrapper);

		self.$itemTitle = $('<h2 class="itemTitle" />').appendTo(self.$mainWrapper);
		self.$loadingOverlay = $('<div class="loadingOverlay inProgress" />').appendTo(self.$mainWrapper);
		self.$imagesWrapper = $('> .viewWrapper > .images', self.$mainWrapper);
		self.$audioVideo = $('> .viewWrapper > .audioVideo', self.$mainWrapper);
		self.$socialButtonsWrapper = $('.socialButtonsWrapper', self.$mainWrapper);
		self.$socialButtonsTrigger = $('.socialButtonsTrigger', self.$mainWrapper);

		currentItem = self.items[self.currentItemIndex];
		if (currentItem.type == 'image') {
			preloadImage.call(
				self,
				self.currentItemIndex,
				function () {
					preloadImages.call(self);
				}
			);
		} else {
			preloadImages.call(self);
		}

		self.$root.appendTo(self.$body);

		self.main = {
			horizontalSpace: self.$mainWrapper.outerWidth(true) - self.$mainWrapper.width(),
			verticalSpace: self.$mainWrapper.outerHeight(true) - self.$mainWrapper.height()
		};

		size.call(self);

		self.$root
			.fadeTo(
				200,
				1,
				function () {
					if (currentItem.type == 'image')
						return;

					showItem.call(self);
				}
			);

		postInit.call(self);

		return self;
	}

	Standard.prototype = {
		center: function () {
			var self = this,
				css = {},
				currentItem,
				imageInfo,
				dimensionsSet = false,

				width = 0,
				height = 0,
				maximizeItem = false,
				fixedHeight = false;

			if (self.initialItemLoaded) {
				currentItem = self.items[self.currentItemIndex];

				switch (currentItem.type) {
					case 'image':
						imageInfo = self.images[currentItem.src].stats;

						if (imageInfo.isLoaded) {
							width = imageInfo.width;
							height = imageInfo.height;
						} else {
							width = 400;
							height = 400;
						}
						break;

					case 'video':
						width = currentItem.width;
						height = currentItem.height;
						maximizeItem = true;
						break;

					case 'audio':
						width = 460;
						height = 36;
						fixedHeight = true;
						break;
				}

				css = getItemDimensions.call(self, width, height, maximizeItem, fixedHeight);

				dimensionsSet = true;
			}

			if (!dimensionsSet) {
				css.width = self.$mainWrapper.width();
				css.height = self.$mainWrapper.height();

				css.left = Math.floor((self.overlayWidth - (css.width + self.main.horizontalSpace)) / 2);
				css.top = Math.floor((self.overlayHeight - (css.height + self.main.verticalSpace)) / 2);
			}

			self.$mainWrapper
				.stop(true)
				.css(css);
		},
		showItem: function () {
			var self = this;

			self.$imagesWrapper.removeClass(imageNotLoadedClass);

			self.$loadingOverlay
				.addClass('inProgress')
				.stop(true)
				.fadeTo(0, 1, function () {
					self.$loadingOverlay.css('display', '');
				});

			self.$audioVideo.html('');

			$('> .viewWrapper > div', self.$mainWrapper).removeClass(activeClass);

			self.$mainWrapper
				.removeClass(audioItemTypeClass)
				.removeClass(videoItemTypeClass)
				.removeClass(imageItemTypeClass);

			var currentItem = self.items[self.currentItemIndex];

			switch (currentItem.type) {
				case 'image':
					showImage.call(self, currentItem);
					break;

				case 'video':
					showVideo.call(self, self.currentItemIndex);
					break;

				case 'audio':
					showAudio.call(self, currentItem);
					break;

				default:
					self.initialItemLoaded = true;
			}

			if (self.initialItemLoaded)
				self.$root.removeClass('initializing');
		}
	};

	function Mobile(items, options) {
		var self = this,
			currentItem,
			touch = {
				newTouch: false,
				startX: 0
			},
			controlsHtml = '';

		self.smbPlus = true;

		if (!initEnviroment.call(self, items, options))
			return;

		self.options.wrapperResizeDuration = 0;

		self.$viewportMeta = $('meta[name="viewport"]');
		self.oldViewportMetaContent = undefined;

		if (self.$viewportMeta.length > 0) {
			self.oldViewportMetaContent = self.$viewportMeta.attr('content');
			self.$viewportMeta.attr('content', 'user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1');
		} else
			self.$viewportMeta = $('<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1" />').appendTo($('head'));

		self.$ieTapHighlight = $('meta[name="msapplication-tap-highlight"]');
		self.oldIeTapHighlight = undefined;

		if (self.$ieTapHighlight.length > 0) {
			self.oldIeTapHighlight = self.$ieTapHighlight.attr('content');
			self.$ieTapHighlight.attr('content', 'no');
		} else
			self.$ieTapHighlight = $('<meta name="msapplication-tap-highlight" content="no" />').appendTo($('head'));

		self.$root = $(
			'<div class="smbLightOverlayWrapper smbPlus initializing">' +
				'<div class="contentWrapper"></div>' +
			'</div>'
		)
			.addClass(self.options.cssClass);

		if (!/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase())) {
			self.$root.addClass('desktopUserAgent');
			self.desktopVersion = true;
		}

		self.$contentWrapper = $('> div.contentWrapper', self.$root);

		controlsHtml = '<div class="mobileOverlay" /><div class="modalOverlay" />';

		if (items.length > 1)
			controlsHtml += '<span class="navigation prev"><span /></span>' +
				'<span class="navigation next"><span /></span>';

		controlsHtml += '<span class="close"><span /></span>' +
			'<div class="socialButtonsWrapper"></div>' +
			'<span class="actions socialButtonsTrigger"><span>' + _.call(self, 'Share') + '</span></span>';

		self.$root.append(controlsHtml);

		self.$itemTitle = $('<h2 class="itemTitle" />').appendTo(self.$root);
		self.$socialButtonsWrapper = $('.socialButtonsWrapper', self.$root);
		self.$socialButtonsTrigger = $('.socialButtonsTrigger', self.$root);
		self.$modalOverlay = $('> .modalOverlay', self.$root);

		if (self.options.comments.permissions.show) {
			self.comments = {};
			self.$root.append(
				'<span class="actions commentsTrigger"><span>0</span></span>' +
				'<div class="commentsModalWrapper">' +
					'<div class="main">' +
						'<div class="top">' +
							'<span class="comments">0</span>' +
							'<span class="likes">0</span>' +
							'<span class="sort">' + _.call(self, 'Sort') + '</span>' +
						'</div>' +
						'<ul />' +
						'<p class="noComments">' + _.call(self, 'No comments yet') + '</p>' +
						'<div class="newCommentWrapper">' +
							'<textarea placeholder="' + _.call(self, 'Write a comment') + '"></textarea>' +
							'<button>' + _.call(self, 'Post') + '</button>' +
						'</div>' +
					'</div>' +
					'<div class="anonymCommentWrapper">' +
						'<p>' + _.call(self, 'Add a comment') + '</p>' +
						'<div class="authorName"><input type="text" placeholder="' + _.call(self, 'Name') + '" /></div>' +
						'<div class="authorEmail"><input type="text" placeholder="' + _.call(self, 'Email') + '" /></div>' +
						'<div class="authorTextarea"><textarea placeholder="' + _.call(self, 'Write a comment') + '"></textarea></div>' +
						(self.options.comments.requireAuthorInfo && self.options.comments.useReCaptcha
							? '<div class="captchaContainer"><p class="captchaError">' + _.call(self, 'Please solve the test correctly.') + '</p><div class="captcha"></div></div>'
							: ''
						) +
						'<div class="actions"><button class="cancel">' + _.call(self, 'Cancel') + '</button><button class="post">' + _.call(self, 'Post') + '</button></div>' +
					'</div>' +
					'<span class="closeComments">' + _.call(self, 'Hide') + '</span>' +
					'<p class="loading">' + _.call(self, 'Loading comments') + '</p>' +
				'</div>'
			);
			self.$commentsTrigger = $('> .actions.commentsTrigger', self.$root);
			self.$mainCommentsCount = $('> span', self.$commentsTrigger);
			self.$commentsModal = $('> .commentsModalWrapper', self.$root);
			self.$commentsMainWrapper = $('> .main', self.$commentsModal);
			self.$newCommentWrapper = $('> .newCommentWrapper', self.$commentsMainWrapper);
			self.$newCommentInput = $('> textarea', self.$newCommentWrapper);
			self.$newCommentButton = $('> button', self.$newCommentWrapper);
			self.$commentsTopBar = $('> .top', self.$commentsMainWrapper);
			self.$internalCommentsCount = $('> .comments', self.$commentsTopBar);
			self.$commentsLikes = $('> .likes', self.$commentsTopBar);
			self.$commentsSorting = $('> .sort', self.$commentsTopBar);
			self.$commentList = $('> ul', self.$commentsMainWrapper);
			self.$anonymCommentWrapper = $('> .anonymCommentWrapper', self.$commentsModal);
			self.$anonymCommenterNameInput = $('> .authorName > input', self.$anonymCommentWrapper);
			self.$anonymCommenterEmailInput = $('> .authorEmail > input', self.$anonymCommentWrapper);
			self.$anonymCommentInput = $('> .authorTextarea > textarea', self.$anonymCommentWrapper);
			self.$anonymCommentCancel = $('> .actions > .cancel', self.$anonymCommentWrapper);
			self.$anonymCommentPost = $('> .actions > .post', self.$anonymCommentWrapper);
			self.$newCommentCaptchaContainer = $('> .captchaContainer', self.$anonymCommentWrapper);

			self.commentSorting = 'asc';

			self.addingAjaxRequest = undefined;

			self.commentsOpened = false;
			self.commentsAnimationTimeout;

			var reCaptchaId;

			self.$commentsTrigger.on('click', function () {
				if (self.desktopVersion && self.commentsOpened == true) {
					self.closeComments();
					return;
				}

				self.updateItemComments();

				if (self.desktopVersion) {
					self.commentsOpened = true;
					clearTimeout(self.commentsAnimationTimeout);

					self.$root.addClass('animateComments moveComments');

					self.commentsAnimationTimeout = setTimeout(function () {
						self.$root.removeClass('animateComments moveComments');

						self.$root.width(self.$root.width() - self.$commentsModal.outerWidth(true));
						size.call(self);
					}, 200);
				} else {
					self.$root.addClass('modalActive');

					self.$modalOverlay
						.stop(true)
						.animate(
							{
								opacity: 1
							},
							{
								duration: 200
							}
						);
				}
			});

			self.$commentsSorting.on('click', function () {
				if (self.commentSorting == 'asc')
					self.commentSorting = 'desc';
				else
					self.commentSorting = 'asc';

				self.$commentsSorting.toggleClass('desc', self.commentSorting == 'desc');

				updateCommentsUi.call(self);
			});

			self.$commentsModal.on('click', '> span.closeComments', function () {
				self.closeComments();
			});

			self.$newCommentInput
				.on('change keyup', function () {
					var val = self.$newCommentInput.val();

					self.$newCommentWrapper.toggleClass('filledIn', val !== '');
				})
				.on('focus', function () {
					if (!self.options.comments.requireAuthorInfo)
						return;

					self.$anonymCommenterNameInput
						.trigger('focus')
						.val('')
						.parent()
							.removeClass('error');
					self.$anonymCommenterEmailInput
						.val('')
						.parent()
							.removeClass('error');
					self.$anonymCommentInput
						.val('')
						.parent()
							.removeClass('error');
					self.$newCommentCaptchaContainer.removeClass('error');

					if (self.options.comments.useReCaptcha) {
						if (reCaptchaId)
							grecaptcha.reset(reCaptchaId);
						else
							reCaptchaId = grecaptcha.render($('> .captcha', self.$newCommentCaptchaContainer)[0], {
								sitekey: self.options.googleReCaptchaSiteKey,
								size: 'compact'
							});
					}

					self.$commentsModal.addClass('showAnonymWindow');
				});

			self.$anonymCommentCancel.on('click', function () {
				self.$commentsModal.removeClass('showAnonymWindow');
				self.$anonymCommentWrapper.removeClass('addingAnonComment');

				if (self.addingAjaxRequest) {
					self.addingAjaxRequest.abort();
					self.addingAjaxRequest = undefined;
				}
			});

			var submitComment = function (e, authorName, authorEmail, comment, captcha, anonComment) {
				var activeItemIndex = self.currentItemIndex,
					currentItem = self.items[activeItemIndex],
					itemCommentMeta = self.comments[currentItem.id],
					newComment = self.options.comments.requireAuthorInfo ? comment : self.$newCommentInput.val(),
					params = {
						action: 'add_comment'
					},
					error = false;

				if (newComment === '' || self.$newCommentWrapper.hasClass('addingComment'))
					return;

				self.$newCommentCaptchaContainer.removeClass('error');
				self.$newCommentInput.val('');
				self.$newCommentWrapper
					.removeClass('filledIn')
					.addClass('addingComment');

				params.comment = newComment;

				if (self.options.comments.requireAuthorInfo) {
					params.name = authorName;
					params.email = authorEmail;
				}

				if (captcha)
					params.captcha = captcha;

				self.addingAjaxRequest = $.ajax({
					data: params,
					dataType: 'json',
					type: 'POST',
					url: currentItem.comments.backend,
					timeout: 30000,
					cache: false,
					error: function () { },
					success: function (response) {
						if (response.status == undefined)
							return;

						if (response.status == 'success') {
							itemCommentMeta.cache.comments.push({
								author: response.author.id,
								content: response.comment,
								raw: newComment,
								id: response.id,
								dateHtml: response.dateHtml
							});
							itemCommentMeta.count += 1;

							if (itemCommentMeta.cache.authors[response.author.id] == undefined)
								itemCommentMeta.cache.authors[response.author.id] = {
									avatar: response.author.avatar,
									name: response.author.name,
									url: response.author.url
								};
						} else if (response.status == 'captcha_error') {
							self.$newCommentCaptchaContainer.addClass('error');
							error = true;
						}
					},
					complete: function () {
						self.addingAjaxRequest = undefined;

						if (!itemCommentMeta.state.open || activeItemIndex != self.currentItemIndex)
							return;

						if (anonComment) {
							self.$anonymCommentWrapper.removeClass('addingAnonComment');
							self.$anonymCommentPost.text(_.call(self, 'Post'));
						}

						self.$newCommentWrapper.removeClass('addingComment');

						if (error)
							return;

						if (anonComment) {
							self.$commentsModal.removeClass('showAnonymWindow');
							self.$newCommentCaptchaContainer.removeClass('error');
						}

						updateCommentsUi.call(self);
					}
				});
			};

			self.$anonymCommentPost.on('click', function () {
				var authorName = self.$anonymCommenterNameInput.val(),
					authorEmail = self.$anonymCommenterEmailInput.val(),
					comment = self.$anonymCommentInput.val(),
					hasErrors = false,
					captcha = undefined;

				self.$anonymCommenterNameInput.attr('placeholder', _.call(self, 'Name'));
				self.$anonymCommenterEmailInput.attr('placeholder', _.call(self, 'Email'));
				self.$anonymCommentInput.attr('placeholder', _.call(self, 'Write a comment'));

				self.$anonymCommenterNameInput.parent().removeClass('error');
				self.$anonymCommenterEmailInput.parent().removeClass('error');
				self.$anonymCommentInput.parent().removeClass('error');

				if (!authorName) {
					self.$anonymCommenterNameInput
						.attr('placeholder', _.call(self, 'Please specify your name'))
						.parent()
							.addClass('error');
					hasErrors = true;
				}

				if (!authorEmail || !emailVerification.test(authorEmail)) {
					self.$anonymCommenterEmailInput
						.attr('placeholder', _.call(self, 'Please specify your email'))
						.parent()
							.addClass('error');
					hasErrors = true;
				}

				if (!comment) {
					self.$anonymCommentInput
						.attr('placeholder', _.call(self, 'Please write a comment'))
						.parent()
							.addClass('error');
					hasErrors = true;
				}

				if (self.options.comments.useReCaptcha) {
					captcha = grecaptcha.getResponse(reCaptchaId);

					if (captcha.length == 0) {
						self.$newCommentCaptchaContainer.addClass('error');

						hasErrors = true;
					}
				}

				if (hasErrors) {
					return;
				}

				self.$anonymCommentWrapper.addClass('addingAnonComment');
				self.$anonymCommentPost.text(_.call(self, 'Commenting'));

				submitComment({}, authorName, authorEmail, comment, captcha, true);
			});

			self.$newCommentButton.on('click', submitComment);
		}

		if (self.options.like.permissions.liking) {
			self.$root.append('<span class="actions likeTrigger"><span>0</span></span>');

			self.$likeTrigger = $('> .actions.likeTrigger', self.$root);
			self.$mainLikeCount = $('> span', self.$likeTrigger);

			self.$likeTrigger.on('click', function () {
				if (self.$root.hasClass('initializing'))
					return;

				var activeItemIndex = self.currentItemIndex,
					currentItem = self.items[activeItemIndex],
					liked = !currentItem.likes.likedByUser,
					params = {
						portalId: self.options.portalId,
						moduleId: self.options.moduleId,
						mediaId: currentItem.id
					};

				currentItem.likes.likedByUser = liked;

				if (liked)
					currentItem.likes.numOfLikes += 1;
				else
					if (currentItem.likes.numOfLikes > 0)
						currentItem.likes.numOfLikes -= 1;

				self.$mainLikeCount.text(currentItem.likes.numOfLikes);
				self.$likeTrigger.toggleClass('liked', liked);

				if (typeof currentItem.journalId == 'number') {
					params.action = 'like';
					params.journalid = currentItem.journalId;
					params.liked = liked;
				} else {
					params.action = 'media_like';
					params.vote = liked ? 1 : -1;
				}

				$.ajax({
					data: params,
					dataType: 'json',
					type: 'POST',
					url: self.options.websiteRoot + 'DesktopModules/EasyDNNGallery/Services/SocialMediaBox.ashx',
					timeout: 10000,
					cache: false,
					error: function () { },
					success: function () { },
					complete: function () { }
				});
			});
		}

		self.$root.appendTo(self.$body);

		self.main = {
			horizontalSpace: 0,
			verticalSpace: 0
		};

		$.each(self.items, function (itemIndex) {
			var $itemDiv = $('<div />');

			$itemDiv
				.addClass('loading item_' + itemIndex)
				.data('itemIndex', itemIndex);

			if (this.type == 'image') {
				$itemDiv.addClass('imageItem');
			} else if (this.type == 'video') {
				$itemDiv.addClass('videoItem');
			} else if (this.type == 'audio') {
				$itemDiv.addClass('audioItem');
			}

			$itemDiv.appendTo(self.$contentWrapper)
		});

		size.call(self);

		self.$root.addClass('show');

		setTimeout(function () {
			showItem.call(self);
		}, 200);

		var hammerTime = new Hammer($('> .mobileOverlay', self.$root)[0]);

		self.skipGestures = false;
		var tapTimeout;

		hammerTime.on('swipeleft swiperight panleft panright panend tap', function (event) {
			var currentItemOffset = -(self.currentItemIndex * self.overlayWidth),
				deltaX = event.deltaX;

			if (event.type == 'tap') {
				clearTimeout(tapTimeout);

				if (self.$root.hasClass('hideControls')) {
					self.$root.removeClass('hideControls fadeOutControls');
				} else {
					self.$root.addClass('fadeOutControls');
					tapTimeout = setTimeout(function () {
						self.$root.addClass('hideControls');
					}, 500);
				}

				return;
			}

			if (self.skipGestures || !self.initialItemLoaded)
				return;

			if ((event.type == 'swipeleft' || event.type == 'swiperight') && items.length > 1) {
				if (event.type == 'swipeleft')
					if (self.currentItemIndex < self.items.length - 1)
						showNextItem.call(self);
					else
						if (self.currentItemIndex == 0)
							showPrevItem.call(self);

				return;
			}

			if (event.type == 'panend') {
				if (
					self.currentItemIndex == 0 && deltaX >= 0 ||
					self.currentItemIndex == self.items.length - 1 && deltaX < 0 ||
					Math.abs(deltaX) < self.overlayWidth / 2
				) {
					self.$contentWrapper
						.removeClass(swipeAnimationClass)
						.addClass(positionAnimationClass)
						.css({
							transform: 'translate3d(' + currentItemOffset + 'px, 0, 0)'
						});

					return;
				}

				self.skipGestures = true;

				var newX = -self.overlayWidth;
				var indexModifier = 1;

				if (deltaX > 0) {
					newX = self.overlayWidth;
					indexModifier = -1;
				}

				newX = currentItemOffset + newX;

				self.$contentWrapper
					.addClass(positionAnimationClass)
					.removeClass(swipeAnimationClass)
					.css({
						transform: 'translate3d(' + newX + 'px, 0, 0)'
					});

				setTimeout(function () {
					self.skipGestures = false;
					self.currentItemIndex += indexModifier;
					showItem.call(self);
				}, 550);

				return;
			}

			if (
				self.currentItemIndex == 0 && deltaX >= 0 ||
				self.currentItemIndex == self.items.length - 1 && deltaX < 0
			) {
				deltaX = 1 - Math.abs(deltaX) / self.overlayWidth;

				if (deltaX < .5) {
					deltaX = Math.round(self.overlayWidth / 4);

					if (event.deltaX < 1)
						deltaX = -deltaX;
				} else
					deltaX = Math.round(deltaX * event.deltaX);
			}

			self.$contentWrapper
				.removeClass(positionAnimationClass)
				.removeClass(swipeAnimationClass)
				.css({
					transform: 'translate3d(' + (currentItemOffset + deltaX) + 'px, 0, 0)'
				});
		});

		postInit.call(self);

		return self;
	}

	Mobile.prototype = {
		center: function () {
			var self = this,
				commentListHeight = 0;

			if (self.options.comments.permissions.show) {
				commentListHeight = $('>', self.$commentsModal).height() - self.$commentsTopBar.outerHeight(true) - self.$newCommentWrapper.outerHeight(true);

				if (commentListHeight < 0)
					commentListHeight = 0;

				self.$commentList.css('height', commentListHeight);
			};

			self.$contentWrapper
				.removeClass(positionAnimationClass)
				.removeClass(swipeAnimationClass)
				.css({
					width: self.items.length * self.overlayWidth,
					transform: 'translate3d(-' + self.currentItemIndex * self.overlayWidth + 'px, 0, 0)'
				});

			$('>', self.$contentWrapper)
				.width(self.overlayWidth)
				.each(function () {
					var $itemContainer = $(this),
						itemIndex = $itemContainer.data('itemIndex'),
						item = self.items[itemIndex];

					if ($itemContainer.hasClass('loading') || (item.type != 'image' && itemIndex != self.currentItemIndex))
						return;

					if (item.type == 'image') {
						var imageStats = self.images[item.src].stats;

						$('> img', $itemContainer).css(getItemDimensions.call(self, imageStats.width, imageStats.height, false));
					} else if (item.type == 'video') {
						$('> div', $itemContainer).css(getItemDimensions.call(self, item.width, item.height, true));
					} else if (item.type == 'audio') {
						$('> div', $itemContainer).css(getItemDimensions.call(self, 460, 36, false, true));
					}
				});
		},
		showItem: function () {
			var self = this,
				$currentDomItem = $('> div.item_' + self.currentItemIndex, self.$contentWrapper),
				thisItemIndex = self.currentItemIndex,
				currentItem = self.items[thisItemIndex],
				preloadNeighbours = function () {
					if (thisItemIndex > 0)
						preloadImage.call(
							self,
							validItemIndex.call(self, thisItemIndex - 1)
						);

					if (thisItemIndex < self.items.length - 1)
						preloadImage.call(
							self,
							validItemIndex.call(self, thisItemIndex + 1)
						);
				};

			self.$contentWrapper
				.removeClass(positionAnimationClass)
				.removeClass(swipeAnimationClass)
				.css({
					transform: 'translate3d(-' + thisItemIndex * self.overlayWidth + 'px, 0, 0)'
				});

			if (self.options.comments.permissions.show) {
				self.$newCommentInput.val('');
				self.$newCommentWrapper.removeClass('filledIn');

				if (!self.comments[currentItem.id])
					self.comments[currentItem.id] = {
						state: {
							open: false,
							commentsRequest: ajaxState.UNSET
						},
						count: currentItem.comments.count,
						cache: {
							authors: {},
							comments: []
						}
					};

				self.$mainCommentsCount.text(self.comments[currentItem.id].count);

				if (self.desktopVersion) {
					$.each(self.comments, function () {
						this.state.open = false;
					});

					self.updateItemComments();
				}
			}

			if (self.options.like.permissions.liking) {
				self.$likeTrigger.toggleClass('liked', currentItem.likes.likedByUser);
				self.$mainLikeCount.text(currentItem.likes.numOfLikes);
			}

			switch (currentItem.type) {
				case 'image':
					if ($currentDomItem.data(itemDomInitKey))
						return;

					preloadImage.call(
						self,
						thisItemIndex,
						function () {
							if (self.currentItemIndex != thisItemIndex)
								return;

							self.initialItemLoaded = true;
							preloadNeighbours();
						}
					);

					$currentDomItem.data(itemDomInitKey, true);
					break;

				case 'video':
					showVideo.call(self, self.currentItemIndex);
					break;

				case 'audio':
					showAudio.call(self, currentItem);
					break;

				default:
					self.initialItemLoaded = true;
			}

			if (currentItem.type != 'image')
				preloadNeighbours();

			self.$root.removeClass('initializing');
		},
		updateItemComments: function () {
			var self = this,
				activeItemIndex = self.currentItemIndex,
				currentItem = self.items[activeItemIndex],
				itemCommentMeta = self.comments[currentItem.id];

			if (itemCommentMeta.state.open || self.$root.hasClass('initializing'))
				return;

			itemCommentMeta.state.open = true;

			if (itemCommentMeta.state.commentsRequest == ajaxState.UNSET) {
				itemCommentMeta.state.commentsRequest = ajaxState.SENT;

				self.$commentsModal.addClass('loading');

				$.ajax({
					data: {
						action: 'list_comments'
					},
					dataType: 'json',
					type: 'GET',
					url: currentItem.comments.backend,
					timeout: 15000,
					cache: false,
					error: function () {
						itemCommentMeta.state.commentsRequest = ajaxState.UNSET;
					},
					success: function (response) {
						itemCommentMeta.cache = response;
						itemCommentMeta.count = response.comments.length;
						itemCommentMeta.state.commentsRequest = ajaxState.DONE;
					},
					complete: function () {
						if (!itemCommentMeta.state.open || activeItemIndex != self.currentItemIndex)
							return;

						self.$commentsModal.removeClass('loading');
						updateCommentsUi.call(self);
					}
				});
			} else {
				updateCommentsUi.call(self);
				self.$commentsModal.removeClass('loading');
			}

			self.$internalCommentsCount.text(itemCommentMeta.count);
			self.$commentsLikes
				.text(currentItem.likes.numOfLikes)
				.toggleClass('liked', currentItem.likes.likedByUser);
		},
		closeComments: function () {
			var self = this,
				currentItem = self.items[self.currentItemIndex],
				itemCommentMeta = self.comments[currentItem.id];

			itemCommentMeta.state.open = false;

			if (self.desktopVersion) {
				clearTimeout(self.commentsAnimationTimeout);

				self.$root.addClass('moveComments');
				self.$root.css('width', '');
				size.call(self);

				self.$root
					.addClass('animateComments')
					.removeClass('moveComments');

				self.commentsAnimationTimeout = setTimeout(function () {
					self.$root.removeClass('animateComments');
				}, 300);
			} else {
				self.$root.removeClass('modalActive');

				self.$modalOverlay
					.stop(true)
					.animate(
						{
							opacity: 0
						},
						{
							duration: 200
						}
					);
			}

			self.$commentsModal.removeClass('showAnonymWindow');
			self.$anonymCommentWrapper.removeClass('addingAnonComment');
			self.commentsOpened = false;
		}
	};

	window.SmbLight_1 = function (items, options) {
		if (!(this instanceof SmbLight_1))
			return new SmbLight_1(items, options);

		if (options.mobile)
			return new Mobile(items, options);

		return new Standard(items, options);
	}

})(eds3_5_jq, window);
