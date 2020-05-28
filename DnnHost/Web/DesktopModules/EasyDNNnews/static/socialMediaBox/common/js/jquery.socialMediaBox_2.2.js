;(function(undefined) {
var smb4JSetup = false,

getJournalInfo = function () {
	var targetIdMatch,
		targetId = 0,
		journalType = 'summary';

	targetIdMatch = location.href.match(/\/userid\/\d+\//i);
	if (targetIdMatch != null) {
		targetId = targetIdMatch[0].match(/\d+/)[0];
		journalType = 'profile';
	} else {
		targetIdMatch = location.href.match(/\/groupid\/\d+\//i);
		if (targetIdMatch != null) {
			targetId = targetIdMatch[0].match(/\d+/)[0];
			journalType = 'group';
		}
	}

	return {type: journalType, target: targetId};
},

getJournalModuleId = function ($journalContainer) {
	var matchModulId,
		moduleId = 0,
		containerClass;

	if ($journalContainer.length == 0)
		return 0;

	containerClass = $journalContainer.attr('class');

	if (typeof containerClass != 'string' || containerClass == '')
		return 0;

	$.each(containerClass.split(/\s+/), function (i, s) {
		matchModulId = s.match(/\d+$/);
		if (typeof matchModulId == 'object' && matchModulId != null) {
			moduleId = parseInt(matchModulId[0]);
			return false;
		}
	});

	return moduleId;
},

stringEndsWith = function (s, e) {
	return s.indexOf(e, s.length - e.length) !== -1;
},

lightboxInit = function($) {
	$.fn.socialMediaBox = function () {
		var lightbox = {},

			config = {
				openAt: 0,
				baseClass: '',
				localized: {},
				flowplayerSwf: '',
				flowplayer: {
					key: '',
					logo: ''
				},
				thumbnails: {
					show: true,
					width: 100,
					height: 100
				},
				itemDetails: {
					show: true,
					rightSide: true,
					comments: {
						notifySocialGroup: false,
						requireAuthorInfo: true,
						captcha: true,
						permissions: {
							commenting: true,
							editing: false,
							deleting: false
						}
					},
					socialButtons: {
						show: false,
						buttons: {
							facebook: {
								show: false,
								html: '<iframe src="//www.facebook.com/plugins/like.php?href={{encodedUrl}}&amp;send=false&amp;layout=button_count&amp;show_faces=true&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21&amp;width=110" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:21px; width: 110px;" allowTransparency="true"></iframe>'
							},
							gplus: {
								show: false,
								html: '<div class="g-plusone" data-size="medium" data-href="{{url}}"></div><script type="text/javascript">gapi.plusone.go();</script>'
							},
							twitter: {
								show: false,
								html: '<a href="//twitter.com/share" class="twitter-share-button" data-url="{{url}}" data-text="{{escapedTitle}}">Tweet</a><script type="text/javascript">twttr.widgets.load();</script>'
							},
							inshare: {
								show: false,
								html: '<script type="IN/Share" data-counter="right" data-url="{{url}}"></script><script type="text/javascript">IN.parse();</script>'
							},
							pinterest: {
								show: false,
								html: '<a href="//pinterest.com/pin/create/button/?url={{encodedUrl}}&media={{encodedMediaUrl}}&description={{encodedTitle}}" class="pin-it-button" count-layout="horizontal"><img border="0" src="//assets.pinterest.com/images/PinExt.png" title="Pin It" /></a>'
							}
						}
					}
				},
				events: {
					onBeforeClose: function () {}
				},
				googleReCaptchaSiteKey: ''
			},

			_ = function (s) {
				return typeof config.localized[s] == 'string' ? config.localized[s] : s;
			},

			$body,
			$baseWrapper,

			$thumbnailsMainWrapper,
			$thumbnailsViewport,
			$thumbnailsOverview,

			$interfaceActionsWrapper,
			$toggleInterface,

			$itemDetailsWrapper,
			$itemDetailsViewport,
			$itemDetailsOverview,
			$itemDetailsTitle,
			$itemDetailsDescription,

			$itemDetailsAuthorWrapper,
			$itemDetailsAuthorAvatarWrapper,
			$itemDetailsAuthorAvatarContainer,
			$itemDetailsAuthorName,
			$itemDetailsAuthorDate,
			$itemDetailsAuthorActions,
			$itemDetailsAuthorActionFollow,
			$itemDetailsAuthorActionFriend,
			$itemDetailsAuthorActionRejectFriend,

			$itemDetailsLikeWrapper,
			$itemDetailsLikeContainer,
			$itemDetailsLikeButton,
			$itemDetailsLikeMessage,
			$itemDetailsLikeAlsoLiked,

			$socialButtonsWrapper,

			$itemDetailsRatingWrapper,
			$itemDetailsRatingScore,
			$itemDetailsRatingMessage,
			$itemDetailsRatingStarContainer,
			$itemDetailsRatingStars,

			$itemDetailsTagContainer,

			$itemDetailsButtonsWrapper,
			$itemDetailsDownloadButton,
			$itemDetailsEmailButton,

			$itemDetailsCommentsWrapper,
			$itemDetailsCommentsMessage,
			$itemDetailsCommentsList,
			$itemDetailsCommentsLoading,
			$itemDetailsAddCommentContainer,
			$itemDetailsAddCommentTrigger,
			$itemDetailsAddCommentContent,
			$itemDetailsAddCommentMessage,
			$itemDetailsAddCommentAuthorInfoWrapper,
			$itemDetailsAddCommentAuthorInfoText,
			$itemDetailsAddCommentCaptchaContainer,

			$itemDetailsMetaWrapper,
			$itemDetailsMetaTitle,
			$itemDetailsMetaContent,

			$itemDisplayWrapper,
			$itemDisplayContainer,
			$itemDisplayLoadIndicator,

			$navigationPrevious,
			$navigationNext,

			$closeButton,

			displayItems = [],

			rendering = {
				activeItem: 0,
				resizeInProgress: false,
				resizeRace: false,
				interfaceHidden: false,
				baseWrapper: {
					height: 0,
					width: 0
				},
				thumbnails: {
					rendered: false,
					initialized: false,
					thumbActivatedChange: false,
					allThumbnailsLoaded: false,
					thumbnail: {
						height: 0,
						width: 0
					},
					wrapper: {
						height: 0,
						effectiveHeight: 0
					},
					overview: {
						width: 0
					}
				},
				interfaceActions: {
					wrapper: {
						height: 0
					}
				},
				itemDetails: {
					rendered: false,
					wrapper: {
						verticalOffset: 0,
						width: 0,
						effectiveWidth: 0
					},
					comments: {
						author: {
							avatarContainer: null
						}
					},
					maps: {
						google: null
					}
				},
				itemDisplay: {
					wrapper: {
						verticalOffset: 0,
						horizontalOffset: 0,
						height: 0,
						width: 0
					},
					touch: {
						newTouch: false,
						startX: 0,
						startY: 0
					}
				},
				preloadedImages: {},
				commentsCache: {},
				reCaptchaId: undefined
			},

			preloadingDone = function (src, successful) {
				if (successful) {
					rendering.preloadedImages[src].state = 'success';
					rendering.preloadedImages[src].width = this.naturalWidth === undefined ? this.width : this.naturalWidth;
					rendering.preloadedImages[src].height = this.naturalHeight === undefined ? this.height : this.naturalHeight;
				} else
					rendering.preloadedImages[src].state = 'error';

				clearTimeout(rendering.preloadedImages[src].timeout);
			},

			runPreloadCallbacks = function (src) {
				var callbacks = rendering.preloadedImages[src].callbacks;

				while (callbacks.length > 0)
					callbacks.splice(0, 1)[0]();

				rendering.preloadedImages[src].callbacks = [];
			}

			terminated = false;


		lightbox.preloadImage = function (src, callback) {
			var $image = $('<img />'),
				img = $image[0],
				cancelLoad = false,
				retries = typeof callback == 'number' ? callback : 0;

			if (retries == 0) {
				if (rendering.preloadedImages[src] !== undefined) {
					if (rendering.preloadedImages[src].state == 'loading')
						rendering.preloadedImages[src].callbacks.push(callback);
					else
						callback();

					return;
				}

				rendering.preloadedImages[src] = {
					state: 'loading',
					callbacks: [callback]
				};
			}

			rendering.preloadedImages[src].timeout = setTimeout(function () {
				if (!terminated && retries < 10)
					lightbox.preloadImage(src, retries + 1);
			}, 4000 * (retries + 1));

			$image.bind('load.socialMediaBox error.socialMediaBox', function (e) {
				if (cancelLoad || rendering.preloadedImages[src].state != 'loading')
					return;

				preloadingDone.apply(img, [src, e.type == 'load']);
				runPreloadCallbacks(src);
			});

			img.src = src;

			if (img.complete && img.naturalWidth !== undefined) {
				cancelLoad = true;
				preloadingDone.apply(img, [src, img.naturalWidth !== 0 && img.naturalHeight !== 0]);
				runPreloadCallbacks(src);
				return;
			}
		};


		lightbox.resize = function () {
			var navigationTop,
				navigationOffset,
				navigationPreviousCss,
				navigationNextCss,
				closeCss,
				closeOffset;

			if (rendering.resizeInProgress) {
				rendering.resizeRace = true;
				return;
			}

			rendering.resizeInProgress = true;

			rendering.baseWrapper.height = $baseWrapper.height();
			rendering.baseWrapper.width = $baseWrapper.width();

			lightbox.thubnails.resize();
			lightbox.itemDetails.resize();
			lightbox.itemDisplay.resize();
			lightbox.interfaceActions.resize();

			if (displayItems.length > 1) {
				navigationTop = Math.floor((rendering.itemDisplay.wrapper.height + rendering.itemDisplay.wrapper.verticalOffset - $navigationPrevious.height()) / 2);
				navigationOffset = rendering.itemDisplay.wrapper.width + rendering.itemDisplay.wrapper.horizontalOffset - $navigationNext.outerWidth(true);

				if (config.itemDetails.rightSide) {
					navigationPreviousCss = {
						top: navigationTop,
						left: 0,
						right: 'auto'
					};

					navigationNextCss = {
						top: navigationTop,
						left: navigationOffset,
						right: 'auto'
					};
				} else {
					navigationPreviousCss = {
						top: navigationTop,
						left: 'auto',
						right: navigationOffset
					};

					navigationNextCss = {
						top: navigationTop,
						left: 'auto',
						right: 0
					};
				}

				$navigationPrevious.css(navigationPreviousCss);

				$navigationNext.css(navigationNextCss);
			}

			closeOffset = rendering.itemDisplay.wrapper.width + rendering.itemDisplay.wrapper.horizontalOffset - $closeButton.outerWidth(true);

			if (config.itemDetails.rightSide) {
				closeCss = {
					left: closeOffset,
					right: 'auto'
				};
			} else {
				closeCss = {
					left: 'auto',
					right: closeOffset
				};
			}

			$closeButton.css(closeCss);

			rendering.resizeInProgress = false;

			if (rendering.resizeRace) {
				rendering.resizeRace = false;
				lightbox.resize();
			}
		};


		lightbox.showItem = function (i, firstRun) {
			if (i < 0)
				i = displayItems.length - 1;
			else if (i >= displayItems.length)
				i = 0;

			if (firstRun !== true && rendering.activeItem == i)
				return;

			rendering.activeItem = i;

			lightbox.itemDisplay.showItem();
			lightbox.itemDetails.showItem();
			lightbox.thubnails.showItem();
		};


		lightbox.callbackObject = function () {
			return {
				activeItem: rendering.activeItem,
				displayItems: displayItems
			};
		};

		lightbox.close = function () {
			if (typeof config.events.onBeforeClose == 'function' && config.events.onBeforeClose(lightbox.callbackObject()) === false)
				return;

			terminated = true;

			$(document).off('.socialMediaBox');
			$(window).off('.socialMediaBox');

			$baseWrapper.fadeOut(200, function () {
				$baseWrapper.remove();

				$body.removeClass('socialMediaBoxActive');
			});
		};


		lightbox.thubnails = {};
		lightbox.thubnails.init = function () {
			var $firstThumb;

			if (!config.thumbnails.show || displayItems.length < 2)
				return;

			rendering.thumbnails.rendered = true;

			$thumbnailsMainWrapper = $('<div class="thumbnailsMainWrapper">' +
					'<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>' +
					'<div class="viewport"><div class="overview"></div></div>' +
				'</div>');

			$thumbnailsViewport = $('> div.viewport', $thumbnailsMainWrapper)
			$thumbnailsOverview = $('> div.overview', $thumbnailsViewport);

			$.each(displayItems, function (i, item) {
				var $wrapper = $('<div><div class="' + item.type + '">' + (item.type == 'video' || item.type == 'audio' ? '<div class="playItem"></div>' : '') + '</div></div>').appendTo($thumbnailsOverview);

				if (item.thumbnail !== undefined && item.thumbnail.src !== undefined) {
					lightbox.preloadImage(item.thumbnail.src, function () {
						var top,
							cth = config.thumbnails.height,
							ctw = config.thumbnails.width,
							ith,
							itw,
							containerRatio = ctw / cth,
							itemRatio;

						if (rendering.preloadedImages[item.thumbnail.src].state == 'success') {
							ith = rendering.preloadedImages[item.thumbnail.src].height;
							itw = rendering.preloadedImages[item.thumbnail.src].width;

							if (ith > cth || itw > ctw) {
								itemRatio = itw / ith;

								if (itemRatio < containerRatio) {
									itw = Math.round(cth / ith * itw);
									ith = cth;
								} else if (itemRatio > containerRatio) {
									ith = Math.round(ctw / itw * ith);
									itw = ctw;
								} else {
									itw = ctw;
									ith = cth;
								}
							}

							top = ith > cth ? 0 : Math.floor((cth - ith) / 2);

							$wrapper
								.css('top', top)
								.fadeIn(300)
								.addClass('visible')
								.find('> div')
									.prepend('<img src="' + item.thumbnail.src + '" alt="" style="height: ' + ith + 'px; width: ' + itw + 'px;" />');

							if (rendering.thumbnails.initialized)
								lightbox.thubnails.resize();
						}
					});
				} else
					$wrapper
						.fadeIn(300)
						.addClass('visible')
						.find('> div')
							.prepend('<div class="noThumb"></div>');
			});

			$firstThumb = $('> div', $thumbnailsOverview).eq(0);

			$thumbnailsMainWrapper.appendTo($baseWrapper);

			$('>', $firstThumb).css({
				width: config.thumbnails.width,
				height: config.thumbnails.height
			});

			rendering.thumbnails.thumbnail.height = $firstThumb.outerHeight(true);
			rendering.thumbnails.thumbnail.width = $firstThumb.outerWidth(true);

			$('>', $firstThumb).css({
				width: '',
				height: ''
			});

			$thumbnailsOverview.height(rendering.thumbnails.thumbnail.height);
			$thumbnailsViewport.height(rendering.thumbnails.thumbnail.height);

			rendering.thumbnails.wrapper.height = rendering.thumbnails.wrapper.effectiveHeight = $thumbnailsMainWrapper.outerHeight(true);

			$thumbnailsMainWrapper.eds_tinyscrollbar({axis: 'x'});

			$thumbnailsOverview.on('click', '> div', function () {
				rendering.thumbnails.thumbActivatedChange = true;
				lightbox.showItem($(this).index());
			});

			rendering.thumbnails.initialized = true;
		};
		lightbox.thubnails.resize = function () {
			var scrollValue = 0,
				mww,
				ow,
				tw = rendering.thumbnails.thumbnail.width,
				loadedThumbnails;

			if (!config.thumbnails.show || displayItems.length < 2)
				return;

			if (rendering.thumbnails.thumbActivatedChange) {
				rendering.thumbnails.thumbActivatedChange = false;
				return;
			}

			if (!rendering.thumbnails.allThumbnailsLoaded) {
				loadedThumbnails = $('> div.visible', $thumbnailsOverview);

				if (displayItems.length == loadedThumbnails.length)
					rendering.thumbnails.allThumbnailsLoaded = true;

				rendering.thumbnails.overview.width = 0;
				loadedThumbnails.each(function () {
					rendering.thumbnails.overview.width += $(this).outerWidth(true);
				});
				$thumbnailsOverview.width(rendering.thumbnails.overview.width);
			}

			mww = $thumbnailsMainWrapper.width();
			ow = rendering.thumbnails.overview.width;

			if (ow > mww) {
				$thumbnailsOverview.css({left: 0});
				scrollValue = tw * rendering.activeItem + Math.floor(tw / 2);

				if (scrollValue <= Math.floor(mww / 2))
					scrollValue = 0;
				else if (ow - scrollValue <= Math.ceil(mww / 2))
					scrollValue = 'bottom';
				else
					scrollValue = scrollValue - Math.floor(mww / 2);

				$thumbnailsMainWrapper.data('plugin_eds_tinyscrollbar').update(scrollValue);
			} else {
				$thumbnailsMainWrapper.data('plugin_eds_tinyscrollbar').update();
				$thumbnailsOverview.css({left: Math.floor((mww - ow) / 2)});
			}
		};
		lightbox.thubnails.showItem = function () {
			if (!config.thumbnails.show || displayItems.length < 2)
				return;

			$('> div', $thumbnailsOverview)
				.removeClass('active')
				.eq(rendering.activeItem)
					.addClass('active');

			lightbox.thubnails.resize();
		};


		lightbox.interfaceActions = {};
		lightbox.interfaceActions.init = function () {
			var $toggleInterfaceSpan;

			$interfaceActionsWrapper = $('<div class="interfaceActionsWrapper"></div>');

			if (rendering.thumbnails.rendered || rendering.itemDetails.rendered) {
				$toggleInterface = $('<div class="action toggleInterface"><span>' + _('Hide interface') + '</span></div>')
					.appendTo($interfaceActionsWrapper)
					.on('click', function () {
						var thumbnailsBottomVal,
							itemDetailsCss;

						if (rendering.interfaceHidden) {
							rendering.interfaceHidden = false;
							$toggleInterfaceSpan.text(_('Hide interface'));
							$toggleInterface.removeClass('hidden');
						} else {
							rendering.interfaceHidden = true;
							$toggleInterfaceSpan.text(_('Show interface'));
							$toggleInterface.addClass('hidden');
						}

						if (rendering.thumbnails.rendered) {
							if (rendering.interfaceHidden)
								thumbnailsBottomVal = - rendering.thumbnails.wrapper.height;
							else
								thumbnailsBottomVal = 0;

							$thumbnailsMainWrapper
								.stop(true)
								.animate({
									bottom: thumbnailsBottomVal
								}, {
									duration: 200,
									step: function (now) {
										rendering.thumbnails.wrapper.effectiveHeight = Math.round(rendering.thumbnails.wrapper.height + now);
										lightbox.resize();
									}
								});
						}

						if (rendering.itemDetails.rendered) {
							if (config.itemDetails.rightSide)
								if (rendering.interfaceHidden)
									itemDetailsCss = {
										right: - rendering.itemDetails.wrapper.width
									};
								else
									itemDetailsCss = {
										right: 0
									};
							else
								if (rendering.interfaceHidden)
									itemDetailsCss = {
										left: - rendering.itemDetails.wrapper.width
									};
								else
									itemDetailsCss = {
										left: 0
									};

							$itemDetailsWrapper
								.stop(true)
								.animate(itemDetailsCss, {
									duration: 200,
									step: function (now) {
										rendering.itemDetails.wrapper.effectiveWidth = Math.round(rendering.itemDetails.wrapper.width + now);
										lightbox.resize();
									}
								});
						}
					});

				$toggleInterfaceSpan = $('> span', $toggleInterface);
			}

			$baseWrapper.append($interfaceActionsWrapper);

			rendering.interfaceActions.wrapper.height = $interfaceActionsWrapper.outerHeight(true);
		};
		lightbox.interfaceActions.resize = function () {
			$interfaceActionsWrapper.css({
				bottom: rendering.thumbnails.wrapper.effectiveHeight
			});
		};


		lightbox.itemDetails = {
			comments: {}
		};
		lightbox.itemDetails.init = function () {
			var titleDescriptionHtml = '<h2></h2><div class="description"></div>',
				ratingHtml = '<div class="ratingWrapper">\
					<div class="starContainer">\
						<div></div>\
					</div>\
					<p class="score"></p>\
					<p class="message"></p>\
				</div>',
				commentsHtml = '<div class="commentsWrapper">\
					<h3>' + _('Comments') + '</h3>\
					<div class="loading"></div>\
					<p class="message"></p>\
					<div class="commentsList"></div>\
					<div class="addCommentContainer">\
						<div class="commentingMessage"></div>\
						<div class="authorInfo name"><div class="text"><span class="label">' + _('Name') + '</span><input type="text" value="" /></div></div>\
						<div class="authorInfo email"><div class="text"><span class="label">' + _('Email') + '</span><input type="text" value="" /></div></div>\
						<div class="textarea"><textarea></textarea></div>\
						<div class="captchaContainer"><div class="captcha"></div></div>\
						<button class="add"><span>' + _('Add comment') + '</span></button>\
					</div>\
				</div>',
				authorHtml = '<div class="authorWrapper">\
					<div class="avatarWrapper">\
						<div class="avatarContainer"></div>\
					</div>\
					<div class="actions">\
						<button class="follow"><span>' + _('follow') + '</span></button>\
						<button class="friend"><span>' + _('add as friend') + '</span></button>\
						<button class="friend rejectRequest"><span>' + _('reject friend request') + '</span></button>\
					</div>\
					<p class="postedBy">' + _('posted by') + '</p>\
					<p class="name"></p>\
					<p class="date"></p>\
				</div>',
				likeHtml = '<div class="likeWrapper">\
					<div class="likeContainer">\
						<button><span>' + _('like') + '</span></button>\
						<p></p>\
					</div>\
					<ul class="alsoLiked"></ul>\
				</div>',
				tagHtml = '<ul class="tagContainer"></ul>',
				buttonsHtml = '<div class="buttonsWrapper">\
					<a href="#" class="email"><span>' + _('Send link') + '</span></a>\
					<a href="#" target="_blank" class="download"><span>' + _('Download') + '</span></a>\
				</div>',
				socialButtonsHtml = '<div class="socialButtonsWrapper"></div>',
				metaHtml = '<div class="metaWrapper"><h3><span>' + _('Details') + '</span></h3><div class="content"></div></div>';

			if (!config.itemDetails.show)
				return;

			$itemDetailsWrapper = $('<div class="itemDetailsWrapper ' + (config.itemDetails.rightSide ? 'right' : 'left') + '"><div class="viewport"><div class="overview">' + titleDescriptionHtml + authorHtml + likeHtml + socialButtonsHtml + ratingHtml + tagHtml + buttonsHtml + commentsHtml + metaHtml + '</div></div><div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div></div>');
			$itemDetailsViewport = $('> .viewport', $itemDetailsWrapper);
			$itemDetailsOverview = $('> .overview', $itemDetailsViewport);
			$itemDetailsTitle = $('> h2', $itemDetailsOverview);
			$itemDetailsDescription = $('> div.description', $itemDetailsOverview);

			$itemDetailsAuthorWrapper = $('> .authorWrapper', $itemDetailsOverview);
			$itemDetailsAuthorAvatarWrapper = $('> .avatarWrapper', $itemDetailsAuthorWrapper);
			$itemDetailsAuthorAvatarContainer = $('> .avatarContainer', $itemDetailsAuthorAvatarWrapper);
			$itemDetailsAuthorName = $('> .name', $itemDetailsAuthorWrapper);
			$itemDetailsAuthorDate = $('> .date', $itemDetailsAuthorWrapper);
			$itemDetailsAuthorActions = $('> .actions', $itemDetailsAuthorWrapper);
			$itemDetailsAuthorActionFollow = $('> .follow', $itemDetailsAuthorActions);
			$itemDetailsAuthorActionFriend = $('> .friend', $itemDetailsAuthorActions).eq(0);
			$itemDetailsAuthorActionRejectFriend = $('> .friend', $itemDetailsAuthorActions).eq(1);

			$itemDetailsLikeWrapper = $('> .likeWrapper', $itemDetailsOverview);
			$itemDetailsLikeContainer = $('> .likeContainer', $itemDetailsLikeWrapper);
			$itemDetailsLikeButton = $('> button', $itemDetailsLikeContainer);
			$itemDetailsLikeMessage = $('> p', $itemDetailsLikeContainer);
			$itemDetailsLikeAlsoLiked = $('> .alsoLiked', $itemDetailsLikeWrapper);

			$socialButtonsWrapper = $('> .socialButtonsWrapper', $itemDetailsOverview);

			$itemDetailsRatingWrapper = $('> .ratingWrapper', $itemDetailsOverview);
			$itemDetailsRatingScore = $('p.score', $itemDetailsRatingWrapper);
			$itemDetailsRatingMessage = $('p.message', $itemDetailsRatingWrapper);
			$itemDetailsRatingStarContainer = $('> div.starContainer', $itemDetailsRatingWrapper);
			$itemDetailsRatingStars = $('> div', $itemDetailsRatingStarContainer);

			$itemDetailsTagContainer = $('> .tagContainer', $itemDetailsOverview);

			$itemDetailsButtonsWrapper = $('> .buttonsWrapper', $itemDetailsOverview);
			$itemDetailsDownloadButton = $('> .download', $itemDetailsButtonsWrapper);
			$itemDetailsEmailButton = $('> .email', $itemDetailsButtonsWrapper);

			$itemDetailsCommentsWrapper = $('> div.commentsWrapper', $itemDetailsOverview);
			$itemDetailsCommentsMessage = $('> p.message', $itemDetailsCommentsWrapper);
			$itemDetailsCommentsList = $('> div.commentsList', $itemDetailsCommentsWrapper);
			$itemDetailsCommentsLoading = $('> div.loading', $itemDetailsCommentsWrapper);
			$itemDetailsAddCommentContainer = $('> div.addCommentContainer', $itemDetailsCommentsWrapper);
			$itemDetailsAddCommentTrigger = $('> button.add', $itemDetailsAddCommentContainer);
			$itemDetailsAddCommentContent = $('> div > textarea', $itemDetailsAddCommentContainer);
			$itemDetailsAddCommentMessage = $('> .commentingMessage', $itemDetailsAddCommentContainer);

			$itemDetailsAddCommentAuthorInfoWrapper = $('> .authorInfo', $itemDetailsAddCommentContainer);
			$itemDetailsAddCommentAuthorInfoText = $('> .text', $itemDetailsAddCommentAuthorInfoWrapper);
			$itemDetailsAddCommentCaptchaContainer = $('> div.captchaContainer', $itemDetailsAddCommentContainer);

			$itemDetailsMetaWrapper = $('> .metaWrapper', $itemDetailsOverview);
			$itemDetailsMetaTitle = $('> h3', $itemDetailsMetaWrapper);
			$itemDetailsMetaContent = $('> .content', $itemDetailsMetaWrapper);

			$baseWrapper.append($itemDetailsWrapper);

			rendering.itemDetails.wrapper.verticalOffset = $itemDetailsWrapper.outerHeight(true) - $itemDetailsWrapper.height();
			rendering.itemDetails.wrapper.width = rendering.itemDetails.wrapper.effectiveWidth = $itemDetailsWrapper.outerWidth(true);

			$socialButtonsWrapper.css('display', (config.itemDetails.socialButtons.show ? 'block' : 'none'));

			$itemDetailsAddCommentAuthorInfoText.click(function () {
				var $clicked = $(this),
					$input = $('> input', $clicked);

				$input.focus();

				return false;
			});

			$('> input', $itemDetailsAddCommentAuthorInfoText)
				.focus(function () {
					var $span = $(this).siblings('span');

					if (this.value != '')
						return;

					$span
						.stop(true)
						.fadeTo(200, 0, function () {
							$span.css('display', 'none');
						});
				})
				.blur(function () {
					if (this.value != '')
						return;

					$(this).siblings('span')
						.stop(true)
						.css('display', '')
						.fadeTo(200, 1);
				});

			$itemDetailsAddCommentTrigger.on('click', function () {
				var srcContent = $itemDetailsAddCommentContent.val(),
					currentItem = rendering.activeItem,
					item = displayItems[currentItem],
					commentingError = '',
					responsComment = {},
					responseAuthor = {},
					authorName,
					authorEmail,
					captcha,
					contentErrorMsgs = [],
					contentErrorHtml = '',
					emailVerification = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
					journalInfo = getJournalInfo(),
					requestObject = {
						action: 'add_comment',
						journalType: journalInfo.type,
						journalTarget: journalInfo.target
					};

				if ($itemDetailsAddCommentContainer.hasClass('sending'))
					return;

				if (config.itemDetails.comments.notifySocialGroup) {
					requestObject.notifySocialGroup = true;
					requestObject.journalModuleId = 0;
				}

				if (config.itemDetails.comments.requireAuthorInfo) {
					authorName = $('> div > input', $itemDetailsAddCommentAuthorInfoWrapper.filter('.name')).val();
					authorEmail = $('> div > input', $itemDetailsAddCommentAuthorInfoWrapper.filter('.email')).val();

					if (authorName === '')
						contentErrorMsgs.push(_('a name'));

					if (authorEmail === '' || !emailVerification.test(authorEmail))
						contentErrorMsgs.push(_('a valid email address'));
				}

				if (srcContent == '')
					contentErrorMsgs.push(_('a comment'));

				if (config.itemDetails.comments.requireAuthorInfo && config.itemDetails.comments.captcha) {
					captcha = grecaptcha.getResponse(rendering.reCaptchaId);

					if (captcha === '')
						contentErrorMsgs.push(_('the captcha'));
				}

				if (contentErrorMsgs.length !== 0) {
					contentErrorHtml = '<p>' + _('Please specify') + ' ';

					$.each(contentErrorMsgs, function (i, el) {
						if (i > 0)
							if (i + 1 == contentErrorMsgs.length)
								contentErrorHtml += ' ' + _('and') + ' ';
							else
								contentErrorHtml += ', ';

						contentErrorHtml += el;
					});

					contentErrorHtml += '</p>';

					$itemDetailsAddCommentMessage
						.css('display', 'block')
						.removeClass('positive')
						.html(contentErrorHtml)
						.addClass('negative');

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');

					return;
				}

				$itemDetailsAddCommentContent[0].disabled = true;
				$itemDetailsAddCommentContainer.addClass('sending');

				$itemDetailsAddCommentMessage
					.css('display', 'block')
					.removeClass('negative positive')
					.html('<p>' + _('Sending...') + '</p>');

				requestObject.comment = srcContent;

				if (config.itemDetails.comments.requireAuthorInfo) {
					requestObject.name = authorName;
					requestObject.email = authorEmail;

					if (config.itemDetails.comments.captcha) {
						requestObject.captcha = captcha;
					}
				}

				$.ajax({
					data: requestObject,
					dataType: 'json',
					type: 'POST',
					url: item.comments.backend,
					timeout: 15000,
					cache: false,
					error: function () {
						commentingError = _('The comment can\'t currently be saved. Please try again later.');
					},
					success: function (response) {
						if (response.status == undefined) {
							commentingError = _('The comment can\'t currently be saved. Please try again later.');

							return;
						}

						switch (response.status) {
						case 'success':
							responsComment.author = response.author.id;
							responsComment.content = response.comment;
							responsComment.raw = srcContent;
							responsComment.id = response.id;
							responsComment.dateHtml = response.dateHtml;

							rendering.commentsCache[item.comments.backend].comments.push(responsComment);

							if (rendering.commentsCache[item.comments.backend].authors[responsComment.author] == undefined)
								responseAuthor = rendering.commentsCache[item.comments.backend].authors[responsComment.author] = {
									avatar: response.author.avatar,
									name: response.author.name,
									url: response.author.url
								};
							else
								responseAuthor = rendering.commentsCache[item.comments.backend].authors[responsComment.author];
							break;

						case 'error':
							commentingError = response.message;
							break;

						case 'captcha_error':
							commentingError = response.message;
						}
					},
					complete: function () {
						if (currentItem == rendering.activeItem) {
							if (commentingError == '') {
								$itemDetailsCommentsList.css('display', 'block');
								$itemDetailsCommentsMessage.css('display', 'none');

								lightbox.itemDetails.comments.renderCommentBox(responsComment, responseAuthor);
								lightbox.itemDetails.comments.setAvatarContainerDimensions();
								lightbox.itemDetails.comments.loadAvatars(responsComment.author, responseAuthor);

								$itemDetailsAddCommentContent.val('');

								$itemDetailsAddCommentMessage.css('display', 'none');
							} else
								$itemDetailsAddCommentMessage
									.css('display', 'block')
									.addClass('negative')
									.html('<p>' + commentingError + '</p>');

							$itemDetailsAddCommentContainer.removeClass('sending');
							$itemDetailsAddCommentContent[0].disabled = false;

							if (config.itemDetails.comments.requireAuthorInfo && config.itemDetails.comments.captcha)
								grecaptcha.reset(rendering.reCaptchaId);

							$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
						}
					}
				});

				$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
			});

			$itemDetailsCommentsList
				.on('click', '.actionsBoxTrigger li.edit', function () {
					var $this = $(this),
						$commentWrapper = $this.parents().eq(2),
						$content = $('> .content', $commentWrapper),
						$editWrapper,
						userCanEdit = false,
						item = displayItems[rendering.activeItem];

					if (typeof item.comments == 'object' && typeof item.comments.permissions == 'object' && typeof item.comments.permissions.editing == 'boolean')
						userCanEdit = item.comments.permissions.editing;
					else
						userCanEdit = config.itemDetails.comments.permissions.editing;

					if ($commentWrapper.data('editing') || !userCanEdit)
						return false;

					clearTimeout($commentWrapper.data('saveMsgTimeout'));

					$commentWrapper.data('editing', true);

					$('> .editor', $commentWrapper).remove();

					$content.css('display', 'none');
					$editWrapper = $('<div class="editor"><div class="textarea"><textarea style="height: ' + $content.height() + 'px;"></textarea></div><div class="actions"><p></p><span class="save">' + _('Save') + '</span><span class="cancel">' + _('Cancel') + '</span></div></div>').appendTo($commentWrapper);

					$('.textarea > textarea', $editWrapper)
						.val($commentWrapper.data('comment').raw)
						.focus();

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');

					return false;
				})
				.on('click', '.editor > .actions > span', function () {
					var $this = $(this),
						$actionsContainer = $this.parent(),
						$actions,
						$message,
						$commentWrapper = $this.parents().eq(2),
						wrapperData = $commentWrapper.data('comment'),
						$textarea,
						srcContent,
						commentingError = '',
						currentItem = rendering.activeItem,
						item = displayItems[currentItem],
						responsComment = {};

					if ($commentWrapper.data('saving'))
						return false;

					if ($this.hasClass('save')) {
						$textarea = $('> .editor > .textarea > textarea', $commentWrapper);
						srcContent = $textarea.val();

						if (srcContent == '') {
							$message = $('> p', $actionsContainer)
								.text(_('Please specify a comment'))
								.addClass('negative')
								.removeClass('positive')
								.css('display', 'block');

							$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');

							return;
						}

						$commentWrapper.data('saving', true);

						$textarea[0].disabled = true;

						$message = $('> p', $actionsContainer)
							.text(_('Saving...'))
							.removeClass('negative positive')
							.css('display', 'block');

						$actions = $('> span', $actionsContainer).css('display', 'none');

						$.ajax({
							data: {
								action: 'edit_comment',
								id: wrapperData.id,
								comment: srcContent
							},
							dataType: 'json',
							type: 'POST',
							url: item.comments.backend,
							timeout: 15000,
							cache: false,
							error: function () {
								commentingError = _('Your changes can\'t currently be saved.');
							},
							success: function (response) {
								if (response.status == undefined) {
									commentingError = _('Your changes can\'t currently be saved.');

									return;
								}

								switch (response.status) {
								case 'success':
									responsComment = $.extend(true, {}, wrapperData, {
											raw: srcContent,
											content: response.comment,
											dateHtml: response.dateHtml
										});

									$.each(rendering.commentsCache[item.comments.backend].comments, function (i, comment) {
										if (comment.id == wrapperData.id) {
											rendering.commentsCache[item.comments.backend].comments[i] = responsComment;
											return false;
										}
									});
									break;

								case 'error':
									commentingError = response.message;
								}
							},
							complete: function () {
								if (currentItem == rendering.activeItem) {
									if (commentingError) {
										$textarea[0].disabled = false;
										$actions.css('display', '');

										$message
											.addClass('negative')
											.text(commentingError);
									} else {
										$message
											.addClass('positive')
											.text(_('Your changes were saved'));

										$('> .editor > .textarea', $commentWrapper).remove();
										$('> .content', $commentWrapper)
											.css('display', 'block')
											.html(responsComment.content);

										$('> .meta > .commentDate', $commentWrapper).html(responsComment.dateHtml);

										$commentWrapper.data({
											editing: false,
											comment: responsComment,
											saveMsgTimeout: setTimeout(function () {
													if (!terminated && currentItem == rendering.activeItem)
														$('> .editor', $commentWrapper).remove();

													$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
												}, 3000)
										});
									}

									$commentWrapper.data('saving', false);
									$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
								}
							}
						});
					} else {
						$commentWrapper.data('editing', false);
						$('> .editor', $commentWrapper).remove();
						$('> .content', $commentWrapper).css('display', 'block');
					}

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');

					return false;
				})
				.on('click', '.actionsBoxTrigger li.delete', function () {
					var $this = $(this),
						$commentWrapper = $this.parents().eq(2);

					$commentWrapper.addClass('hideActions');
					$('> .deleteConfirmation', $commentWrapper).css('display', 'block');

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');

					return false;
				})
				.on('click', '.deleteConfirmation span', function () {
					var $this = $(this),
						$commentWrapper = $this.parents().eq(2),
						commentIndex = $commentWrapper.index(),
						wrapperData = $commentWrapper.data('comment'),
						$deleteConfirmation = $('> .deleteConfirmation', $commentWrapper),
						$message = $('> .message', $deleteConfirmation),
						errorMessage = '',
						currentItem = rendering.activeItem,
						item = displayItems[currentItem];

					if ($this.hasClass('delete')) {
						$('> p', $deleteConfirmation).css('display', 'none');

						$message.text(_('Deleting...')).css('display', 'block');

						$.ajax({
							data: {
								action: 'delete_comment',
								id: wrapperData.id
							},
							dataType: 'json',
							type: 'GET',
							url: item.comments.backend,
							timeout: 15000,
							cache: false,
							error: function () {
								errorMessage = _('The comment can\'t currently be deleted.');
							},
							success: function (response) {
								if (response.status == undefined) {
									errorMessage = _('Your changes can\'t currently be saved.');

									return;
								}

								switch (response.status) {
								case 'success':
									$.each(rendering.commentsCache[item.comments.backend].comments, function (i, comment) {
										if (comment.id == wrapperData.id) {
											rendering.commentsCache[item.comments.backend].comments.splice(i, 1);
											return false;
										}
									});
									break;

								case 'error':
									errorMessage = response.message;
								}
							},
							complete: function () {
								if (currentItem == rendering.activeItem) {
									if (errorMessage) {
										$message
											.addClass('negative')
											.text(errorMessage);
										$commentWrapper.removeClass('hideActions');
									} else {
										$commentWrapper.remove();
										if ($('>', $itemDetailsCommentsList).length == 0) {
											$itemDetailsCommentsList.css('display', 'none');
											$itemDetailsCommentsMessage
												.addClass('noComments')
												.text(_('No comments yet'))
												.css('display', 'block');
										}
									}

									$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
								}
							}
						});
					} else {
						$commentWrapper.removeClass('hideActions');
						$deleteConfirmation.css('display', 'none');
						$message.css('display', 'none');
					}

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');

					return false;
				});

			$itemDetailsRatingStarContainer
				.on('mousemove', function (e) {
					var item = displayItems[rendering.activeItem],
						offset = $itemDetailsRatingStarContainer.offset(),
						oneStarWidth,
						starCount;

					if (item.rating.rated || item.rating.backend == undefined)
						return;

					oneStarWidth = $itemDetailsRatingStarContainer.width() / 5;
					starCount = Math.ceil((e.clientX - offset.left) / oneStarWidth);

					$itemDetailsRatingStarContainer.data('stars', starCount);

					$itemDetailsRatingStars.css('width', (oneStarWidth * starCount) + 'px');
				})
				.on('mouseleave', function () {
					var item = displayItems[rendering.activeItem],
						ratingDisplayScore = item.rating.score;

					if (item.rating.backend == undefined)
						return;

					if (item.rating.rated !== false)
						ratingDisplayScore = item.rating.rated;

					$itemDetailsRatingStars.css('width', (ratingDisplayScore / 5 * 100) + '%');
				})
				.on('click', function () {
					var currentItem = rendering.activeItem,
						item = displayItems[currentItem],
						errorMessage = false,
						standardError = _('Rating is currently not possible.');

					if (item.rating.rated !== false || item.rating.backend == undefined)
						return;

					displayItems[currentItem].rating.rated = $itemDetailsRatingStarContainer.data('stars');

					$itemDetailsRatingStarContainer.addClass('rated');
					$itemDetailsRatingStars.css('width', (item.rating.rated / 5 * 100) + '%');

					$.ajax({
						data: {
							action: 'rate',
							rating: item.rating.rated
						},
						dataType: 'json',
						type: 'POST',
						url: item.rating.backend,
						timeout: 15000,
						cache: false,
						error: function () {
							errorMessage = standardError;
						},
						success: function (response) {
							if (response.status == undefined) {
								errorMessage = standardError;

								return;
							}

							switch (response.status) {
							case 'success':
								displayItems[currentItem].rating.score = response.score;
								break;

							case 'error':
								errorMessage = response.message;
							}
						},
						complete: function () {
							if (errorMessage)
								displayItems[currentItem].rating.rated = false;

							if (currentItem == rendering.activeItem) {
								if (errorMessage) {
									$itemDetailsRatingStarContainer.removeClass('rated');
									$itemDetailsRatingStars.css('width', (displayItems[currentItem].rating.score / 5 * 100) + '%');

									$itemDetailsRatingMessage
										.addClass('negative')
										.css('display', 'block')
										.text(errorMessage);
								} else {
									$itemDetailsRatingScore
										.removeClass('noRatings')
										.text(displayItems[currentItem].rating.score);
								}

								$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
							}
						}
					});
				});

			$itemDetailsAuthorActionFollow
				.on('click', function () {
					var currentItem = rendering.activeItem,
						item = displayItems[currentItem],
						error = false,
						newStatus = !item.author.following;

					if ($itemDetailsAuthorActionFollow.data('disabled') === true)
						return;

					$itemDetailsAuthorActionFollow
						.data('disabled', true)
						.addClass('requesting');

					$.ajax({
						data: {
							action: 'follow',
							follow: newStatus
						},
						dataType: 'json',
						type: 'POST',
						url: item.author.backend,
						timeout: 10000,
						cache: false,
						error: function () {
							error = true;
						},
						success: function (response) {
							if (response.status == undefined) {
								error = true;
								return;
							}

							switch (response.status) {
							case 'success':
								for (i in displayItems) {
									if (typeof displayItems[i].author != 'object' || typeof displayItems[i].author.id == 'undefined')
										continue;

									if (displayItems[i].author.id == item.author.id)
										displayItems[i].author.following = newStatus;
								}
								break;

							case 'error':
								error = true;
							}
						},
						complete: function () {
							if (currentItem == rendering.activeItem) {
								$itemDetailsAuthorActionFollow
									.data('disabled', false)
									.removeClass('requesting');

								if (!error)
									if (newStatus)
										$itemDetailsAuthorActionFollow
											.addClass('unfollow')
											.find('> span')
												.text(_('unfollow'));
									else
										$itemDetailsAuthorActionFollow
											.removeClass('unfollow')
											.find('> span')
												.text(_('follow'));

								$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
							}
						}
					});

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
				});

			$itemDetailsAuthorActionFriend
				.on('click', function () {
					var currentItem = rendering.activeItem,
						item = displayItems[currentItem],
						error = false,
						newStatus;

					if ($itemDetailsAuthorActionFriend.data('disabled') === true)
						return;

					$itemDetailsAuthorActionFriend
						.data('disabled', true)
						.addClass('requesting');

					if (item.author.friends == 'requested_by_author') {
						$itemDetailsAuthorActionRejectFriend.addClass('requesting');
						newStatus = true;
					} else {
						newStatus = item.author.friends === true || item.author.friends == 'requested_by_user' ? false : true;
					}

					$.ajax({
						data: {
							action: 'friend',
							friends: newStatus
						},
						dataType: 'json',
						type: 'POST',
						url: item.author.backend,
						timeout: 10000,
						cache: false,
						error: function () {
							error = true;
						},
						success: function (response) {
							if (response.status == undefined) {
								error = true;
								return;
							}

							switch (response.status) {
							case 'success':
								newStatus = response.friends;

								for (i in displayItems) {
									if (typeof displayItems[i].author != 'object' || typeof displayItems[i].author.id == 'undefined')
										continue;

									if (displayItems[i].author.id == item.author.id)
										displayItems[i].author.friends = newStatus;
								}
								break;

							case 'error':
								error = true;
							}
						},
						complete: function () {
							if (currentItem == rendering.activeItem) {
								$itemDetailsAuthorActionFriend
									.data('disabled', false)
									.removeClass('requesting');

								$itemDetailsAuthorActionRejectFriend.removeClass('requesting');

								if (!error) {
									$itemDetailsAuthorActionRejectFriend.css('display', 'none');
									$itemDetailsAuthorActionFriend.removeClass('unfriend cancelRequest acceptRequest');

									if (newStatus === true)
										$itemDetailsAuthorActionFriend
											.addClass('unfriend')
											.find('> span')
												.text(_('unfriend'));
									else if (newStatus == 'requested_by_user')
										$itemDetailsAuthorActionFriend
											.addClass('cancelRequest')
											.find('> span')
												.text(_('cancel friend request'));
									else
										$itemDetailsAuthorActionFriend
											.find('> span')
												.text(_('add as friend'));
								}

								$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
							}
						}
					});

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
				});

			$itemDetailsAuthorActionRejectFriend
				.on('click', function () {
					var currentItem = rendering.activeItem,
						item = displayItems[currentItem],
						error = false;

					if (item.author.friends != 'requested_by_author' || $itemDetailsAuthorActionFriend.data('disabled') === true)
						return;

					$itemDetailsAuthorActionFriend
						.data('disabled', true)
						.addClass('requesting');

					$itemDetailsAuthorActionRejectFriend.addClass('requesting');

					$.ajax({
						data: {
							action: 'friend',
							friends: false
						},
						dataType: 'json',
						type: 'POST',
						url: item.author.backend,
						timeout: 10000,
						cache: false,
						error: function () {
							error = true;
						},
						success: function (response) {
							if (response.status == undefined) {
								error = true;
								return;
							}

							switch (response.status) {
							case 'success':
								for (i in displayItems) {
									if (typeof displayItems[i].author != 'object' || typeof displayItems[i].author.id == 'undefined')
										continue;

									if (displayItems[i].author.id == item.author.id)
										displayItems[i].author.friends = false;
								}
								break;

							case 'error':
								error = true;
							}
						},
						complete: function () {
							if (currentItem == rendering.activeItem) {
								$itemDetailsAuthorActionFriend
									.data('disabled', false)
									.removeClass('requesting unfriend cancelRequest acceptRequest');

								$itemDetailsAuthorActionRejectFriend.removeClass('requesting');

								if (!error) {
									$itemDetailsAuthorActionRejectFriend.css('display', 'none');

									$itemDetailsAuthorActionFriend
										.find('> span')
											.text(_('add as friend'));
								}

								$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
							}
						}
					});

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
				});

			$itemDetailsLikeButton
				.on('click', function () {
					var currentItem = rendering.activeItem,
						item = displayItems[currentItem],
						error = false,
						newStatus = !item.likes.liked;

					if ($itemDetailsLikeButton.data('disabled') === true)
						return;

					$itemDetailsLikeButton
						.data('disabled', true)
						.addClass('requesting');

					$.ajax({
						data: {
							action: 'like',
							liked: newStatus
						},
						dataType: 'json',
						type: 'POST',
						url: item.likes.backend,
						timeout: 10000,
						cache: false,
						error: function () {
							error = true;
						},
						success: function (response) {
							if (response.status == undefined) {
								error = true;
								return;
							}

							switch (response.status) {
							case 'success':
								displayItems[currentItem].likes.liked = newStatus;
								displayItems[currentItem].likes.message = response.message;
								break;

							case 'error':
								error = true;
							}
						},
						complete: function (xhr) {
							var errorMessage;

							if (currentItem == rendering.activeItem) {
								$itemDetailsLikeButton
									.data('disabled', false)
									.removeClass('requesting');

								if (error) {
									try {
										errorMessage = $.parseJSON(xhr.responseText).message;
									} catch (e) {
										errorMessage = _('An error occurred while ' + (newStatus ? 'saving your like' : 'removing your like'));
									}

									$itemDetailsLikeMessage
										.addClass('negative')
										.text(errorMessage);
								} else {
									$itemDetailsLikeMessage
										.removeClass('negative')
										.text(displayItems[currentItem].likes.message);

									if (newStatus)
										$itemDetailsLikeButton
											.addClass('unlike')
											.find('> span')
												.text(_('unlike'));
									else
										$itemDetailsLikeButton
											.removeClass('unlike')
											.find('> span')
												.text(_('like'));
								}

								$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
							}
						}
					});

					$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
				});

			$itemDetailsMetaTitle.on('click', function () {
				var item = displayItems[rendering.activeItem],
					display = 'block';

				if ($itemDetailsMetaContent.is(':visible'))
					display = 'none';

				$itemDetailsMetaContent.css('display', display);

				if (display == 'block') {
					$itemDetailsMetaTitle.addClass('close');

					if (typeof item.meta.map == 'object' && item.meta.map.type == 'google') {
						google.maps.event.trigger(rendering.itemDetails.maps.google, 'resize');
						rendering.itemDetails.maps.google.setCenter(new google.maps.LatLng(item.meta.map.settings.lat, item.meta.map.settings.lng));
					}
				} else
					$itemDetailsMetaTitle.removeClass('close');

				$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
			});

			rendering.itemDetails.rendered = true;

			$itemDetailsWrapper.eds_tinyscrollbar({axis: 'y'});
		};
		lightbox.itemDetails.placeAvatar = function (args) {
			var left = 0,
				top = 0,
				ch,
				cw,
				ih = null,
				iw = null,
				containerRatio,
				avatarRatio,
				preloadInfo = rendering.preloadedImages[args.src];

			if (args.fadeIn == undefined)
				args.fadeIn = false;

			if (preloadInfo === undefined || preloadInfo.state == 'loading') {
				args.fadeIn = true;
				lightbox.preloadImage(args.src, function () {
					lightbox.itemDetails.placeAvatar(args);
				});

				return;
			}

			if (typeof args.containerDimensions == 'object') {
				ch = args.containerDimensions.height;
				cw = args.containerDimensions.width;
			} else {
				ch = args.$container.height();
				cw = args.$container.width();
			}

			if (preloadInfo.state == 'success') {
				ih = preloadInfo.height + 4;
				iw = preloadInfo.width + 4;

				if (ih > ch || iw > cw) {
					avatarRatio = iw / ih;
					containerRatio = cw / ch;

					if (avatarRatio < containerRatio) {
						iw = Math.round(ch / ih * iw);
						ih = ch;
					} else if (avatarRatio > containerRatio) {
						ih = Math.round(cw / iw * ih);
						iw = cw;
					} else {
						iw = cw;
						ih = ch;
					}
				}

				top = ih == ch ? 0 : Math.floor((ch - ih) / 2);
				left = iw == cw ? 0 : Math.floor((cw - iw) / 2);

				ih -= 4;
				iw -= 4;
			}

			args.$container.append('<img src="' + args.src + '" alt="" style="' + (args.fadeIn ? 'display: none; ' : '') + (iw != null ? 'width: ' + iw + 'px; ' : '') + (ih != null ? 'height: ' + ih + 'px; ' : '') + 'top: ' + top + 'px; left: ' + left + 'px;" />');

			if (args.fadeIn)
				args.$container
					.find('>')
						.fadeIn(200);
		};
		lightbox.itemDetails.comments.renderCommentBox = function (comment, author) {
			var actionsHtml,
				$commentBox,
				item = displayItems[rendering.activeItem],
				userCanEdit = false,
				userCanDelete = false,
				authorName;

			if (typeof item.comments == 'object' && typeof item.comments.permissions == 'object' && typeof item.comments.permissions.editing == 'boolean')
				userCanEdit = item.comments.permissions.editing;
			else
				userCanEdit = config.itemDetails.comments.permissions.editing;

			if (typeof item.comments == 'object' && typeof item.comments.permissions == 'object' && typeof item.comments.permissions.deleting == 'boolean')
				userCanDelete = item.comments.permissions.deleting;
			else
				userCanDelete = config.itemDetails.comments.permissions.deleting;

			actionsHtml = (userCanEdit && item.journalEntry !== true ? '<li class="edit"><span>' + _('Edit') + '</span></li>' : '') +
				(userCanDelete ? '<li class="delete"><span>' + _('Delete') + '</span></li>' : '');

			if (typeof author.url == 'string' && author.url != '')
				authorName = '<a href="' + author.url + '">' + author.name + '</a>';
			else
				authorName = author.name;

			$commentBox = $('<div class="author-' + comment.author + (typeof author.avatar == 'string' && author.avatar != '' ? ' hasAvatar' : '') + '"><div class="deleteConfirmation"><p class="message"></p><p>' + _('Do you really want to delete this comment?') + '</p><p><span class="delete">' + _('Yes') + '</span><span class="cancel">' + _('No') + '</span></p></div><div class="meta"><div class="authorAvatarWrapper"><div class="authorAvatarContainer"></div></div><h4>' + authorName + '</h4><p class="commentDate">' + comment.dateHtml + '</p></div><div class="content">' + comment.content + '</div>' + (actionsHtml == '' ? '' : '<div class="actionsBoxTrigger"><ul>' + actionsHtml + '</ul></div>') + '</div>').data('comment', comment);

			$itemDetailsCommentsList.append($commentBox);
		};
		lightbox.itemDetails.comments.loadAvatars = function (authorId, author) {
			var $authorAvatarWrapper = $('> .author-' + authorId + ' > .meta > .authorAvatarWrapper', $itemDetailsCommentsList).filter(':hidden'),
				$avatarContainer;

			if ($authorAvatarWrapper.lenght == 0)
				return;

			if (author.avatar !== undefined && author.avatar != '') {
				$authorAvatarWrapper.css('display', 'block');

				if (typeof author.url == 'string' && author.url != '') {
					$('>', $authorAvatarWrapper).append($('<a href="#" />').attr('href', author.url));
					$avatarContainer = $('> >', $authorAvatarWrapper);
				} else
					$avatarContainer = $('>', $authorAvatarWrapper);

				lightbox.itemDetails.placeAvatar({
					src: author.avatar,
					$container: $avatarContainer,
					containerDimensions: rendering.itemDetails.comments.author.avatarContainer
				});
			}
		};
		lightbox.itemDetails.comments.setAvatarContainerDimensions = function () {
			if (rendering.itemDetails.comments.author.avatarContainer == null) {
				$authorAvatarWrapper = $('.authorAvatarWrapper', $itemDetailsCommentsList)
					.eq(0)
						.css('display', 'block');

				rendering.itemDetails.comments.author.avatarContainer = {
					width: $authorAvatarWrapper.width(),
					height: $authorAvatarWrapper.height()
				};

				$authorAvatarWrapper.css('display', 'none');
			}
		};
		lightbox.itemDetails.comments.display = function (infoObj) {
			var $authorAvatarWrapper,
				item = displayItems[rendering.activeItem],
				userCanComment = false;

			$itemDetailsCommentsLoading.css('display', 'none');

			if (infoObj.comments.length > 0) {
				$itemDetailsCommentsMessage.css('display', 'none');
				$itemDetailsCommentsList.empty();

				$.each(infoObj.comments, function (i, comment) {
					lightbox.itemDetails.comments.renderCommentBox(comment, infoObj.authors[comment.author]);
				});

				$itemDetailsCommentsList.css('display', 'block');

				lightbox.itemDetails.comments.setAvatarContainerDimensions();

				$.each(infoObj.authors, lightbox.itemDetails.comments.loadAvatars);
			} else {
				$itemDetailsCommentsList
					.empty()
					.css('display', 'none');
				$itemDetailsCommentsMessage
					.addClass('noComments')
					.text(_('No comments yet'))
					.css('display', 'block');
			}

			if (typeof item.comments == 'object' && typeof item.comments.permissions == 'object' && typeof item.comments.permissions.commenting == 'boolean')
				userCanComment = item.comments.permissions.commenting;
			else
				userCanComment = config.itemDetails.comments.permissions.commenting;

			if (userCanComment) {
				if (config.itemDetails.comments.requireAuthorInfo) {
					$itemDetailsAddCommentAuthorInfoWrapper.css('display', 'block');

					if (config.itemDetails.comments.captcha) {
						$itemDetailsAddCommentCaptchaContainer.css('display', 'block');

						if (rendering.reCaptchaId)
							grecaptcha.reset(rendering.reCaptchaId);
						else
							rendering.reCaptchaId = grecaptcha.render(
								$('> .captcha', $itemDetailsAddCommentCaptchaContainer)[0],
								{
									sitekey: config.googleReCaptchaSiteKey,
									size: 'compact'
								}
							);
					}
				} else {
					$itemDetailsAddCommentAuthorInfoWrapper.css('display', 'none');
					$itemDetailsAddCommentCaptchaContainer.css('display', 'none');
				}

				$itemDetailsAddCommentContainer
					.removeClass('sending')
					.css('display', 'block');
				$itemDetailsAddCommentContent[0].disabled = false;
				$itemDetailsAddCommentMessage.css('display', 'none');
				$itemDetailsAddCommentContent.val('');
			} else
				$itemDetailsAddCommentContainer.css('display', 'none');
		};

		lightbox.itemDetails.showItem = function () {
			var currentItem = rendering.activeItem,
				item = displayItems[currentItem],
				ratingDisplayScore,
				tagsHtml = '',
				showButtonsWrapper = false,
				socialButtonsHtml = '',
				mediaUrl = '',
				exifHtml = '',
				mapPosition,
				authorProfileUrl = '',
				$authorAvatarContainer,
				socialButtonsTitle = '';

			if (!config.itemDetails.show)
				return;

			if (item.title == undefined || item.title == '') {
				$itemDetailsTitle.css('display', 'none');
				$itemDetailsDescription.removeClass('withTitle');
			} else {
				$itemDetailsTitle
					.text(item.title)
					.css('display', 'block');
				$itemDetailsDescription.addClass('withTitle');
			}

			if (item.description == undefined || item.description == '')
				$itemDetailsDescription.css('display', 'none');
			else
				$itemDetailsDescription
					.html(item.description)
					.css('display', 'block');

			if (config.itemDetails.socialButtons.show && typeof item.social == 'object' && item.social.url != '') {
				mediaUrl = typeof item.social.media != 'string' ? '' : item.social.media;

				$.each(config.itemDetails.socialButtons.buttons, function (i, button) {
					if (button.show) {
						if (i == 'pinterest' && mediaUrl == '')
							return;

						if (i == 'twitter' && (typeof twttr == 'undefined' || typeof twttr.widgets == 'undefined'))
							return;

						if (i == 'inshare' && (typeof IN == 'undefined' || typeof IN.parse != 'function'))
							return;

						socialButtonsHtml += '<div>' + button.html + '</div>';
					}
				});

				if (socialButtonsHtml == '')
					$socialButtonsWrapper
						.css('display', 'none')
						.empty();
				else {
					if (typeof item.title == 'string' && item.title != '') {
						socialButtonsTitle = item.title
							.replace(/&/g, '&amp;')
							.replace(/"/g, '&quot;')
							.replace(/'/g, '&#39;')
							.replace(/</g, '&lt;')
							.replace(/>/g, '&gt;');

						socialButtonsHtml = socialButtonsHtml.replace(/{{encodedTitle}}/g, encodeURIComponent(item.title));
					} else {
						socialButtonsHtml = socialButtonsHtml.replace(/{{encodedTitle}}/g, '');
					}

					socialButtonsHtml = socialButtonsHtml
						.replace(/{{url}}/g, item.social.url)
						.replace(/{{escapedTitle}}/g, socialButtonsTitle)
						.replace(/{{encodedUrl}}/g, encodeURIComponent(item.social.url));

					if (mediaUrl)
						socialButtonsHtml = socialButtonsHtml.replace(/{{encodedMediaUrl}}/g, encodeURIComponent(mediaUrl))

					$socialButtonsWrapper
						.css('display', 'block')
						.html(socialButtonsHtml);

					if (mediaUrl && config.itemDetails.socialButtons.buttons['pinterest'].show)
						$.ajax({url: '//assets.pinterest.com/js/pinit.js', dataType: 'script', cache: false});
				}
			} else
				$socialButtonsWrapper
					.css('display', 'none')
					.empty();

			if (typeof item.rating == 'object') {
				$itemDetailsRatingStarContainer.removeClass('rated');

				if (item.rating.score > 0) {
					$itemDetailsRatingScore
						.removeClass('noRatings')
						.text(item.rating.score);

					if (item.rating.rated === false)
						ratingDisplayScore = item.rating.score;
					else {
						ratingDisplayScore = item.rating.rated;
						$itemDetailsRatingStarContainer.addClass('rated');
					}

					$itemDetailsRatingStars.css('width', (ratingDisplayScore / 5 * 100) + '%');
				} else {
					$itemDetailsRatingScore
						.addClass('noRatings')
						.text(_('No ratings'));

					$itemDetailsRatingStars.css('width', '');
				}

				$itemDetailsRatingMessage
					.css('display', 'none')
					.removeClass('negative');

				$itemDetailsRatingWrapper.css('display', 'block');

				if (item.rating.backend == undefined)
					$itemDetailsRatingWrapper.addClass('cantRate');
				else
					$itemDetailsRatingWrapper.removeClass('cantRate');
			} else
				$itemDetailsRatingWrapper.css('display', 'none');

			if (typeof item.comments != 'object' || item.comments.backend == undefined || item.comments.backend == '')
				$itemDetailsCommentsWrapper.css('display', 'none');
			else {
				$itemDetailsCommentsWrapper.css('display', 'block');

				$itemDetailsCommentsList.css('display', 'none');
				$itemDetailsCommentsMessage
					.removeClass('noComments negative')
					.css('display', 'none');
				$itemDetailsAddCommentContainer.css('display', 'none');

				if (rendering.commentsCache[item.comments.backend] == undefined) {
					$itemDetailsCommentsLoading.css('display', 'block');

					$.ajax({
						data: {
							action: 'list_comments'
						},
						dataType: 'json',
						type: 'GET',
						url: item.comments.backend,
						timeout: 15000,
						cache: false,
						error: function () {
							if (currentItem == rendering.activeItem)
								$itemDetailsCommentsMessage
									.addClass('negative')
									.removeClass('noComments')
									.text(_('Comments are currently unavalible'))
									.css('display', 'block');
						},
						success: function (response) {
							rendering.commentsCache[item.comments.backend] = response;

							if (currentItem != rendering.activeItem)
								return;

							lightbox.itemDetails.comments.display(response);

							$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update();
						}
					});
				} else
					lightbox.itemDetails.comments.display(rendering.commentsCache[item.comments.backend]);
			}

			if (typeof item.author == 'object') {
				$itemDetailsAuthorWrapper.css('display', 'block');

				authorProfileUrl = typeof item.author.url == 'string' && item.author.url != '' ? item.author.url : '';

				if (typeof item.author.avatar == 'string' && item.author.avatar != '') {
					$itemDetailsAuthorAvatarWrapper.css('display', 'block');

					$itemDetailsAuthorAvatarContainer.empty();

					if (authorProfileUrl == '')
						$authorAvatarContainer = $itemDetailsAuthorAvatarContainer;
					else {
						$authorAvatarContainer = $('<a href="#" />')
							.appendTo($itemDetailsAuthorAvatarContainer)
							.attr({
								href: authorProfileUrl
							});
					}

					lightbox.itemDetails.placeAvatar({
						src: item.author.avatar,
						$container: $authorAvatarContainer
					});
				} else
					$itemDetailsAuthorAvatarWrapper.css('display', 'none');

				$itemDetailsAuthorName.empty();

				if (authorProfileUrl == '')
					$itemDetailsAuthorName.text(item.author.name);
				else
					$itemDetailsAuthorName.append($('<a />').attr({href: authorProfileUrl}).text(item.author.name));

				$itemDetailsAuthorDate.html(item.author.dateHtml);

				if (item.author.isUser != undefined && item.author.isUser)
					$itemDetailsAuthorActions.css('display', 'none');
				else {
					$itemDetailsAuthorActions.css('display', 'block');

					if (item.author.following == undefined)
						$itemDetailsAuthorActionFollow.css('display', 'none');
					else {
						$itemDetailsAuthorActionFollow
							.data('disabled', false)
							.css('display', 'block');

						if (item.author.following)
							$itemDetailsAuthorActionFollow
								.addClass('unfollow')
								.find('> span')
									.text(_('unfollow'));
						else
							$itemDetailsAuthorActionFollow
								.removeClass('unfollow')
								.find('> span')
									.text(_('follow'));
					}

					$itemDetailsAuthorActionRejectFriend
						.css('display', 'none')
						.removeClass('requesting');

					if (item.author.friends == undefined)
						$itemDetailsAuthorActionFriend.css('display', 'none');
					else {
						$itemDetailsAuthorActionFriend
							.removeClass('requesting unfriend cancelRequest acceptRequest')
							.data('disabled', false)
							.css('display', 'block');

						if (item.author.friends === true)
							$itemDetailsAuthorActionFriend
								.addClass('unfriend')
								.find('> span')
									.text(_('unfriend'));
						else if (item.author.friends == 'requested_by_user')
							$itemDetailsAuthorActionFriend
								.addClass('cancelRequest')
								.find('> span')
									.text(_('cancel friend request'));
						else if (item.author.friends == 'requested_by_author') {
							$itemDetailsAuthorActionFriend
								.addClass('acceptRequest')
								.find('> span')
									.text(_('accept friend request'));

							$itemDetailsAuthorActionRejectFriend.css('display', 'block');
						} else
							$itemDetailsAuthorActionFriend
								.find('> span')
									.text(_('add as friend'));
					}
				}
			} else
				$itemDetailsAuthorWrapper.css('display', 'none');

			if (typeof item.likes == 'object') {
				$itemDetailsLikeWrapper.css('display', 'block');

				if (typeof item.likes.backend == 'string' && item.likes.backend != '') {
					$itemDetailsLikeButton
						.css('display', '')
						.data('disabled', false);

					if (item.likes.liked)
						$itemDetailsLikeButton
							.addClass('unlike')
							.find('> span')
								.text(_('unlike'));
					else
						$itemDetailsLikeButton
							.removeClass('unlike')
							.find('> span')
								.text(_('like'));
				} else
					$itemDetailsLikeButton.css('display', 'none');

				if (typeof item.likes.message != 'string' || item.likes.message == '')
					$itemDetailsLikeMessage.css('display', 'none');
				else
					$itemDetailsLikeMessage
						.removeClass('negative')
						.css('display', 'block')
						.text(item.likes.message);

				if (typeof item.likes.alsoLiked != 'object' || item.likes.alsoLiked.length == 0)
					$itemDetailsLikeAlsoLiked.css('display', 'none');
				else {
					$itemDetailsLikeAlsoLiked
						.css('display', 'block')
						.empty();

					$.each(item.likes.alsoLiked, function (i, user) {
						var $li = $('<li><div></div></li>').appendTo($itemDetailsLikeAlsoLiked),
							$imgContainer = $li.find('> div');

						if (typeof user.url == 'string' && user.url != '')
							$imgContainer = $imgContainer.html('<a href="' + user.url + '"></a>').find('> a');

						$imgContainer.attr('title', user.name);

						lightbox.itemDetails.placeAvatar({
							src: user.avatar,
							$container: $imgContainer
						});
					});
				}
			} else
				$itemDetailsLikeWrapper.css('display', 'none');

			if (typeof item.tags == 'object') {
				$.each(item.tags, function (id, tag) {
					tagsHtml += '<li data-id="' + id + '"><span>' + tag + '</span></li>';
				});

				if (tagsHtml == '')
					$itemDetailsTagContainer.css('display', 'none');
				else
					$itemDetailsTagContainer
						.css('display', 'block')
						.html(tagsHtml);
			} else
				$itemDetailsTagContainer.css('display', 'none');

			if (typeof item.download != 'string' || item.download == '')
				$itemDetailsDownloadButton.css('display', 'none');
			else {
				showButtonsWrapper = true;

				$itemDetailsDownloadButton
					.attr('href', item.download)
					.css('display', '');
			}

			if (typeof item.email == 'object') {
				showButtonsWrapper = true;

				$itemDetailsEmailButton
					.attr('href', 'mailto:?to=&subject=' + encodeURIComponent(item.email.subject) + '&body=' + encodeURIComponent(item.email.body))
					.css('display', '');
			} else
				$itemDetailsEmailButton.css('display', 'none');

			$itemDetailsButtonsWrapper.css('display', (showButtonsWrapper ? 'block' : 'none'));

			if (typeof item.meta == 'object') {
				$itemDetailsMetaWrapper.css('display', 'block');

				if (typeof item.meta.exif == 'object') {
					exifHtml = '<div class="exif"><h4><span>' + _('Exif') + '</span></h4><table><tbody>';

					$.each(item.meta.exif, function (k, v) {
						exifHtml += '<tr><td class="cell1">' + k + '</td><td class="cell2">' + v + '</td></tr>';
					});

					$itemDetailsMetaContent.html(exifHtml + '</tbody></table></div>');
				}

				if (typeof item.meta.map == 'object') {
					$itemDetailsMetaContent.append('<div class="map">' + (item.meta.map.title == undefined ? '' : '<h4><span>' + item.meta.map.title + '</span></h4>') + '<div></div></div>');

					rendering.itemDetails.maps.google = null;

					switch (item.meta.map.type) {
					case 'google':
						if (typeof google === 'object' && typeof google.maps === 'object') {
							mapPosition = new google.maps.LatLng(item.meta.map.settings.lat, item.meta.map.settings.lng);

							rendering.itemDetails.maps.google = new google.maps.Map($('> div.map > div', $itemDetailsMetaContent)[0], {
								center: mapPosition,
								zoom: item.meta.map.settings.zoom,
								mapTypeId: google.maps.MapTypeId[item.meta.map.settings.type],
								scrollwheel: false
							});

							new google.maps.Marker({
								position: mapPosition,
								map: rendering.itemDetails.maps.google
							});
						}
						break;

					default:
					}
				}

				$itemDetailsMetaContent.css({
					display: 'none'
				});
			} else
				$itemDetailsMetaWrapper.css('display', 'none');

			$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update();
		};
		lightbox.itemDetails.resize = function () {
			if (!config.itemDetails.show)
				return;

			$itemDetailsWrapper.height(rendering.baseWrapper.height - rendering.itemDetails.wrapper.verticalOffset - rendering.thumbnails.wrapper.effectiveHeight - rendering.interfaceActions.wrapper.height);

			$itemDetailsWrapper.data('plugin_eds_tinyscrollbar').update('relative');
		};


		lightbox.itemDisplay = {};
		lightbox.itemDisplay.init = function () {
			$itemDisplayWrapper = $('<div class="itemDisplayWrapper ' + (config.itemDetails.rightSide ? 'left' : 'right') + '"></div>');

			$baseWrapper.append($itemDisplayWrapper);

			rendering.itemDisplay.wrapper.verticalOffset = $itemDisplayWrapper.outerHeight(true) - $itemDisplayWrapper.height();
			rendering.itemDisplay.wrapper.horizontalOffset = $itemDisplayWrapper.outerWidth(true) - $itemDisplayWrapper.width();

			$itemDisplayContainer = $('<div class="itemDisplayContainer"></div>').appendTo($itemDisplayWrapper);
			$itemDisplayLoadIndicator = $('<div class="loadIndicator"></div>').appendTo($itemDisplayWrapper);
		};
		lightbox.itemDisplay.resize = function () {
			var currentItem = displayItems[rendering.activeItem],
				displayWidth,
				displayHeight,
				displayTop,
				displayLeft,
				$item,
				itemD,
				itemRatio,
				containerD,
				containerRatio;

			rendering.itemDisplay.wrapper.height = rendering.baseWrapper.height - rendering.itemDisplay.wrapper.verticalOffset - rendering.thumbnails.wrapper.effectiveHeight - rendering.interfaceActions.wrapper.height;
			rendering.itemDisplay.wrapper.width = rendering.baseWrapper.width - rendering.itemDisplay.wrapper.horizontalOffset - rendering.itemDetails.wrapper.effectiveWidth;

			$itemDisplayWrapper
				.height(rendering.itemDisplay.wrapper.height)
				.width(rendering.itemDisplay.wrapper.width);

			$item = $('> .item.active', $itemDisplayContainer);

			switch (currentItem.type) {
			case 'image':
				if ($item.length == 0)
					return;

				itemD = {
					width: rendering.preloadedImages[currentItem.src].width,
					height: rendering.preloadedImages[currentItem.src].height
				}
				break;

			case 'video':
				itemD = {
					width: currentItem.video.width,
					height: currentItem.video.height
				}
				break;

			case 'audio':
				itemD = {
					width: 450,
					height: $item.height()
				}
				break;

			default:
			}

			containerD = {
				width: $itemDisplayContainer.width(),
				height: $itemDisplayContainer.height()
			}

			if (
				currentItem.type == 'video'
				|| (currentItem.type == 'image' && (itemD.width > containerD.width || itemD.height > containerD.height))
				|| (currentItem.type == 'audio' && itemD.width > containerD.width)
			) {
				containerRatio = containerD.width / containerD.height;
				itemRatio = itemD.width / itemD.height;

				displayWidth = containerD.width;

				if (currentItem.type == 'audio')
					displayHeight = itemD.height;
				else
					displayHeight = containerD.height;

				if (itemRatio < containerRatio) {
					displayWidth = Math.round(containerD.height / itemD.height * itemD.width);
				} else if (itemRatio > containerRatio && currentItem.type != 'audio') {
					displayHeight = Math.round(containerD.width / itemD.width * itemD.height);
				}
			} else {
				displayWidth = itemD.width;
				displayHeight = itemD.height;
			}

			displayLeft = Math.floor((containerD.width - displayWidth) / 2);
			displayTop = Math.floor((containerD.height - displayHeight) / 2);

			$item.css({
				width: displayWidth,
				height: displayHeight,
				marginTop: displayTop,
				marginLeft: displayLeft
			});
		};
		lightbox.itemDisplay.showItem = function () {
			var currentItem = rendering.activeItem,
				item = displayItems[currentItem],
				$previousItems,
				embedHtml,
				$embedContainer,

				displayImage = function () {
					$previousItems = $itemDisplayContainer.find('>')
						.fadeOut(200, function () {
							$previousItems.remove();
						})
						.removeClass('active');

					$('<img class="item active" src="' + item.src + '" alt="" style="display: none;" />')
						.appendTo($itemDisplayContainer)
						.fadeIn(200);

					lightbox.itemDisplay.resize();

					$itemDisplayLoadIndicator
						.stop(true)
						.fadeOut(500);
				},

				videoType = '';

			switch (item.type) {
			case 'image':
				if (rendering.preloadedImages[item.src] !== undefined && rendering.preloadedImages[item.src].state == 'success') {
					displayImage();
				} else {
					$itemDisplayLoadIndicator
						.css({
							display: 'none',
							left: 0
						})
						.stop(true)
						.fadeIn(500, function () {
							$itemDisplayContainer.find('>').remove();
						});

					lightbox.preloadImage(item.src, function () {
						if (currentItem != rendering.activeItem)
							return;

						displayImage();
					});
				}
				break;

			case 'video':
				$previousItems = $itemDisplayContainer.find('>')
					.removeClass('active')
					.fadeOut(200, function () {
						$previousItems.remove();
					});

				switch (item.video.provider) {
				case 'youtube':
					embedHtml = '<iframe class="item active" style="display: none;" src="//www.youtube.com/embed/' + item.video.id + '?wmode=opaque" frameborder="0" allowfullscreen></iframe>';
					break;

				case 'vimeo':
					embedHtml = '<iframe class="item active" style="display: none;" src="//player.vimeo.com/video/' + item.video.id + '" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>';
					break;

				case 'wistia':
					embedHtml = '<iframe class="wistia_embed item active" name="wistia_embed" style="display: none;" src="//fast.wistia.net/embed/iframe/' + item.video.id + '" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>';
					break;

				case 'flowplayer':
					embedHtml = '<div class="item active" style="display: block; opacity: 0;"></div>';
					break;

				default:
				}

				$embedContainer = $(embedHtml).appendTo($itemDisplayContainer);

				if (item.video.provider == 'flowplayer') {
					if (stringEndsWith(item.video.src, '.mp4')) {
						videoType = 'video/mp4';
					} else if (stringEndsWith(item.video.src, '.webm')) {
						videoType = 'video/webm';
					} else if (stringEndsWith(item.video.src, '.ogg')) {
						videoType = 'video/ogg';
					} else if (stringEndsWith(item.video.src, '.flv')) {
						videoType = 'video/flash';
					}

					$embedContainer
						.animate({opacity: 1}, 200)
						.flowplayer({
							swf: config.flowplayerSwf,
							tooltip: false,
							embed: false,
							key: config.flowplayer.key,
							logo: config.flowplayer.logo,
							clip: {
								sources: [
									{
										type: videoType,
										src: item.video.src
									}
								]
							}
						});
				} else
					$embedContainer.fadeIn(200);

				$itemDisplayLoadIndicator
					.stop(true)
					.fadeOut(500);

				lightbox.itemDisplay.resize();
				break;

			case 'audio':
				$previousItems = $itemDisplayContainer.find('>')
					.removeClass('active')
					.fadeOut(200, function () {
						$previousItems.remove();
					});

				$embedContainer = $('<div class="item active" style="display: block; opacity: 0;"><audio src="' + item.audio.src + '" /></div>')
					.appendTo($itemDisplayContainer)
					.animate({opacity: 1}, 200);

				audiojs.create($('> audio', $embedContainer)[0]);

				$itemDisplayLoadIndicator
					.stop(true)
					.fadeOut(500);

				lightbox.itemDisplay.resize();
				break;

			default:
			}
		};


		if (arguments.length > 0)
			$.extend(true, config, arguments[0]);

		this.each(function () {
			var data = $(this).data('socialMediaBox');

			if (data)
				if (data instanceof Array)
					$.each(data, function () {
						displayItems.push(this);
					});
				else
					displayItems.push(data);
		});

		if (displayItems.length == 0)
			return this;

		$body = $('body').addClass('socialMediaBoxActive');

		$baseWrapper = $('<div id="socialMediaBox" class="' + config.baseClass + '" style="visibility: hidden;"></div>').appendTo($body);

		lightbox.thubnails.init();
		lightbox.itemDetails.init();
		lightbox.itemDisplay.init();
		lightbox.interfaceActions.init();

		if (displayItems.length > 1) {
			$navigationPrevious = $('<div class="navigation previous ' + (config.itemDetails.rightSide ? 'left' : 'right') + '"></div>').appendTo($baseWrapper);
			$navigationNext = $('<div class="navigation next ' + (config.itemDetails.rightSide ? 'left' : 'right') + '"></div>').appendTo($baseWrapper);
		}

		$closeButton = $('<div class="close"><span></span></div>');

		$baseWrapper.append($closeButton);

		lightbox.resize();

		lightbox.showItem(config.openAt, true);

		$baseWrapper
			.css({
				display: 'none',
				visibility: ''
			})
			.fadeIn(200)
			.on('click', '> div.navigation', function () {
				if ($(this).hasClass('previous'))
					lightbox.showItem(rendering.activeItem - 1);
				else
					lightbox.showItem(rendering.activeItem + 1);
			});

		$closeButton
			.on('click', function () {
				lightbox.close();
			})

		$(document).on('keyup.socialMediaBox', function(e) {
			var $activeElement = $(document.activeElement);

			if ($activeElement.filter('textarea').parents('.commentsWrapper').length != 0 || $activeElement.filter('input').parents('.commentsWrapper').length)
				return false;

			switch (e.keyCode) {
			case 37:
				lightbox.showItem(rendering.activeItem - 1);
				break;

			case 39:
				lightbox.showItem(rendering.activeItem + 1);
				break;

			case 27:
				lightbox.close();
				break;

			default:
			}

			return false;
		});

		$itemDisplayContainer
			.on('touchstart', function (e) {
				if (typeof e.stopPropagation == 'function') {
					e.stopPropagation();
					e.preventDefault();
				}

				if (e.originalEvent.touches && e.originalEvent.touches.length)
					e = e.originalEvent.touches[0];
				else if (e.originalEvent.changedTouches && e.originalEvent.changedTouches.length)
					e = e.originalEvent.changedTouches[0];

				rendering.itemDisplay.touch.newTouch = true;
				rendering.itemDisplay.touch.startX = e.pageX;
				rendering.itemDisplay.touch.startY = e.pageY;
			})
			.on('touchmove', function (e) {
				var shift;

				if (typeof e.stopPropagation == 'function') {
					e.stopPropagation();
					e.preventDefault();
				}

				if (!rendering.itemDisplay.touch.newTouch)
					return;

				if (e.originalEvent.touches && e.originalEvent.touches.length)
					e = e.originalEvent.touches[0];
				else if (e.originalEvent.changedTouches && e.originalEvent.changedTouches.length)
					e = e.originalEvent.changedTouches[0];

				shift = rendering.itemDisplay.touch.startX - e.pageX;

				if (Math.abs(shift) < 50)
					return

				rendering.itemDisplay.touch.newTouch = false;

				if (shift > 0)
					lightbox.showItem(rendering.activeItem + 1);
				else
					lightbox.showItem(rendering.activeItem - 1);
			})
			.on('touchend touchcancel', function (e) {
				if (typeof e.stopPropagation == 'function') {
					e.stopPropagation();
					e.preventDefault();
				}

				rendering.itemDisplay.touch.newTouch = false;
			});

		$(window).on('resize.socialMediaBox', function () {
			lightbox.resize();
		});


		return this;
	};


	$.fn.socialMediaBox4Journal = function (init) {
		var initSMB;

		if (smb4JSetup)
			return;

		smb4JSetup = true;

		initSMB = function () {
			var $clicked = $(this),
				clickedEntryId = $clicked.parents('.journalrow')[0].id,
				journalIds = '',
				moduleId = 0,
				journalInfo,
				$overlayBg = $('<div id="socialMediaBox4JournalOverlay"' + (typeof init.smbConfig == 'object' && init.smbConfig.baseClass ? ' class="' + init.smbConfig.baseClass + '"' : '') + '><div></div><p></p></div>'),
				$message = $('> p', $overlayBg),
				$loader = $('> div', $overlayBg),
				$body = $('body'),

				errorMessage = '',
				entries,

				close = function () {
					$(document).off('.socialMediaBox4Journal');
					$overlayBg.fadeTo(400, 0, function () {
						$overlayBg.remove();
					});
					$body.removeClass('socialMediaBoxActive');
					$message.css('display', 'none');
				},

				xhrRequest;

			$body
				.append($overlayBg)
				.addClass('socialMediaBoxActive');

			$overlayBg
				.fadeTo(400, 1)
				.on('click', '> p > .close', function () {
					close();

					return false;
				});

			$.each($clicked.parents('#journalItems').eq(0).find('>').has('.journalitem > .jphoto'), function (i, entry) {
				if(entry.id == clickedEntryId)
					init.smbConfig.openAt = i;

				journalIds += entry.id.substring(entry.id.indexOf('-') + 1) + ',';
			});
			journalIds = journalIds.substring(0, journalIds.length - 1);

			moduleId = getJournalModuleId($clicked.parents('.DnnModule-Journal').eq(0));

			journalInfo = getJournalInfo();

			xhrRequest = $.ajax({
				data: {
					action: 'journal_entries',
					journalIds: journalIds,
					journalModuleId: moduleId,
					journalType: journalInfo.type,
					journalTarget: journalInfo.target
				},
				dataType: 'json',
				type: 'POST',
				url: init.entriesUrl,
				timeout: 15000,
				cache: false,
				error: function () {
					errorMessage = init.errors.generalError;
				},
				success: function (response) {
					if (response.status == 'success'){
						entries = response.entries;
						if (entries.length == 0)
							errorMessage = init.errors.noJournalItems;
					} else
						errorMessage = response.message;
				},
				complete: function () {
					if (errorMessage != '') {
						$loader.fadeTo(200, 0, function () {
							$loader.css('display', 'none');
						});

						$message
							.html(errorMessage + '<span class="close">X</span>')
							.css({
								display: 'block',
								opacity: 0
							})
							.fadeTo(200, 1);

						return;
					}

					close();

					$('<div />')
						.data('socialMediaBox', entries)
						.socialMediaBox(init.smbConfig);
				}
			});

			$(document).on('keyup.socialMediaBox4Journal', function(e) {
				if (e.keyCode == 27) {
					xhrRequest.abort();
					close();

					return false;
				}
			});
		};

		$('.DnnModule-Journal')
			.on('click', '.journalitem > .jphoto a', function () {
				initSMB.call(this);
				return false;
			})
			.on('click', '.journalitem > .jphoto > img', initSMB)
			.on('mouseenter', '.journalitem > .jphoto > img', function () {
				var $this = $(this);

				$this.css('cursor', 'pointer');
			});

		return this;
	};
};

	if (typeof eds3_5_jq !== 'undefined')
		lightboxInit(eds3_5_jq);

})();
