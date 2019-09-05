(function ($, window, document, undefined) {
	var defaultOptions = {
		portalId: 0,
		articleid: 0,
		moduleId: 0,
		tabId: 0,
		websiteRoot: '/',
		isotope: false,
		rating: false,
		likes: false,
		votes: false,
		dynamicLoading: false,
		dynamicLoadingOnScroll: false,
		addThis: false,
		audioJs: false,
		inarticlelist:false,
		initialPage: 1,
		userLoggedIn: false,
		communityMode: false,
		contentParent: {
			type: '',
			id: 0
		},
		itemsRemaining: 0,
		lightbox: {
			provider: 'smb',
			options: {},
			items: [],
			events: {
				redirectBeforeClose: false
			}
		},
		comments: {
			enable: false,
			requireAuthorInfo: true,
			permissions: {
				commenting: true,
				editing: false,
				deleting: false
			}
		},
		map: {
			enable: false,
			markers: [],
			options: {
				latitude: 0,
				longitude: 0,
				zoom: 12,
				mapTypeId: 'HYBRID'
			}
		},
		flowplayerSwf: '',
		itemsUrl: ''
	},
		$window = $(window),
		$document = $(document),
		itemDataKey = 'itemData';

	function GravityGallery(elem, options) {
		var self = this;

		self.$mainWrapper = $(elem);
		self.$itemsList = $('.edsgg__itemsListContainer', self.$mainWrapper);

		self.options = $.extend(
			true,
			{},
			defaultOptions,
			$.isPlainObject(options) ? options : {}
		);

		self.currentPage = self.options.initialPage;
		self.itemLoadingInProgress = false;
		self.itemsRemaining = self.options.itemsRemaining;

		if (self.options.isotope)
			self.$itemsList.isotope({
				itemSelector: '.edsgg__itemContainer',
				sortBy: 'original-order',
				masonry: {
					isFitWidth: true
				}
			});

		if (self.options.likes)
			self.initLikes();

		if (self.options.dynamicLoading)
			self.initDynamicLoading();

		if ($.isArray(self.options.lightbox.items) && self.options.lightbox.items.length != 0 || $.isPlainObject(self.options.lightbox.items)) {
			if (self.options.lightbox.provider == 'smb')
				self.initSmb();
			else
				self.initSmbLight();
		}

		if (self.options.comments.enable)
			self.initComments();

		self.$mainWrapper.on('click', '.edsgg__itemContainer .edsgg__exifData .edsgg__extendedExifTableToggle', function () {
			var $exifData = $(this).parents('.edsgg__exifData'),
				$extendedExifTableWrapper = $('.edsgg__extendedExifTableWrapper', $exifData),

				showExtendedClass = 'edsgg__showExtendedExif';

			$exifData.toggleClass(showExtendedClass);

			if ($exifData.hasClass(showExtendedClass))
				$extendedExifTableWrapper
					.stop(true)
					.slideDown(200);
			else
				$extendedExifTableWrapper
					.stop(true)
					.slideUp(200);
		});

		if (self.options.map.enable)
			self.initMap();

		self.reinitialize();
	}

	GravityGallery.prototype = {
		reinitialize: function () {
			var self = this,
				imageLoadedKey = 'imageLoaded';

			if (self.options.isotope)
				$('> .edsgg__itemContainer img', self.$itemsList)
					.imagesLoaded()
						.progress(function (instance, image) {
							var $img = $(image.img);

							if ($img.data(imageLoadedKey))
								return;

							$img.data(imageLoadedKey, true);

							self.$itemsList.isotope('layout');
						});

			if (self.options.addThis) {
				window.addthis_config = {
					ui_delay: 500
				}

				if (window.addthis) {
					window.addthis = null;
					window._adr = null;
					window._atc = null;
					window._atd = null;
					window._ate = null;
					window._atr = null;
					window._atw = null;
				}

				$.getScript('//s7.addthis.com/js/300/addthis_widget.js')
					.done(function () {
						addthis.init();
					});
			}

			if (self.options.rating)
				self.initRating();

			if (self.options.audioJs)
				audiojs.createAll();

			fluidvids.init({
				selector: '.edsgg__embedWrapper iframe',
				players: ['www.youtube.com', 'player.vimeo.com']
			});

			if ($().flowplayer != undefined)
				$('.edsgg__flowplayer', self.$mainWrapper).flowplayer({
					swf: self.options.flowplayerSwf
				});
		},
		initMap: function () {
			var self = this,
				itemMap = new google.maps.Map(
					$('.edsgg__gMap', self.$mainWrapper)[0],
					{
						center: new google.maps.LatLng(self.options.map.options.latitude, self.options.map.options.longitude),
						zoom: self.options.map.options.zoom,
						mapTypeId: google.maps.MapTypeId[self.options.map.options.mapTypeId]
					}
				),
				infoWindow,
				markers = self.options.map.markers,
				marker,
				i;

			if ($.isArray(markers) && markers.length != 0) {
				for (i = 0; i < markers.length; i++) {
					marker = new google.maps.Marker({
						position: new google.maps.LatLng(markers[i].latitude, markers[i].longitude),
						map: itemMap,
						title: typeof markers[i].title == 'string' ? markers[i].title : ''
					});

					if (typeof markers[i].content == 'string' && markers[i].content != '') {
						infoWindow = new google.maps.InfoWindow();

						google.maps.event.addListener(
							marker,
							'click',
							function () {
								infoWindow.setContent(markers[i].content);
								infoWindow.open(itemMap, marker);
							}
						);
					}
				}
			}
		},
		initRating: function () {
			var self = this,
				dataKey = 'rateitEventRegistered';


			if ($().rateit != undefined)
				$('.edsgg__mediaRatingAction', self.$mainWrapper).rateit();

			$('div.edsgg__mediaRatingAction', self.$mainWrapper).each(function () {
				var $mediaRatingAction = $(this);

				if ($mediaRatingAction.data(dataKey))
					return;

				$mediaRatingAction.data(dataKey, true);

				$mediaRatingAction.bind('rated', function () {
					var $rateIt = $(this),
						$itemContainer = $mediaRatingAction.parents('.edsgg__itemContainer');

					$rateIt.rateit('readonly', true);

					$.ajax({
						type: 'GET',
						url: self.options.websiteRoot + 'DesktopModules/EasyDNNnews/ashx/SocialMediaBox.ashx',
						cache: false,
						dataType: 'json',
						timeout: 15000,
						data: {
							action: 'rate',
							portalId: self.options.portalId,
							moduleId: self.options.moduleId,
							articleid: self.options.articleid,
							entry: $itemContainer.data(itemDataKey).mediaId,
							rating: $rateIt.rateit('value')
						},
						success: function (response) {
							if (response.status != undefined && response.status == 'success') {
								$('.edsgg__mediaRatingValue', $itemContainer).text(response.score);
							}
						}
					});
				});
			});
		},
		initLikes: function () {
			var self = this;

			self.$mainWrapper.on('click', '.edsgg__likeAction', function () {
				var $this = $(this),
					$itemContainer = $this.parents('.edsgg__itemContainer'),
					$likeActions = $('.edsgg__likeAction', $itemContainer),
					inProgressClass = 'edsgg__actionInProgress',
					ajaxRequestKey = 'likeAjaxRequest',
					secondRequestKey = 'secondLikeAjaxRequest',
					previousRequest = $itemContainer.data(ajaxRequestKey),
					itemData = $itemContainer.data(itemDataKey),

					generateRequest = function (completeCallback) {
						var newLikes,
							likedClass = 'edsgg__liked',
							params = {
								portalId: self.options.portalId,
								moduleId: self.options.moduleId,
								mediaId: itemData.mediaId
							};

						if (itemData.likes.likedByUser) {
							$likeActions.removeClass(likedClass);
							itemData.likes.likedByUser = false;
						} else {
							$likeActions.addClass(likedClass);
							itemData.likes.likedByUser = true;
						}

						newLikes = parseInt(itemData.likes.numberOf, 10) + (itemData.likes.likedByUser ? 1 : -1);

						itemData.likes.numberOf = newLikes;
						$('.edsgg__numberOfLikes', $itemContainer).text(newLikes);

						if (typeof itemData.journalId == 'number') {
							params.action = 'like';
							params.journalid = itemData.journalId;
							params.liked = itemData.likes.likedByUser;
							params.articleid = itemData.likes.articleid;
						} else {
							params.action = 'media_like';
							params.vote = itemData.likes.likedByUser ? 1 : -1;
							params.articleid = itemData.likes.articleid;
						}

						$itemContainer.data(ajaxRequestKey, $.ajax({
							type: 'GET',
							url: self.options.websiteRoot + 'DesktopModules/EasyDNNnews/ashx/SocialMediaBox.ashx',
							cache: false,
							dataType: 'json',
							timeout: 15000,
							data: params,
							complete: completeCallback
						}));
					};

				if (!self.options.userLoggedIn && previousRequest) {
					if ($likeActions.hasClass(inProgressClass))
						return;

					$likeActions.addClass(inProgressClass);

					$itemContainer.data(secondRequestKey, function () {
						generateRequest(function () {
							$likeActions.removeClass(inProgressClass);

							$itemContainer
								.data(secondRequestKey, null)
								.data(ajaxRequestKey, null);
						});
					});

					return;
				}

				if (previousRequest && previousRequest.readyState != 4)
					previousRequest.abort();

				generateRequest(function () {
					if ($likeActions.hasClass(inProgressClass))
						$itemContainer.data(secondRequestKey)();
					else
						$itemContainer.data(ajaxRequestKey, null);
				});
			});
		},
		initDynamicLoading: function () {
			var self = this,
				loadMedia = function () {
					var params = {
						portalId: self.options.portalId,
						artmid: self.options.moduleId,
						articleid: self.options.articleid,
						moduleId: self.options.moduleId,
						tabId: self.options.tabId,
						page: self.currentPage + 1,
						inarticlelist: self.options.inarticlelist
					};

					if (self.itemsRemaining == 0 || self.itemLoadingInProgress)
						return false;

					self.itemLoadingInProgress = true;

					$('.edsgg__loadMediaTrigger', self.$mainWrapper).addClass('loading');
					//console.log(self.options.contentParent.type);
					//if (self.options.contentParent.type != '')
					//	if (self.options.contentParent.type == 'category')
					//		params.ecategory = self.options.contentParent.id;
					//	else if (self.options.contentParent.type == 'gallery')
					//		params.egallery = self.options.contentParent.id;

					$.ajax({
						type: 'GET',
						url: self.options.websiteRoot + 'DesktopModules/EasyDNNnews/ashx/GetGravityGaleryHtml.ashx',
						cache: false,
						dataType: 'json',
						timeout: 15000,
						data: params,
						success: function (response) {
							var $items;

							if (response.status != undefined && response.status == 'success') {
								var $allItems = $(response.itemsHtml),
									isotopeItems = [];

								$allItems.each(function () {
									var item = this;

									if ($(item).hasClass('edsgg__itemContainer'))
										if (self.options.isotope)
											isotopeItems.push(item);

									self.$itemsList.append(item);
								});

								if (self.options.isotope)
									self.$itemsList.isotope('insert', isotopeItems);

								self.reinitialize();

								$('.edsgg__loadMediaTriggerText > span', self.$mainWrapper).text(response.buttonText);

								self.itemsRemaining = response.itemsRemaining;
								if (self.itemsRemaining == 0)
									$('.edsgg__loadMediaWrapper', self.$mainWrapper).addClass('hide');

								self.currentPage++;
							}
						},
						complete: function () {
							self.itemLoadingInProgress = false;

							$('.edsgg__loadMediaTrigger', self.$mainWrapper).removeClass('loading');
						}
					});

					return false;
				};

			if (self.itemsRemaining == 0)
				return;

			if (self.options.dynamicLoadingOnScroll)
				$window.scroll(function () {
					if ($document.height() - $window.scrollTop() - $window.height() < 500)
						loadMedia();
				});

			self.$mainWrapper.on('click', '.edsgg__loadMediaTrigger', loadMedia);
		},
		initSmb: function () {
			var self = this;

			self.$mainWrapper.on('click', '.edsgg__itemDetailsAndLightboxTrigger', function (e) {
				var $this = $(this),
					$itemContainer = $this.parents('.edsgg__itemContainer'),
					itemId = $itemContainer.data(itemDataKey).mediaId,
					items = self.options.lightbox.items,
					smbOptions = {
						openAt: 0
					};

				if (self.options.contentParent.type == 'category' && $.isPlainObject(self.options.lightbox.items) && $.isArray(self.options.lightbox.items[itemId])) {
					items = self.options.lightbox.items[itemId];
				} else {
					$.each(items, function (i, item) {
						if (item.id == itemId) {
							smbOptions.openAt = i;

							return false;
						}
					});
				}

				if (self.options.lightbox.events.redirectBeforeClose) {
					smbOptions.events = {
						onBeforeClose: function (state) {
							var activeItem = state.displayItems[state.activeItem];

							if (activeItem.id == itemId)
								return;

							if (typeof self.options.itemsUrl == 'string' && self.options.itemsUrl != '') {
								window.location = self.options.itemsUrl.replace('--itemId--', activeItem.id);
								return false;
							}
						}
					}
				}

				smbOptions = $.extend(true, {}, self.options.lightbox.options, smbOptions);

				$('<p />')
					.data('socialMediaBox', items)
					.socialMediaBox(smbOptions);

				e.preventDefault();
			});
		},
		initSmbLight: function () {
			var self = this;

			self.$mainWrapper.on('click', '.edsgg__itemDetailsAndLightboxTrigger', function (e) {
				var $this = $(this),
					$itemContainer = $this.parents('.edsgg__itemContainer'),
					itemId = $itemContainer.data(itemDataKey).mediaId,
					items = self.options.lightbox.items,
					smbOptions = {
						openAt: 0
					};

				if (self.options.contentParent.type == 'category' && $.isPlainObject(self.options.lightbox.items) && $.isArray(self.options.lightbox.items[itemId])) {
					items = self.options.lightbox.items[itemId];
				} else {
					$.each(items, function (i, item) {
						if (item.id == itemId) {
							smbOptions.openAt = i;

							return false;
						}
					});
				}

				if (self.options.lightbox.events.redirectBeforeClose) {
					smbOptions.events = {
						onBeforeClose: function (state) {
							var activeItem = state.displayItems[state.activeItem];

							if (activeItem.id == itemId)
								return;

							if (typeof self.options.itemsUrl == 'string' && self.options.itemsUrl != '') {
								window.location = self.options.itemsUrl.replace('--itemId--', activeItem.id);
								return false;
							}
						}
					}
				}

				smbOptions = $.extend(true, {}, self.options.lightbox.options, smbOptions);

				new SmbLight_1(items, smbOptions);

				e.preventDefault();
			});
		},
		initComments: function () {
			var self = this,
				emailValidation = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
				$commentsListContainer = $('.edsgg__itemContainer .edsgg__itemCommentsWrapper .edsgg__commentsListContainer', self.$mainWrapper),
				commentVotedClass = 'edsgg__commentVoting_voted',
				commentGoodVoteClass = 'edsgg__commentVoting_upvote',
				commentBadVoteClass = 'edsgg__commentVoting_downvote';

			$commentsListContainer.on('click', '.edsgg__commentVoting_trigger', function () {
				var $this = $(this),
					$commentContainer = $this.parents('.edsgg__itemCommentContainer'),
					goodVotes = $commentContainer.data('goodVotes'),
					badVotes = $commentContainer.data('badVotes'),
					goodVoteTriggered = $this.hasClass(commentGoodVoteClass),
					userVoted = $commentContainer.data('userVoted'),
					previousRequest = $commentContainer.data('commentVoteRequest');

				if (previousRequest && previousRequest.readyState != 4)
					previousRequest.abort();

				if ($this.hasClass(commentVotedClass)) {
					$this.removeClass(commentVotedClass);
					userVoted = '';

					if (goodVoteTriggered) {
						if (goodVotes > 0)
							goodVotes -= 1;
					} else {
						if (badVotes > 0)
							badVotes -= 1;
					}
				} else {
					$this.addClass(commentVotedClass);

					if (goodVoteTriggered) {
						goodVotes += 1;

						if (userVoted == 'bad' && badVotes > 0)
							badVotes -= 1;

						userVoted = 'good';

						$('.' + commentBadVoteClass, $commentContainer).removeClass(commentVotedClass);
					} else {
						badVotes += 1;

						if (userVoted == 'good' && goodVotes > 0)
							goodVotes -= 1;

						userVoted = 'bad';

						$('.' + commentGoodVoteClass, $commentContainer).removeClass(commentVotedClass);
					}
				}

				$commentContainer
					.data('commentVoteRequest', $.ajax({
						type: 'GET',
						url: '/DesktopModules/EasyDNNGallery/Services/SocialMediaBox.ashx',
						dataType: 'json',
						data: {
							portalId: self.options.portalId,
							moduleId: self.options.moduleId,
							action: 'comment_vote',
							commentId: $commentContainer.data('commentId'),
							voteType: goodVoteTriggered ? 'good' : 'bad'
						},
						complete: function () {
							$commentContainer.data('commentVoteRequest', undefined);
						}
					}))
					.data('badVotes', badVotes)
					.data('goodVotes', goodVotes)
					.data('userVoted', userVoted);

				$('.edsgg__commentVoting_badVotes', $commentContainer).text(badVotes);
				$('.edsgg__commentVoting_goodVotes', $commentContainer).text(goodVotes);
			});

			if (self.options.comments.permissions.commenting) {
				self.$mainWrapper.on('click', '.edsgg__itemContainer .edsgg__itemCommentsWrapper .edsgg__commentsCommentFormWrapper .edsgg__commentsSubmitComment', function (e) {
					var $this = $(this),
						$commentsCommentFormWrapper = $this.parents('.edsgg__commentsCommentFormWrapper'),
						$itemContainer = $commentsCommentFormWrapper.parents('.edsgg__itemContainer'),
						$noCommentError = $('.edsgg__commentsNoCommentError', $commentsCommentFormWrapper),
						$authorEmailInvalidError = $('.edsgg__commentsInvalidEmailError', $commentsCommentFormWrapper),
						$authorNoEmailError = $('.edsgg__commentsNoEmailError', $commentsCommentFormWrapper),
						$authorNoNameError = $('.edsgg__commentsNoNameError', $commentsCommentFormWrapper),
						$commentsListContainer = $('.edsgg__commentsListContainer', $commentsCommentFormWrapper.parents('.edsgg__itemCommentsWrapper')),

						$commentInput = $('.edsgg__commentsCommentInput', $commentsCommentFormWrapper),
						$authorNameInput = $('.edsgg__commentsAuthorNameInput', $commentsCommentFormWrapper),
						$authorEmailInput = $('.edsgg__commentsAuthorEmailInput', $commentsCommentFormWrapper),

						$numberOfComments = $('.edsgg__numberOfComments', $itemContainer),

						itemData = $itemContainer.data(itemDataKey),
						comment = $commentInput.val(),
						authorName,
						authorEmail,
						params = {
							portalId: self.options.portalId,
							moduleId: self.options.moduleId,
							action: 'add_comment',
							entry: itemData.mediaId,
							gravityGallery: 1,
							tabid: self.options.tabId,
							mediaurl: window.location.href
						},
						errorOccurred = false,

						targetIdMatch,
						journalTargetId = 0,
						journalType = 'summary';

					if ($commentsCommentFormWrapper.hasClass('edsgg__addingComment'))
						return;

					if (self.options.communityMode && itemData.journalId) {
						targetIdMatch = location.href.match(/\/userid\/\d+\//i);
						if (targetIdMatch != null) {
							journalTargetId = targetIdMatch[0].match(/\d+/)[0];
							journalType = 'profile';
						} else {
							targetIdMatch = location.href.match(/\/groupid\/\d+\//i);
							if (targetIdMatch != null) {
								journalTargetId = targetIdMatch[0].match(/\d+/)[0];
								journalType = 'group';
							}
						}

						params.journalid = itemData.journalId;
						params.journalType = journalType;
						params.journalModuleId = 0;
						params.journalTarget = journalTargetId;
					}

					$noCommentError.removeClass('show');
					$authorEmailInvalidError.removeClass('show');
					$authorNoEmailError.removeClass('show');
					$authorNoNameError.removeClass('show');

					if (typeof comment != 'string' || comment == '') {
						errorOccurred = true;
						$noCommentError.addClass('show');
					}

					if (self.options.comments.requireAuthorInfo) {
						authorName = $authorNameInput.val();
						authorEmail = $authorEmailInput.val();

						if (typeof authorName != 'string' || authorName == '') {
							errorOccurred = true;
							$authorNoNameError.addClass('show');
						}

						if (typeof authorEmail != 'string' || authorEmail == '') {
							errorOccurred = true;
							$authorNoEmailError.addClass('show');
						} else if (!emailValidation.test(authorEmail)) {
							errorOccurred = true;
							$authorEmailInvalidError.addClass('show');
						}
					}

					if (!errorOccurred) {
						params.comment = comment;

						if (self.options.comments.requireAuthorInfo) {
							params.name = authorName;
							params.email = authorEmail;
						}

						$commentsCommentFormWrapper.addClass('edsgg__addingComment');

						$.ajax({
							type: 'POST',
							url: '/DesktopModules/EasyDNNGallery/Services/SocialMediaBox.ashx',
							dataType: 'json',
							data: params,
							success: function (response) {
								if (response.status != undefined && response.status == 'success') {
									$commentsListContainer
										.removeClass('noComments')
										.append(response.gravityCommentHTML);

									$commentInput.val('');
									$authorNameInput.val('');
									$authorEmailInput.val('');

									itemData.comments.numberOf += 1;
									$numberOfComments.text(itemData.comments.numberOf);
								}
							},
							complete: function () {
								$commentsCommentFormWrapper.removeClass('edsgg__addingComment');
							}
						});
					}
				});
			}

			if (self.options.comments.permissions.editing) {
				$commentsListContainer.on('click', '.edsgg__itemCommentContainer .edsgg__editComment', function () {
					var $this = $(this),
						$itemCommentContainer = $this.parents('.edsgg__itemCommentContainer');

					if ($itemCommentContainer.hasClass('edsgg__editingComment'))
						return;

					$('.edsgg__editCommentContainer .edsgg__editCommentContent', $itemCommentContainer).val($itemCommentContainer.data('rawComment'));

					$itemCommentContainer.addClass('edsgg__editingComment');
				});

				$commentsListContainer.on('click', '.edsgg__itemCommentContainer .edsgg__editCommentContainer .edsgg__editCommentCancelTrigger', function () {
					var $this = $(this),
						$editCommentContainer = $this.parents('.edsgg__editCommentContainer'),
						$itemCommentContainer = $editCommentContainer.parents('.edsgg__itemCommentContainer');

					$itemCommentContainer.removeClass('edsgg__editingComment');

					$('.edsgg__editCommentContent', $editCommentContainer).val('');
				});

				$commentsListContainer.on('click', '.edsgg__itemCommentContainer .edsgg__editCommentContainer .edsgg__editCommentSaveTrigger', function () {
					var $this = $(this),
						$editCommentContainer = $this.parents('.edsgg__editCommentContainer'),
						$itemCommentContainer = $editCommentContainer.parents('.edsgg__itemCommentContainer'),
						$newComment = $('.edsgg__editCommentContent', $editCommentContainer),

						commentId = $itemCommentContainer.data('commentId'),
						commentContent = $newComment.val();

					if ($itemCommentContainer.hasClass('edsgg__savingChanges'))
						return;

					if (commentContent == '') {
						$('.edsgg__commentsNoCommentError', $editCommentContainer).addClass('show');

						return;
					}

					$itemCommentContainer.addClass('edsgg__savingChanges');

					$('.edsgg__commentsNoCommentError', $editCommentContainer).removeClass('show');

					$.ajax({
						type: 'GET',
						url: '/DesktopModules/EasyDNNGallery/Services/SocialMediaBox.ashx',
						dataType: 'json',
						data: {
							portalId: self.options.portalId,
							moduleId: self.options.moduleId,
							action: 'edit_comment',
							comment: commentContent,
							id: commentId
						},
						success: function (response) {
							if (response.status != undefined && response.status == 'success') {
								$('.edsgg__commentContent', $itemCommentContainer).html(response.comment);
								$newComment.val('');

								$itemCommentContainer.data('rawComment', commentContent);
							}
						},
						complete: function () {
							$itemCommentContainer.removeClass('edsgg__savingChanges edsgg__editingComment')
						}
					});
				});
			}

			if (self.options.comments.permissions.deleting) {
				$commentsListContainer.on('click', '.edsgg__itemCommentContainer .edsgg__deleteComment', function () {
					var $this = $(this),
						$itemCommentContainer = $this.parents('.edsgg__itemCommentContainer'),
						$itemContainer = $itemCommentContainer.parents('.edsgg__itemContainer'),
						$numberOfComments = $('.edsgg__numberOfComments', $itemContainer),

						itemData = $itemContainer.data(itemDataKey),
						commentRemoved = false;

					if (confirm('Do you really want to delete this comment?')) {
						if ($itemCommentContainer.hasClass('edsgg__deletingComment'))
							return;

						$itemCommentContainer.addClass('edsgg__deletingComment');

						$.ajax({
							type: 'GET',
							url: '/DesktopModules/EasyDNNGallery/Services/SocialMediaBox.ashx',
							dataType: 'json',
							data: {
								portalId: self.options.portalId,
								moduleId: self.options.moduleId,
								action: 'delete_comment',
								id: $itemCommentContainer.data('commentId')
							},
							success: function (response) {
								if (response.status != undefined && response.status == 'success') {
									commentRemoved = true;

									$itemCommentContainer.slideUp(200, function () {
										$itemCommentContainer.remove();
									});

									if (itemData.comments.numberOf > 0)
										itemData.comments.numberOf -= 1;

									$numberOfComments.text(itemData.comments.numberOf);
								}
							},
							complete: function () {
								if (!commentRemoved)
									$itemCommentContainer.removeClass('edsgg__deletingComment');
							}
						});
					}
				});
			}
		}
	};

	$.fn.edsGravityGallery = function () {
		var args = arguments,
			gravityGalleryInstanceKey = 'eds_gravityGallery';

		return this.each(function () {
			var self = this;

			if (!$.data(self, gravityGalleryInstanceKey))
				$.data(self, gravityGalleryInstanceKey, new GravityGallery(self, args[0]));
		});
	};

})(eds1_8, window, document)

/*! Fluidvids v2.2.0 | (c) 2014 @toddmotto | github.com/toddmotto/fluidvids */
!function (a, b) { "function" == typeof define && define.amd ? define(b) : "object" == typeof exports ? module.exports = b : a.fluidvids = b() }(this, function () { "use strict"; var a = { selector: "iframe", players: ["www.youtube.com", "player.vimeo.com"] }, b = document.head || document.getElementsByTagName("head")[0], c = ".edsgg_fluidVideo{width:100%;position:relative;}.edsgg_fluidVideo iframe{position:absolute;top:0px;left:0px;width:100%;height:100%;}", d = function (b) { var c = new RegExp("^(https?:)?//(?:" + a.players.join("|") + ").*$", "i"); return c.test(b) }, e = function (a) { if (!a.getAttribute("data-fluidvids")) { var b = document.createElement("div"), c = parseInt(a.height ? a.height : a.offsetHeight, 10) / parseInt(a.width ? a.width : a.offsetWidth, 10) * 100; a.parentNode.insertBefore(b, a), a.setAttribute("data-fluidvids", "loaded"), b.className += "edsgg_fluidVideo", b.style.paddingTop = c + "%", b.appendChild(a) } }, f = function () { var a = document.createElement("div"); a.innerHTML = "<p>x</p><style>" + c + "</style>", b.appendChild(a.childNodes[1]) }; return a.apply = function () { for (var b = document.querySelectorAll(a.selector), c = 0; c < b.length; c++) { var f = b[c]; d(f.src) && e(f) } }, a.init = function (b) { for (var c in b) a[c] = b[c]; a.apply(), f() }, a });