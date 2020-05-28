(function ($, window, undefined) {
    'use strict';

    const allEvents = 'allEvents';
    const currentAndUpcoming = 'currentAndUpcoming';

    var hideItemClass = 'edn__myEvents_hide',
        activeItemClass = 'edn__myEvents_active',
        itemsHiddenClass = 'edn__myEvents_itemsHidden',
        pageReadyClass = 'edn__myEvents_pageReady',
        loadingClass = 'edn__myEvents_loading',
        noContentClass = 'edn__myEvents_noContent',
        contentErrorClass = 'edn__myEvents_contentError',
        disablePreviousPageClass = 'edn__myEvents_disablePreviousPage',
        disableNextPageClass = 'edn__myEvents_disableNextPage',
        triggeredPreviousPageClass = 'edn__myEvents_triggeredPreviousPage',
        triggeredNextPageClass = 'edn__myEvents_triggeredNextPage',
        button_AllEvents = 'edn__myEvents_button_allEvents',
        button_CurrentAndUpcoming = 'edn__myEvents_button_currentAndUpcoming',

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
                localeCode: self.options.localeCode,
                filterEventsBy: self.options.filterEventsBy
            }

            if (self.options.localeCode)
                $.extend(postData, { localeCode: self.options.localeCode });

            $.ajax({
                type: 'GET',
                url: self.options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/GetEventsList.ashx',
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
                        /* if (!response.contentCount) {
                             requestSuccessful = false;
                             return;
                         }*/

                        itemCache.totalItemCount = response.contentCount == 0 ? 1 : response.contentCount;
                    }

                    pageCache.content = response.contentHtml;
                    pageCache.loaded = true;
                })
                .fail(function (xhr, err) {
                })
                .always(function () {
                    pageCache.requesting = false;
                    pageCache.requestError = !requestSuccessful;

                    showPage.call(self, contentKey, page);
                });
        };

    function MyEvents(elem, options) {
        var self = this;
        self.options = options;
        self.itemCache = {};

        var i18n = function (key) {
            if (!self.options.i18n)
                return key;
            if (!self.options.i18n[key])
                return key;
            return self.options.i18n[key];
        };

        self.$moduleWrapper = $(elem);
        self.$contentWrapper = $('.edn__articleListWrapper', self.$moduleWrapper);
        self.$header = $('.edn__myEvents_header', self.$moduleWrapper);
        self.$headerTitle = $('.edn__myEvents_title', self.$header);
        self.$visibleItemList = $('.edn__myEvents_visibleItemList', self.$moduleWrapper);
        self.$hiddenItemWrapper = $('.edn__myEvents_hiddenItemWrapper', self.$moduleWrapper);
        self.$hiddenItemList = $('.edn__myEvents_hiddenItemList', self.$hiddenItemWrapper);
        self.$edn__myEvents_button_currentAndUpcoming = $('.edn__myEvents_button_currentAndUpcoming', self.$moduleWrapper);
        self.$edn__myEvents_button_allEvents = $('.edn__myEvents_button_allEvents', self.$moduleWrapper);

        self.itemCount = $('>', self.$visibleItemList).length;
        self.activeItemIndex = $('> .' + activeItemClass, self.$visibleItemList).index();

        self.verticalLayout = self.$visibleItemList.hasClass('edn__myEvents_vertical');

        if (self.verticalLayout)
            self.$heightReference = $('.edn__myEvents_heightReference', self.$moduleWrapper);

        var contentSwitchEvents = 'click fakeClick';

        if (self.$moduleWrapper.hasClass('edn__myEvents_hoverSwitch'))
            contentSwitchEvents += ' mouseenter';

        self.EventRegistration_Ashx_Action_Triggered = false;

        self.$moduleWrapper
            .on('click', '.edn__myEvents_hiddenItemWrapper .edn__myEvents_hiddenItemList >', function () {
                var $this = $(this);

                $this
                    .addClass(activeItemClass)
                    .siblings()
                    .removeClass(activeItemClass);

                $('> .' + hideItemClass, self.$visibleItemList)
                    .eq($this.index())
                    .trigger('fakeClick');
            })
            .on(contentSwitchEvents, '.edn__myEvents_visibleItemList >', function () {
                var $item = $(this);

                $item
                    .addClass(activeItemClass)
                    .siblings()
                    .removeClass(activeItemClass);

                self.activeItemIndex = $item.index();

                self.$moduleWrapper.removeClass(triggeredNextPageClass + ' ' + triggeredPreviousPageClass);

                requestPage.call(self, $item.data('meta').contentKey, 1);
            })
            .on('click', '.edn__myEvents_previousPage, .edn__myEvents_nextPage', function () {
                var $this = $(this),
                    nextPage = false;

                if ($this.hasClass('edn__myEvents_previousPage') && self.$moduleWrapper.hasClass(disablePreviousPageClass))
                    return;

                if ($this.hasClass('edn__myEvents_nextPage')) {
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

                var itemCache = self.itemCache[self.options.filterEventsBy],
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

                requestPage.call(self, self.options.filterEventsBy, page);
            })
            .on('click', '.edn__myEvents_button_allEvents', function () {

                self.$edn__myEvents_button_allEvents.addClass('edn_active');
                self.$edn__myEvents_button_currentAndUpcoming.removeClass('edn_active');

                self.options.filterEventsBy = allEvents;
                requestPage.call(self, allEvents, 1);
            })
            .on('click', '.edn__myEvents_button_currentAndUpcoming', function () {

                self.$edn__myEvents_button_allEvents.removeClass('edn_active');
                self.$edn__myEvents_button_currentAndUpcoming.addClass('edn_active');

                self.options.filterEventsBy = currentAndUpcoming;
                requestPage.call(self, currentAndUpcoming, 1);
            })
            .on('click', '.edn__myEvents_button_unregister', function () {
                var $this = $(this);
                var edsndata = $this.data("edsndata");

                if (!edsndata)
                    return;

                if (!edsndata.articleId)
                    return;

                if (self.EventRegistration_Ashx_Action_Triggered)
                    return;
                else
                    self.EventRegistration_Ashx_Action_Triggered = true;

                if (confirm(i18n('CancellationConfirmMsg.Text'))) {

                    var postData = {
                        portalId: self.options.portalId,
                        moduleId: self.options.moduleId,
                        tabId: self.options.tabId,
                        articleId: edsndata.articleId,
                        recurringId: edsndata.recurringId,
                        eventUserItemId: edsndata.eventUserItemId,
                        action: 'unregister'
                    }

                    $.ajax({
                        type: 'GET',
                        url: self.options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/EventRegistration.ashx',
                        cache: false,
                        dataType: 'json',
                        timeout: 15000,
                        data: postData
                    })
                        .done(function (response, status) {
                            self.itemCache[currentAndUpcoming] = {
                                pages: {},
                                totalItemCount: -1,
                                activePage: -1
                            };
                            if (self.itemCache[allEvents]) {
                                self.itemCache[allEvents] = {
                                    pages: {},
                                    totalItemCount: -1,
                                    activePage: -1
                                };
                            }
                        })
                        .always(function () {
                            self.EventRegistration_Ashx_Action_Triggered = false;
                            requestPage.call(self, self.options.filterEventsBy, 1);
                        });
                }
                else {
                    self.EventRegistration_Ashx_Action_Triggered = false;
                }
            });

        self.itemCache[currentAndUpcoming] = {
            pages: {
                '1': {
                    content: self.$contentWrapper[0].outerHTML,
                    loaded: true,
                    requesting: false,
                    requestError: false
                }
            },
            totalItemCount: options.initialContentItemCount == 0 ? 1 : options.initialContentItemCount,
            activePage: 1
        };

        self.resize();

        masonryInit.call(self);

        self.$moduleWrapper.addClass('edn__myEvents_ready');

        if (self.$edn__myEvents_button_currentAndUpcoming) {
            self.$edn__myEvents_button_currentAndUpcoming.addClass('edn_active');
        }

        $(window).on('resize', function () {
            self.resize();
        });
    }

    MyEvents.prototype = {
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

    var instanceKey = 'edNewsMyEvents',
        defaultOptions = {
            websiteClientRoot: '/',
            portalId: 0,
            moduleId: 0,
            tabId: 0,
            itemsPerPage: 5,
            initialContentItemCount: 0,
            masonry: false,
            filterEventsBy: currentAndUpcoming
        };

    $.fn.edNewsMyEvents = function (options) {
        options = $.extend({}, defaultOptions, options);

        return this.each(function () {
            var $self = $(this);

            if ($self.data(instanceKey))
                return;

            $self.data(instanceKey, new MyEvents(this, options));
        });
    };

})(eds3_5_jq, window);