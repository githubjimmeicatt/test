//
// Application - ICATT Mvc core v1.1.1
//
(function () {
    var logindent = "";
    var consoleOpen = false;
    var consoleChecked = false;

    function nullLogger(fmessage) {

    }

    function consoleLogger(fmessage) {
        if (!isFunc(fmessage)) {
            throw new Error("MUST provide a function that returns a string for logging");
        }
        if (!consoleChecked) {
            if (console && console.log) {
                var img = new Image();
                if (img.__defineGetter__) img.__defineGetter__('id', function () { consoleOpen = true; });
                console.log(img);
                consoleChecked = true;
            }
        }
        if (consoleOpen) {
            if (console && console.log) {
                console.log(logindent + fmessage.apply(this));
            }
        }
    }

    var logf = consoleLogger;

    function logIndent() {
        logindent = logindent + "  ";
    }
    function logUnindent() {
        if (logindent.length >= 2) {
            logindent = logindent.substr(0, logindent.length - 2);
        }
    }

    function isArray(val) {
        return $.isArray(val);
    }


    function isUndDef(val) {
        return "undefined" === typeof val;
    }

    function isNull(val) {
        return null === val;
    }

    function isFunc(val) {
        return "function" === typeof val;
    }

    function isObj(val) {
        return "object" === typeof val;
    }

    function isString(val) {
        return "string" === typeof val;
    }

    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function (elt /*, from*/) {
            var len = this.length >>> 0;
            var from = Number(arguments[1]) || 0;
            from = (from < 0)
                ? Math.ceil(from)
                : Math.floor(from);
            if (from < 0)
                from += len;

            for (from = len; from--;) {
                if (from in this &&
                    this[from] === elt)
                    return from;
            }
            return -1;
        };
    }

    $.fn.jsmvc = function (configuration) {

        var settings = {
            paths: {
                controllers: '/Controller/',
                views: '/View/',
                models: '/Model/'
            },
            defaultModelFileName: 'Models.ashx',
            shared: {
                views: [],
                templates: {}
            },
            confirmNavigation: function () {
                return confirm("Weet u zeker dat u dit scherm wilt verlaten? Niet opgeslagen gegevens gaan verloren.");
            },
            logAjaxErrors: false,
            logenabled: false,
            start: function (app) { },
            appnavigate: function (app) { },
            renderComplete: function (app, context) { },
            modelLoadException: function (app) { },
            unauthorized: function (app) { },
            notfound: function (app) { }
        };

        if (configuration) {
            $.extend(settings, configuration);
        }

        if (!settings.logenabled)
            logf = nullLogger;
        else
            logf = consoleLogger;

        if (configuration.paths && !configuration.endpoints) {
            settings.endpoints = configuration.paths;
        }

        logf.call(this, function () { return "jsmvc contructor" });

        var controllerScriptCache = (function () {
            var controllers = [];
            var add = function (controller) {
                if (!inCache(controller)) {
                    logf.call(this, function () { return "'" + controller + "': cache: script add" });
                    controllers.push(controller);
                }
            };
            var inCache = function (controller) {
                var notfound = " not";
                var retval = (controllers.indexOf(controller) >= 0);
                if (retval) {
                    notfound = "";
                }
                logf.call(this, function () { return "'" + controller + "': cache: script" + notfound + " found" });
                return retval;
            };
            return {
                add: add,
                inCache: inCache
            };
        })();

        var createControllerInstance = function (e) {
            var controllerInfo = controllers[e.controller](app);
            var controllerInstance = controllerInfo.controller;

            controllerInstance.controller = e.controller;
            controllerInstance.app = app;
            controllerInstance.placeholder = e.placeholder;

            //if a function is defined for extending the controller, e.g. by adding viewrendered handlers, execute it here
            if (isFunc(controllerInfo.extend))
                controllerInfo.extend(controllerInstance);

            logf.call(this, function () { return "'" + e.controller + "': pageless instance created for placeholder:'" + e.placeholder + "'" });

            return controllerInstance;
        }

        var controllerInstanceCache = (function () {
            var pages = {};
            return {
                get: function (e, page) {
                    var controllersInstances = pages[page];
                    if (!controllersInstances) {
                        controllersInstances = {}
                        pages[page] = controllersInstances;
                        logf.call(this, function () { return "page '" + page + "': new controller instance cache" });
                    }
                    var controllerInstance = controllersInstances[e.key];
                    var controllerInfo;
                    if (!controllerInstance) {
                        controllerInfo = controllers[e.controller](app);
                        controllerInstance = controllerInfo.controller;
                        controllerInstance.controller = e.controller;
                        controllerInstance.app = app;
                        controllerInstance.placeholder = e.placeholder;
                        controllersInstances[e.key] = controllerInstance;

                        if (isFunc(controllerInfo.extend))
                            controllerInfo.extend(controllerInstance);

                        logf.call(this, function () { return "'" + e.controller + "': instance added to page:'" + page + "' for placeholder:'" + e.placeholder + "'" });
                    } else {
                        logf.call(this, function () { return "'" + e.controller + "': instance found for page:'" + page + "' for placeholder:'" + e.placeholder + "'" });
                    }
                    return controllerInstance;
                }

            };
        })();

        var templateEngine = (function () {
            var templates = {};
            var views = settings.shared.views;
            for (var i = 0; i < views.length; i++) {
                var view = views[i];
                var viewTemplates = view.templates;
                for (var j = 0; j < viewTemplates.length; j++) {
                    var viewTemplate = viewTemplates[j];
                    templates[viewTemplate] = {
                        id: viewTemplate,
                        view: view
                    };
                }
            }

            return {
                get: function (templateid) {
                    return templates[templateid];
                }
            };
        })();

        var viewEngine = (function () {
            var views = {};

            function createView(vData) {
                var templates = $('<div></div>').append(vData);
                var scriptBlocks = $(templates).find('script[type="text/javascript"]');
                var dustBlocks = $(templates).find('script[type="text/x-dust-template"]');
                scriptBlocks.appendTo('body');

                var s = {};
                scriptBlocks.each(function () {
                    s[$(this).attr('id')] = this;
                });
                var t = {};
                dustBlocks.each(function () {
                    var template = this;
                    var templateId = $(this).attr('id');
                    var html = $(template).html();
                    try {
                        var compiled = dust.compile(html ? html : "", templateId);
                        dust.loadSource(compiled);
                        t[templateId] = compiled;
                    } catch (err) {
                        logf.call(this, function () { return "ERROR COMPILING DUST TEMPLATE '" + templateId + "': " + err.message });
                        throw err.message;
                    }

                });

                return {
                    templates: t,
                    scripts: s
                };

            };

            return {
                viewCache: {
                    get: function (key) {
                        return views[key];
                    },
                    add: function (key, data) {
                        views[key] = createView(data);
                    }
                },
                loadView: function (viewPar, e, currentContext, callback) {
                    if (!isNull(viewPar)) {
                        var viewPath = "";
                        var dataType;
                        var view;
                        var viewId;

                        if (isFunc(viewPar)) {
                            view = viewPar.apply(this, [e, currentContext]);
                        } else {
                            view = viewPar;
                        }

                        if (isString(view)) {
                            view = {
                                id: view
                            };
                        }

                        if (isObj(view)) {
                            viewId = view.id;
                            var extension = (settings.endpoints.views.extension) ? settings.endpoints.views.extension : '';
                            viewPath = settings.endpoints.views.url + viewId + extension;
                            dataType = settings.endpoints.views.dataType;
                            if (isString(view.path)) {
                                viewPath = view.path;
                            }
                            if (isString(view.dataType)) {
                                dataType = view.dataType;
                            }
                        }

                        var separator = "?";
                        if (0 < viewPath.indexOf(separator))
                            separator = "&";
                        viewPath = viewPath + separator;

                        if ('jsonp' === dataType)
                            viewPath = viewPath + "callback=?&";

                        logf.call(this, function () { return "CACHE SEARCH: '" + viewPath + "'" });

                        var vw = viewEngine.viewCache.get(viewPath);
                        if (isUndDef(vw)) {
                            logf.call(this, function () { return "'" + e.controller + "': download view" });
                            var ajaxOptions = {
                                url: viewPath + (new Date).getTime(),
                                attach: function () { }
                            }
                            if ('jsonp' === dataType) {
                                ajaxOptions.jsonp = "callback";
                                ajaxOptions.dataType = "jsonp";
                                ajaxOptions.attach = function (html) {
                                    $(html).appendTo('body');
                                }
                            }
                            return $.ajax(ajaxOptions)
                            .done(function (data) {
                                ajaxOptions.attach(data);
                                logf.call(this, function () { return "'" + e.controller + "': download view succeeded" });
                                vw = viewEngine.viewCache.get(viewPath);
                                if (isUndDef(vw)) {
                                    logf.call(this, function () { return "CACHE ADD: '" + viewPath + "'" });
                                    viewEngine.viewCache.add(viewPath, data);

                                    //get view id from data..

                                    //load deps if not yet loaded
                                    var dep = $.fn.jsmvc.dependencies[viewId];
                                    var templates;
                                    if (isObj(dep)) {
                                        templates = dep.templates;
                                        if (isArray(templates)) {
                                            var i = 0;
                                            var len = templates.length;
                                            if (len > 0) {
                                                var calledCallbacks = 0;

                                                var depCallback = function () {
                                                    calledCallbacks++;
                                                    if (calledCallbacks == len)
                                                        callback();
                                                }

                                                for (i = 0; i < len; i++) {
                                                    var template = templateEngine.get(templates[i]);
                                                    if (isObj(template)) {
                                                        var view2 = template.view;
                                                        if (isObj(view2)) {
                                                            viewEngine.loadView(view2, e, currentContext, depCallback);
                                                        }
                                                    }
                                                }
                                            } else {
                                                callback();
                                            }
                                        } else {
                                            callback();
                                        }

                                    } else {
                                        callback();
                                    }
                                } else {
                                    callback();
                                }
                            }).fail(function (a, errorStatus, errorThrown) {
                                if ('abort' === errorStatus) {
                                    logf.call(this, function () { return "'" + e.controller + "': download view aborted" });
                                    callback({ aborted: true });
                                } else {
                                    logf.call(this, function () { return "'" + e.controller + "': download view failed" });
                                    callback({ error: true });
                                }
                            });
                        } else {
                            logf.call(this, function () { return "'" + e.controller + "': view from cache" });
                            callback();
                        }

                    } else {
                        callback();
                    }
                    return null;
                }
            };
        })();

        var modelEngine = (function () {
            return {
                loadModel: function (inputmodel, modelParams, e, currentContext, callback) {
                    if (!isNull(inputmodel)) {
                        var model;
                        var modelObject;

                        if (isFunc(inputmodel)) {
                            model = inputmodel.apply(this, [e, currentContext]);
                        } else {
                            model = inputmodel;
                        }

                        if (isString(model)) {
                            model = {
                                url: settings.paths.models + model + settings.defaultModelFileName
                            };
                        }

                        if (isObj(model)) {
                            if (model.object) {
                                modelObject = model.object;
                            } else {
                                if (model.path) {
                                    model.url = model.path;
                                }
                                if (model.url) {
                                    var separator = "?";
                                    if (0 < model.url.indexOf(separator))
                                        separator = "&";
                                    model.url = model.url + separator;

                                    if (!model.dataType)
                                        model.dataType = 'json'
                                }
                            }
                        }

                        if (modelObject) {
                            logf.call(this, function () { return "'" + e.controller + "': static model" });
                            callback({
                                data: modelObject
                            });
                        } else {
                            var modelUrl = model.url + getQueryString(modelParams) + "&_=" + (new Date).getTime();
                            logf.call(this, function () { return "'" + e.controller + "': download model from url '" + modelUrl + "'" });
                            return $.ajax({
                                dataType: model.dataType,
                                url: modelUrl
                            })
                            .done(function (data) {
                                logf.call(this, function () { return "'" + e.controller + "': download model succeeded" });
                                callback({
                                    data: data
                                });
                            })
                            .fail(function (jqXhr, errorStatus, errorThrown) {
                                var result = {};
                                if ('abort' == errorStatus) {
                                    logf.call(this, function () { return "'" + e.controller + "': download model aborted" });
                                    result = {
                                        aborted: true
                                    }
                                } else {
                                    logf.call(this, function () { return "'" + e.controller + "': download model failed" });
                                    result = {
                                        error: {
                                            status: errorStatus,
                                            object: jqXhr
                                        }
                                    }
                                }
                                if (jqXhr.status == 401) {
                                    $(app).trigger("unauthorized");
                                    return;
                                }
                                if (jqXhr.status == 404) {
                                    $(app).trigger("notfound");
                                    return;
                                }
                                callback(result);

                            });
                        }
                    } else {
                        logf.call(this, function () { return "'" + e.controller + "': inputmodel is NULL. " });
                        callback();
                    }

                    return null;
                }
            }
        })();

        var downloadControllerScript = function (e, app, callback, failedcallback) {
            //load controller js if not in cache yet
            if (!controllerScriptCache.inCache(e.controller)) {
                var extension = (settings.endpoints.controllers.extension) ? settings.endpoints.controllers.extension : '';
                var url = settings.endpoints.controllers.url + e.controller + extension;

                logf.call(this, function () { return "'" + e.controller + "': download: start: " + url });

                var ajaxOptions = {
                    url: url,
                    attach: function () { }
                }
                if ('jsonp' === settings.endpoints.controllers.dataType) {
                    ajaxOptions.jsonp = "callback";
                    ajaxOptions.dataType = "jsonp";
                    ajaxOptions.attach = function (script) {
                        $('<script type="text/javascript"></script>').html(script).appendTo('body');
                    }
                }

                $.ajax(ajaxOptions)
                .done(function (data, b, c) {
                    ajaxOptions.attach(data);
                    logf.call(this, function () { return "'" + e.controller + "': download: complete" });
                    controllerScriptCache.add(e.controller);
                    callback(e);
                }).fail(function () {
                    logf.call(this, function () { return "'" + e.controller + "': download: failed" });
                    if (isFunc(failedcallback))
                        failedcallback();
                });
            } else {
                callback(e);
            }
        };

        var loadControllerModelAndView = function (e, controller, modeloverride, currentContext, synccallback) {
            var d = {
                model: controller.model,
                view: controller.view,
                feature: e,
                controller: controller
            };
            if (undefined !== modeloverride && null !== modeloverride)
                d.model = modeloverride;
            var onReady = function (mData, modelparams, viewparams, feature, loadError) {
                var command = function (e) {
                    var template;
                    var view;
                    if (isFunc(d.view))
                        view = d.view(e, currentContext);
                    else
                        view = d.view;
                    if (!isNull(view)) {
                        if (isObj(view))
                            if (isString(view.template))
                                template = view.template;
                        controller.renderTemplateInternal(e, currentContext, template, mData, function (err) {
                            $(controller).trigger('viewrendered', { template: template, model: mData });
                        });
                    }
                };
                if (isFunc(synccallback))
                    synccallback(e, command, loadError);
            };
            app.loadModelAndView.apply(controller, [d, e, currentContext, onReady]);
        }

        var controllers;
        var viewBehaviours;
        var sharedBehaviours;
        var appstate = {};
        var context = function () {
            var activeRequests = [];
            return {
                route: {
                    previous: undefined,
                    controllers: [],
                    loadedControllers: {},
                    page: '',
                    action: '',
                    full: ''
                },
                expired: false,
                hasError: false,
                addRequest: function (request) {
                    if (null != request && "object" === typeof request)
                        if (this.expired)
                            request.abort();
                        else
                            activeRequests.push(request);
                },
                abortActiveRequests: function () {
                    var len = activeRequests.length;
                    var request;
                    for (var i = 0; i < len; i++) {
                        request = activeRequests[0];
                        request.abort();
                        activeRequests.splice(0, 1);
                    }
                }
            };
        }
        var app = {
            log: function (message) {
                logf.call(this, function () { return message });
            },
            logIndent: function () { logIndent(); },
            logUnindent: function () { logUnindent(); },
            settings: settings,
            endpoints: settings.endpoints,
            pages: settings.pages,
            registerEvent: function (eventName) {
                this[eventName] = function (func) {
                    $(this).bind(eventName, func);
                };
            },
            state: {
                store: function (key, value) {
                    //if (!isFunc($.cookie)) {
                    //    alert('jquery.cookie required');
                    //    return;
                    //}
                    appstate[key] = value;
                    //$.cookie(key, value);
                },
                retrieve: function (key) {
                    //if (!isFunc($.cookie)) {
                    //    alert('jquery.cookie required');
                    //    return null;
                    //}
                    var retval = appstate[key];
                    //if (isUndDef(retval)) {
                    //    retval = $.cookie(key);
                    //}
                    return retval;
                }
            },
            context: new context(),
            parseRoute: function () {
                logf.call(this, function () { return "app: route: parse" });
                var routeCandidate = settings.page;
                if (settings.action) {
                    routeCandidate = settings.page + '$' + settings.action;
                }
                if (document.location.hash) {
                    routeCandidate = document.location.hash.replace('#', '');
                }
                if (settings.routes) {
                    if (settings.routes.ignore) {
                        if (-1 !== settings.routes.ignore.indexOf(routeCandidate)) {
                            return;
                        }
                    }
                    if (settings.routes.include) {
                        if (-1 === settings.routes.include.indexOf(routeCandidate)) {
                            return;
                        }
                    }
                }
                var routeParts = routeCandidate.split("$");
                var lengthParts = routeParts.length;
                var prevRoute = app.context.route;
                app.context.expired = true;
                app.context.abortActiveRequests();
                app.context = new context();
                app.context.route = {
                    previous: prevRoute,
                    controllers: [],
                    loadedControllers: {},
                    page: routeParts[0],
                    action: (routeParts.length > 1) ? routeParts[1] : '',
                    params: (routeParts.length > 2) ? routeParts.splice(2, lengthParts - 2) : [],
                    full: routeCandidate,
                    getUrlVar: function (name) {
                        var hash;
                        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                        for (var i = 0; i < hashes.length; i++) {
                            hash = hashes[i].split('=');
                            if (hash[0] == name)
                                if (hash.length > 1)
                                    return hash[1] ? hash[1] : "";
                        }
                        return "";
                    }
                };
            },
            start: function (runconfig) {
                var ctxStart = this;

                $.extend(settings, runconfig);

                if (!settings.logenabled)
                    logf = nullLogger;
                else
                    logf = consoleLogger;

                logf.call(this, function () { return 'app: start' });

                settings.start(app);
                $(ctxStart).trigger('init', [settings]);
                controllers = $.fn.jsmvc.controllers;
                viewBehaviours = $.fn.jsmvc.viewBehaviours;
                sharedBehaviours = $.fn.jsmvc.sharedBehaviours;
                $(ctxStart).trigger('ready');
                $(ctxStart).trigger('appnavigate');
            },
            loadModelAndView: function (d, e, currentContext, c) {
                var mLoaded,
                    vLoaded,
                    loadError,
                    mData;

                loadError = false;
                var tryCallback = function () {
                    if (mLoaded && vLoaded && isFunc(c)) {
                        c(mData, d.modelParams, d.viewParams, d.feature, loadError);
                    }
                };

                var modelRequest = modelEngine.loadModel.apply(this, [d.model, d.modelParams, e, currentContext, function (result) {
                    mLoaded = true;
                    mData = {};

                    if (result) {
                        if ("undefined" !== typeof result.data) {
                            mData = result.data;
                        }
                        if (result.error) {
                            loadError = true;
                            if (d.controller.handleModelLoadException({ input: d, response: result.error.object })) {
                                app.context.hasError = true;
                            }
                        }

                    }
                    $(d.controller).trigger('modelloadcompleted', { modelinfo: d.model, result: result });
                    tryCallback();

                }]);
                currentContext.addRequest(modelRequest);

                var viewRequest = viewEngine.loadView.apply(this, [d.view, e, currentContext, function (result) {
                    vLoaded = true;
                    if (result)
                        if (result.error)
                            loadError = true;
                    tryCallback();
                }]);
                currentContext.addRequest(viewRequest);
            },
            navigate: function (route) {
                var location = document.location.href.replace(document.location.hash, '');
                if (route) {
                    location = location + '#' + route;
                }
                document.location = location;
            },
            render: function (template, model, callback) {
                dust.render(template, model, callback);
            },
            renderTemplate: function (controller, templateId, templateBehaviourId, model, callback) {
                // Bind model to form
                controller.modelData = model;
                dust.render(templateId, model, function (err, out) {
                    //De modules voor huidige pagina
                    //TEST
                    if (err)
                        alert('Dust error: ' + err);

                    var placeholder = controller.placeholder;

                    if (!isUndDef(placeholder)) {
                        //Place rendered HTML in placeholder DOM
                        $(placeholder).html(out).map(function () {



                            // Zorg dat behaviours van shared templates geladen zijn
                            var executeSharedBehaviours = function (templateBehaviourId) {
                                var dep = $.fn.jsmvc.dependencies[templateBehaviourId];
                                var templates;
                                if (isObj(dep)) {
                                    templates = dep.templates;
                                    if (isArray(templates)) {
                                        var i = 0;
                                        var len = templates.length;
                                        if (len > 0) {
                                            for (i = 0; i < len; i++) {
                                                var template = templateEngine.get(templates[i]);
                                                if (isObj(template)) {
                                                    var view = template.view;
                                                    if (isObj(view)) {
                                                        logf.call(this, function () { return "'" + templates[i] + "': requires shared behaviours from view:'" + view.id + "'" });
                                                        executeSharedBehaviours(view.id);
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }

                                var sharedBehaviour = sharedBehaviours[templateBehaviourId];
                                if (isFunc(sharedBehaviour)) {
                                    logf.call(this, function () { return "'" + templateBehaviourId + "': execute shared behaviours" });
                                    sharedBehaviour(app);
                                    sharedBehaviours[templateBehaviourId] = function () { };
                                };
                            }
                            executeSharedBehaviours(templateBehaviourId);

                            var behaviours = viewBehaviours[templateBehaviourId];
                            if (isObj(behaviours)) {
                                behaviours.app = app;
                                behaviours.placeholder = placeholder;
                                behaviours.model = model;
                                var handler = controller.viewhandlers[behaviours.id];
                                if (isFunc(handler)) {
                                    handler(behaviours);
                                    controller.viewhandlers[behaviours.id] = null;
                                }
                                if (isFunc(behaviours.afterfirstrender)) {
                                    behaviours.afterfirstrender();
                                    behaviours.afterfirstrender = function () { };
                                };
                                if (isFunc(behaviours.afterrender)) {
                                    behaviours.afterrender();
                                };
                            }

                            if (isFunc(callback))
                                callback(err);
                        });
                    }
                });
            },
            addControllerToRoute: function (e) {
                var ctx = this;
                e.key = "ctrl=" + e.controller + ";ph=" + e.placeholder;
                app.context.route.controllers.push(e);
                if (!isUndDef(e.controllers)) {
                    $(e.controllers).each(function (i, ne) {
                        ctx.addControllerToRoute(ne);
                    });
                }
            },
            getPageconfiguration: function (page) {
                return settings.pages[page];
            },
            initPagecontrollers: function (pageConfiguration, currentContext) {
                var ctx = this;

                $(pageConfiguration).each(function (i, e) {
                    ctx.addControllerToRoute(e);
                });

                return currentContext.route.controllers;


            },
            loadControllers: function (controllers, currentContext) {
                logf.call(this, function () { return "app: controllers: load" });
                app.logIndent();
                var $routeControllers = $(controllers);

                var callbackSync = {
                    controllercount: 0,
                    queue: [],
                    callbacks: {},
                    execute: function () {
                        logf.call(this, function () { return "callbackSync:execute" });
                        var len = this.queue.length;
                        var i = 0;
                        var e = {};
                        var callback;

                        for (i = len; i--;) {
                            e = this.queue[0];
                            callback = this.callbacks[e.key];
                            if (isFunc(callback)) {
                                logf.call(this, function () { return "'" + e.controller + "': queue: pop" });
                                this.queue.splice(0, 1);
                                delete this.callbacks[e.key];
                                logf.call(this, function () { return "'" + e.controller + "': execute callback" });
                                callback(e);
                            }
                        }
                        if (0 !== this.controllercount)
                            this.controllercount--;
                        logf.call(this, function () { return "callbackSync: controllers left on queue:'" + this.controllercount + "'" });
                        if (0 === this.controllercount) {
                            $(app).trigger('renderComplete', { context: currentContext });
                            $.event.trigger('renderComplete', { context: currentContext });
                            if (currentContext.hasError) {
                                currentContext.hasError = false;
                                logf.call(this, function () { return "app: controllers: load: modelLoadException" });
                                $(app).trigger("modelLoadException");
                            }
                        }
                    }
                };

                var mustLoad = function (e, controller) {
                    if (!controller.reloadAfterHashChange) {
                        var prevRoute = currentContext.route.previous;
                        if (isObj(prevRoute)) {
                            if (prevRoute.loadedControllers[e.key]) {
                                return false;
                            }
                        }
                    }
                    return true;
                }

                var refreshController = function (e, controller) {
                    controller.update(app);
                    callbackSync.callbacks[e.key] = function () {
                    };
                    callbackSync.execute();
                }

                var processModelAndView = function (e) {
                    currentContext.route.loadedControllers[e.key] = true;

                    var currentController = controllerInstanceCache.get(e, currentContext.route.page);

                    if (mustLoad(e, currentController)) {
                        logf.call(this, function () { return "'" + e.controller + "': load model and view" });
                        loadControllerModelAndView(e, currentController, null, currentContext, function (e, command, loadError) {

                            if (loadError || currentContext.expired)
                                command = function () { }
                            callbackSync.callbacks[e.key] = command;
                            callbackSync.execute();
                        });
                    } else {
                        logf.call(this, function () { return "'" + e.controller + "': refresh" });
                        refreshController(e, currentController);
                    }
                };

                callbackSync.controllercount = $routeControllers.length;
                $routeControllers.each(function (i, e) {
                    logf.call(this, function () { return "'" + e.controller + "': queue: push" });
                    callbackSync.queue.push(e);
                    downloadControllerScript(e, app, processModelAndView, function () {
                        callbackSync.callbacks[e.key] = function () { };
                        callbackSync.execute();
                    });

                });

            },
            loadController: function (controllerid, placeholder, model, callback) {
                var context = app.context;
                downloadControllerScript({
                    controller: controllerid,
                    placeholder: placeholder
                }, app, function (e) {
                    logf.call(this, function () { return "'" + e.controller + "': load model and view" });
                    var instance = createControllerInstance(e);
                    instance.callback = callback ? callback : function () { };
                    var modeloverride = null;
                    if (undefined !== model && null !== model)
                        modeloverride = { object: model };
                    loadControllerModelAndView(e, instance, modeloverride, app.context, function (e, command, loadError) {

                        if (loadError || context.expired)
                            command = function () { }
                        command(e);
                    });
                }, function () { });
            }
        };

        function getQueryString(data) {
            if (isUndDef(data) || data == null) {
                return "";
            }
            var s = [];
            for (var e in data) {
                s.push(e + "=" + escape(data[e]));
            }
            return s.join("&");
        }

        app.registerEvent('init');
        app.registerEvent('load');
        app.registerEvent('ready');
        app.registerEvent('appnavigate');
        app.registerEvent('unauthorized');
        app.registerEvent('notfound');
        app.registerEvent('renderComplete');
        app.registerEvent('modelLoadException');

        app.appnavigate(function () {

            logf.call(this, function () { return "app: navigate" });
            app.logIndent();
            settings.appnavigate(app);
            $.event.trigger('startNavigate', [app]); //global event for custom behaviours
            app.parseRoute();
            var pageConfiguration = app.getPageconfiguration(app.context.route.page);
            if ("undefined" == typeof pageConfiguration) {
                pageConfiguration = app.getPageconfiguration("404");
            }
            if ("undefined" != typeof pageConfiguration) {
                var routeControllers = app.initPagecontrollers(pageConfiguration, app.context);
                app.loadControllers(routeControllers, app.context);
            } else {
                return;
            }
        });

        app.renderComplete(function (e, obj) {
            settings.renderComplete(app, obj.context);
            app.logUnindent();
            app.logUnindent();
            logf.call(this, function () { return "app: render: complete" });
        });

        app.modelLoadException(function () {
            settings.modelLoadException(app);
        });

        app.unauthorized(function () {
            settings.unauthorized(app);
        });

        app.notfound(function () {
            settings.notfound(app);
        });

        //$(window).on('load', function () {
        //    $(app).trigger('appnavigate');
        //});

        var confirmNavigate = {
            navigationCancelled: false,
            confirm: function () {
                if (!settings.confirmNavigation()) {
                    this.navigationCancelled = true;
                    return false;
                } else {
                    return true;
                }
            }
        }

        $(window).on('hashchange', function () {
            if (app.navigationBlocked) {
                if (!confirmNavigate.navigationCancelled) {
                    if (!confirmNavigate.confirm()) {
                        app.navigate(app.context.route.full);
                        return false;
                    }
                } else {
                    confirmNavigate.navigationCancelled = false;
                    return false;
                }
            }
            app.navigationBlocked = false;

            logf.call(this, function () { return "app: hash: change" });
            $(app).trigger('appnavigate');
        });

        $(document).ajaxError(function (event, jqXhr, ajaxSettings, thrownError) {

            if (!settings.logAjaxErrors) {
                return;
            }

            if (jqXhr) {
                if (jqXhr.status === 200 || jqXhr.status === '200') {
                    return;
                }
            } if (ajaxSettings) {
                if (ajaxSettings.url) {
                    if (ajaxSettings.url.indexOf('ErrorLogging') > -1) {
                        return;
                    }
                }
            }
            var ajaxInfo =
                {
                    responseInfo: {
                        errorThrown: thrownError,
                        xhr: jqXhr
                    },
                    source: 'jsmvc.app.ajaxError',
                    jsmvcApp: app,
                    requestInfo: ajaxSettings
                }
            var errorData = {
                message: "",
                details: JSON.stringify(ajaxInfo) + ", useragent: " + navigator.userAgent
            };
            $.ajax({
                url: '/ErrorLogging',
                data: errorData,
                type: 'POST',
                dataType: 'json',
                success: function (data, b, c, d) {
                }
            });
        });

        $.fn.jsmvc.controller = function (id, object, extend) {
            var settings = $.extend({
                controller: id
            }, object);
            $.fn.jsmvc.controllers[id] = function (app) {
                var controller = $.fn.jsmvc.createController(settings);
                //if (isFunc(extend)) {
                //    extend(controller);
                //}
                return { controller: controller, extend: extend };
            };
        }
        return app;
    };

    $.fn.jsmvc.view = function (id, object) {
        var events = object.events;

        var view = $.extend({
            id: id,
            afterfirstrender: function () { },
            afterrender: function () { },
            events: [],
            model: {}
        }, object, {
            events: {
                registerEvent: function (eventName) {
                    this[eventName] = function (func) {
                        $(this).bind(eventName, func);
                    };
                }
            }
        });

        if (isArray(events)) {
            for (var i = 0; i < events.length; i++) {
                view.events.registerEvent(events[i]);
            }
        }
        $.fn.jsmvc.viewBehaviours[id] = view;
    }
    $.fn.jsmvc.viewBehaviours = {};
    $.fn.jsmvc.sharedBehaviours = {};
    $.fn.jsmvc.controllers = {};
    $.fn.jsmvc.createController = function (settings) {
        settings = $.extend({
            reloadAfterHashChange: true,
            handleModelLoadException: function (data) {
                return true;
            }
        }, settings);
        var controller = {
            app: settings.app,
            id: settings.controller,
            view: settings.view,
            model: settings.model,
            viewhandlers: {},
            viewhandler: function (id, handler) {
                this.viewhandlers[id] = handler;
            },
            registerEvent: function (eventName) {
                this[eventName] = function (func) {
                    $(this).bind(eventName, func);
                };
            },
            update: function (updatedapp) {
                this.app = updatedapp;
                $(this).trigger('appupdate');
            },
            renderTemplateInternal: function (e, currentContext, template, model, callback) {
                var templateId = '';
                var templateBehaviourId = null;

                var view;
                if (isFunc(this.view))
                    view = this.view(e, currentContext);
                else {
                    view = this.view;
                }

                var viewId = isString(view) ? view : (isObj(view) ? view.id : null);

                if (isString(view)) {
                    templateId = (undefined !== template) ? template : view;
                } else if (isObj(view)) {
                    if (isString(view.template))
                        templateId = view.template;
                }

                templateBehaviourId = viewId;

                logf.call(this, function () { return "'" + this.id + "':controller render template internal:'" + templateId + "' in placeholder:'" + this.placeholder + "'" });
                this.app.renderTemplate(this, templateId, templateBehaviourId, model, callback);
            },
            renderTemplate: function (templateId, model, callback) {

                logf.call(this, function () { return "'" + this.id + "':render template type " + (this.isType2 ? "2" : "1") + ":'" + templateId + "' in placeholder:'" + this.placeholder + "'" });
                //controllers have behaviours linked to the templateId
                this.app.renderTemplate(this, templateId, templateId, model, callback);

            },
            reloadAfterHashChange: settings.reloadAfterHashChange,
            placeholder: null,
            handleModelLoadException: settings.handleModelLoadException,
            GetNestedControllerInfo: function (name) {
                return $.grep(this.app.context.route.controllers, function (e) {
                    return e.controller == name;
                });
            }

        };
        controller.registerEvent('appupdate');
        controller.registerEvent('ready');
        controller.registerEvent('viewrendered');
        controller.registerEvent('modelloadcompleted');

        return controller;
    };
    $.fn.jsmvc.dependencies = {};
    $.fn.jsmvc.helpers = {};
})();



