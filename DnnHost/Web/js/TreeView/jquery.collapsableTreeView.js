(function($) {
    $.fn.CollapsableTreeViewCollection = {
        item: function(key) {

        }
    }
    $.fn.CollapsableTreeView = function(settings) {
        var config = { openfolderimage: '/js/TreeView/default/images/minus.gif', closedfolderimage: '/js/TreeView/default/images/plus.gif', openclass: 'jq_expanded', closedclass: 'jq_collapsed', collapsablecontainer: 'ul' };

        if (settings) $.extend(config, settings);

        this.each(function() {
            var tree = $(this);

            __init();

            function __init() {
                __setInitialState();
                __attachEvents();
                __stopPropagation();

                function __setInitialState() {
                    //Remove list style image from nodes without children ;
                    tree.find("ul > li:not(:has(" + config.collapsablecontainer + "))").each(function() {
                        $(this).css('list-style-image', 'none').css('list-style-type', 'none');
                    });

                    //Expand all list items containing the class 'expanded';
                    tree.find("ul > li." + config.openclass + ":has(" + config.collapsablecontainer + ")").each(function() {
                        $(this).css('list-style-image', 'url(' + config.openfolderimage + ')');
                    }).find("> " + config.collapsablecontainer).show();

                    //Collapse all list items containing the class 'collapsed';
                    tree.find("ul > li." + config.closedclass + ":has(" + config.collapsablecontainer + ")").each(function() {
                        $(this).css('list-style-image', 'url(' + config.closedfolderimage + ')');
                    }).find("> " + config.collapsablecontainer).hide();

                    //Collapse all list items containing the class 'collapsed';
                    tree.find("ul > li:not(." + config.openclass + "):not(." + config.closedclass + "):has(" + config.collapsablecontainer + ")").each(function() {
                        $(this).addClass(config.closedclass).css('list-style-image', 'url(' + config.closedfolderimage + ')');
                    }).find("> " + config.collapsablecontainer).hide();
                }

                function __expandNode() {
//                    debugger
                    var $this = $(this)
                    $this.parents("ul > li:has(" + config.collapsablecontainer + ")").each(function() {
                        __expand($(this))
                    })
                }

                function __attachEvents() {
                    //Append click event to list items containing children;
//                    tree.find("ul > li:has(" + config.collapsablecontainer + ")").click(function(e) {
//                        e.stopPropagation();

//                        __toggleListItemCollapseExpand($(this));
//                    });

                    tree.find("ul > li").each(function() {
                        //this is html element.
                        this.openNode = __expandNode
                    }).filter("ul > li:has(" + config.collapsablecontainer + ")").click(function(e) {
                        e.stopPropagation();

                        __toggleListItemCollapseExpand($(this));
                    });

                    //Collapse entire tree
                    if (config.collapseAllSelector) {
                        $(config.collapseAllSelector).click(function(event) {
                            event.preventDefault();
                            tree.find("ul > li." + config.openclass + ":has(" + config.collapsablecontainer + ")").each(function() {
                                __toggleListItemCollapseExpand($(this));
                            });
                        });
                    }

                    //Expand entire tree
                    if (config.expandAllSelector) {
                        $(config.expandAllSelector).click(function(event) {
                            event.preventDefault();
                            tree.find("ul > li." + config.closedclass + ":has(" + config.collapsablecontainer + ")").each(function() {
                                __toggleListItemCollapseExpand($(this));
                            });
                        });
                    }

                }



                function __stopPropagation() {
                    //Make sure a click on a list is not considered a click on the list item containing it
                    tree.find(config.collapsablecontainer).click(function(e) {
                        e.stopPropagation();
                    });
                    tree.find("input:checkbox").click(function(e) {
                        e.stopPropagation();
                    });
                    tree.find("label").click(function(e) {
                        e.stopPropagation();
                    });
                }

            }

            //Collapse List Item
            function __collapse(li) {
                li.find("> " + config.collapsablecontainer).hide();
                li.css('list-style-image', 'url(' + config.closedfolderimage + ')');
                li.toggleClass(config.openclass).toggleClass(config.closedclass);
            }

            //Expand List Item
            function __expand(li) {
                li.find("> " + config.collapsablecontainer).show();
                li.css('list-style-image', 'url(' + config.openfolderimage + ')');
                li.toggleClass(config.openclass).toggleClass(config.closedclass);
            }


            //Toggle List Item Collapse/Expand
            function __toggleListItemCollapseExpand(li) {

                if (li.attr("blocked") == "blocked") {
                    //ignore. toggle has been blocked.
                } else {
                    //toggle collapsed
                    if (li.hasClass(config.openclass)) {
                        __collapse(li)
                    } else {
                        __expand(li)
                    }
                }
            }
        });

        return this;
    }
})(jQuery);