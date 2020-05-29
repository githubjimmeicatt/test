(function ($, window, undefined) {
	'use strict';

	var hideItemClass = 'edn__contentBlock_hide',
		activeItemClass = 'edn__contentBlock_active',
		itemsHiddenClass = 'edn__contentBlock_itemsHidden',
		pageReadyClass = 'edn__contentBlock_pageReady',
		loadingClass = 'edn__contentBlock_loading',
		noContentClass = 'edn__contentBlock_noContent',
		contentErrorClass = 'edn__contentBlock_contentError',
		disablePreviousPageClass = 'edn__contentBlock_disablePreviousPage',
		disableNextPageClass = 'edn__contentBlock_disableNextPage',
		triggeredPreviousPageClass = 'edn__contentBlock_triggeredPreviousPage',
		triggeredNextPageClass = 'edn__contentBlock_triggeredNextPage',

		masonryInit = function () {
			var self = this;

			if (self.options.masonry)
				self.$contentWrapper
					.isotope({
						sortBy: 'original-order',
						masonry: {
							isFitWidth: true
						}
					})
					.find('img').imagesLoaded()
						.progress(function () {
							self.$contentWrapper.isotope('layout');
						});
		},

		postShow = function () {
			var self = this;

			if (self.verticalLayout)
				self.resize();
		},

		showPage = function (contentKey, page) {
			var self = this,
				$activeItem = $('>', self.$visibleItemList).eq(self.activeItemIndex);

			if ($activeItem.length > 0 && $activeItem.data('meta').contentKey != contentKey)
				return;

			var itemCache = self.itemCache[contentKey],
				pageCache = itemCache.pages[page + ''];

			if (itemCache.activePage != page)
				return;

			self.$moduleWrapper
				.removeClass(pageReadyClass)
				.removeClass(loadingClass)
				.removeClass(noContentClass)
				.removeClass(contentErrorClass)
				.removeClass(disablePreviousPageClass)
				.removeClass(disableNextPageClass);

			clearTimeout(self.pageReadyTimeout);

			self.pageReadyTimeout = setTimeout(function () {
				self.$moduleWrapper.addClass(pageReadyClass);
			}, 100);

			if (itemCache.totalItemCount == 0) {
				self.$moduleWrapper.addClass(noContentClass);
				postShow.call(self);
				return;
			}

			if (itemCache.totalItemCount == -1 || (!pageCache.loaded && pageCache.requestError)) {
				self.$moduleWrapper.addClass(contentErrorClass);
				postShow.call(self);
				return;
			}

			if (pageCache.loaded) {
				if (page == 1)
					self.$moduleWrapper.addClass(disablePreviousPageClass);

				if (Math.ceil(itemCache.totalItemCount / self.options.itemsPerPage) <= page)
					self.$moduleWrapper.addClass(disableNextPageClass);

				self.$contentWrapper.replaceWith(pageCache.content);
				self.$contentWrapper = $('.edn__articleListWrapper', self.$moduleWrapper);
				masonryInit.call(self);

				postShow.call(self);
			}
		},

		requestPage = function (contentKey, page) {
			var self = this,
				itemCache = self.itemCache[contentKey],
				pageCache;

			if (!itemCache) {
				itemCache = {
					pages: {},
					totalItemCount: -1,
					activePage: -1
				};

				self.itemCache[contentKey] = itemCache;
			}

			if (page < 1)
				page = 1;

			if (itemCache.totalItemCount != -1) {
				var numOfPages = Math.ceil(itemCache.totalItemCount / self.options.itemsPerPage);

				if (page > numOfPages)
					page = numOfPages;
			}

			itemCache.activePage = page;

			if (itemCache.totalItemCount == 0) {
				showPage.call(self, contentKey, page);
				return;
			}

			var pageKey = page + ''

			pageCache = itemCache.pages[pageKey];

			if (pageCache) {
				if (pageCache.loaded) {
					showPage.call(self, contentKey, page);
					return;
				}

				if (pageCache.requesting) {
					self.$moduleWrapper.addClass(loadingClass);
					return;
				}
			} else {
				itemCache.pages[pageKey] = pageCache = {
					content: '',
					loaded: false,
					requesting: true,
					requestError: false
				};
			}

			if (itemCache.totalItemCount == -1) {
				self.$moduleWrapper.addClass(disablePreviousPageClass + ' ' + disableNextPageClass);
			}

			self.$moduleWrapper.addClass(loadingClass);
			pageCache.requesting = true;

			var requestSuccessful = false,
				requestTotalItemCount = itemCache.totalItemCount == -1;

            var postData = {
                portalId: self.options.portalId,
                moduleId: self.options.moduleId,
                tabId: self.options.tabId,
                contentKey: contentKey,
                contentPage: page,
                getPaginationMeta: requestTotalItemCount,
                localeCode: self.options.localeCode
            }

            if (self.options.localeCode)
                $.extend(postData, { localeCode: self.options.localeCode });

			$.ajax({
				type: 'GET',
				url: self.options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ListContentHtml.ashx',
				cache: false,
				dataType: 'json',
				timeout: 15000,
                data: postData
			})
				.done(function (response, status) {
					requestSuccessful = true;

					if (status == 'nocontent' || !$.isPlainObject(response)) {
						itemCache.totalItemCount = 0;
						pageCache.loaded = true;
						return;
					}

					if (requestTotalItemCount) {
						if (!response.contentCount) {
							requestSuccessful = false;
							return;
						}

						itemCache.totalItemCount = response.contentCount;
					}

					pageCache.content = response.contentHtml;
					pageCache.loaded = true;
				})
				.always(function () {
					pageCache.requesting = false;
					pageCache.requestError = !requestSuccessful;

					showPage.call(self, contentKey, page);
				});
		};

	function ContentBlock (elem, options) {
		var self = this;

		self.options = options;
		self.itemCache = {};

		self.$moduleWrapper = $(elem);
		self.$contentWrapper = $('.edn__articleListWrapper', self.$moduleWrapper);
		self.$header = $('.edn__contentBlock_header', self.$moduleWrapper);
		self.$headerTitle = $('.edn__contentBlock_title', self.$header);
		self.$visibleItemList = $('.edn__contentBlock_visibleItemList', self.$moduleWrapper);
		self.$hiddenItemWrapper = $('.edn__contentBlock_hiddenItemWrapper', self.$moduleWrapper);
		self.$hiddenItemList = $('.edn__contentBlock_hiddenItemList', self.$hiddenItemWrapper);

		self.itemCount = $('>', self.$visibleItemList).length;
		self.activeItemIndex = $('> .' + activeItemClass, self.$visibleItemList).index();

		self.verticalLayout = self.$visibleItemList.hasClass('edn__contentBlock_vertical');

		if (self.verticalLayout)
			self.$heightReference = $('.edn__contentBlock_heightReference', self.$moduleWrapper);

		var contentSwitchEvents = 'click fakeClick';

		if (self.$moduleWrapper.hasClass('edn__contentBlock_hoverSwitch'))
			contentSwitchEvents += ' mouseenter';

		self.$moduleWrapper
			.on('click', '.edn__contentBlock_hiddenItemWrapper .edn__contentBlock_hiddenItemList >', function () {
				var $this = $(this);

				$this
					.addClass(activeItemClass)
					.siblings()
						.removeClass(activeItemClass);

				$('> .' + hideItemClass, self.$visibleItemList)
					.eq($this.index())
						.trigger('fakeClick');
			})
			.on(contentSwitchEvents, '.edn__contentBlock_visibleItemList >', function () {
				var $item = $(this);

				$item
					.addClass(activeItemClass)
					.siblings()
						.removeClass(activeItemClass);

				self.activeItemIndex = $item.index();

				self.$moduleWrapper.removeClass(triggeredNextPageClass + ' ' + triggeredPreviousPageClass);

				requestPage.call(self, $item.data('meta').contentKey, 1);
			})
			.on('click', '.edn__contentBlock_previousPage, .edn__contentBlock_nextPage', function () {
				var $this = $(this),
					nextPage = false;

				if ($this.hasClass('edn__contentBlock_previousPage') && self.$moduleWrapper.hasClass(disablePreviousPageClass))
					return;

				if ($this.hasClass('edn__contentBlock_nextPage')) {
					if (self.$moduleWrapper.hasClass(disableNextPageClass))
						return;

					nextPage = true;

					self.$moduleWrapper
						.addClass(triggeredNextPageClass)
						.removeClass(triggeredPreviousPageClass);
				} else {
					self.$moduleWrapper
						.addClass(triggeredPreviousPageClass)
						.removeClass(triggeredNextPageClass);
				}

				var activeItemContentKey = '-1',
					$items = $('>', self.$visibleItemList);

				if ($items.length)
					activeItemContentKey = $items.eq(self.activeItemIndex).data('meta').contentKey;

				var itemCache = self.itemCache[activeItemContentKey],
					page = 1;

				if (itemCache) {
					if (itemCache.totalItemCount <= 0)
						return;

					page = itemCache.activePage;
				}

				if (nextPage)
					page++;
				else
					page--;

				requestPage.call(self, activeItemContentKey, page);
			});

		self.itemCache['-1'] = {
			pages: {
				'1': {
					content: self.$contentWrapper[0].outerHTML,
					loaded: true,
					requesting: false,
					requestError: false
				}
			},
			totalItemCount: options.initialContentItemCount,
			activePage: 1
		};

		self.resize();

		masonryInit.call(self);

		self.$moduleWrapper.addClass('edn__contentBlock_ready');

		$(window).on('resize', function () {
			self.resize();
		});
	}

	ContentBlock.prototype = {
		resize: function (skipTimeout) {
			var self = this,
				hideItems = false;

			$('>', self.$visibleItemList).removeClass(hideItemClass);

			if (self.verticalLayout) {
				if (self.$heightReference.length == 0)
					return;

				var availableHeight = self.$heightReference.outerHeight(true);

				if (self.$visibleItemList.outerHeight(true) > availableHeight) {
					hideItems = true;

					var i = self.itemCount - 1;

					self.$hiddenItemList.empty();

					while (i >= 0 && self.$visibleItemList.outerHeight(true) > availableHeight) {
						var $item = $('>', self.$visibleItemList).eq(i);

						$item.addClass(hideItemClass);
						self.$hiddenItemList.prepend($item.clone(true));

						i--;
					}
				}

				clearTimeout(self.reResizeTimeout);

				if (!skipTimeout) {
					self.reResizeTimeout = setTimeout(function () {
						self.resize(true);
					}, 1000);
				}
			} else {
				var availableWidth = self.$header.innerWidth() - (self.$headerTitle.length == 0 ? 0 : self.$headerTitle.outerWidth(true)) - 20;

				if (self.$visibleItemList.outerWidth(false) > availableWidth) {
					hideItems = true;

					var i = self.itemCount - 1;

					self.$hiddenItemList.empty();

					while (i >= 0 && self.$visibleItemList.outerWidth(false) > availableWidth) {
						var $item = $('>', self.$visibleItemList).eq(i);

						$item.addClass(hideItemClass);
						self.$hiddenItemList.prepend($item.clone(true));

						i--;
					}
				}
			}

			if (hideItems) {
				self.$visibleItemList.addClass(itemsHiddenClass);
				self.$hiddenItemWrapper.addClass(itemsHiddenClass);
			} else {
				self.$visibleItemList.removeClass(itemsHiddenClass);
				self.$hiddenItemWrapper.removeClass(itemsHiddenClass);
			}
		}
	};

	var instanceKey = 'edNewsContentBlock',
		defaultOptions = {
			websiteClientRoot: '/',
			portalId: 0,
			moduleId: 0,
			tabId: 0,
			itemsPerPage: 5,
			initialContentItemCount: 0,
            masonry: false
		};

	$.fn.edNewsContentBlock = function (options) {
		options = $.extend({}, defaultOptions, options);

		return this.each(function () {
			var $self = $(this);

			if ($self.data(instanceKey))
				return;

			$self.data(instanceKey, new ContentBlock(this, options));
		});
	};

})(eds3_5_jq, window);