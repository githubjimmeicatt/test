if (SVGElement.prototype.getElementsByClassName === undefined) {
    SVGElement.prototype.getElementsByClassName = function (className) {
        return this.querySelectorAll('.' + className);
    };
}

function verifyAngularLibVersion() {
    try {
        if (angular.version.major != 1 ||
            angular.version.minor < 6) {
            alert("Another angular library ver. " + angular.version.full + " is loaded and module might not working propertly. Go to the module settings, under 'WI Wow Chart - V3 Settings' tab, select the 'Dont Load Angular Lib' & 'Dont Load Angular Route Lib' options then Save the settings. Please contact support@wow-extensions.com if does not help.");
        }
    } catch (err) { 
    }
}
function verifyAngularLibExists() {
    try {
        var v = angular.version;
    } catch (err) {
        alert("Angular library is not loaded and module might not working propertly. Go to the module settings, under 'WI Wow Chart - V3 Settings' tab, unselect the 'Dont Load Angular Lib' & 'Dont Load Angular Route Lib' options then Save the settings. Please contact support@wow-extensions.com if does not help.");
    }
}

if (window["angular"]) {
    angular.isUndefinedOrNull = function (val) {
        return angular.isUndefined(val) || val === null
    }
    angular.deepExtend = function (initial, data) {
        var result;

        if (angular.isUndefinedOrNull(data)) {
            data = {};
            result = {};
        } else {
            result = angular.copy(data);
        }

        try {
            angular.forEach(initial, function (value, key) {
                if (initial[key] && initial[key].constructor && initial[key].constructor === Object)
                    result[key] = angular.deepExtend(initial[key], data[key]);
                else
                    result[key] = data[key] == undefined ? initial[key] : data[key];
            });
        } catch (er) {
            alert(er);
        }

        return result;
    };
    if (!String.prototype.format) {
        String.prototype.format = function () {
            var args = arguments;
            return this.replace(/{(\d+)}/g, function (match, number) {
                return typeof args[number] != 'undefined'
                    ? args[number]
                    : match
                    ;
            });
        };
    }
}

CanvasRenderingContext2D.prototype.roundRect = function (x, y, width, height, radius, fill) {
    if (typeof radius === "undefined") {
        radius = 5;
    }

    this.beginPath();
    this.moveTo(x + radius, y);
    this.lineTo(x + width - radius, y);
    this.quadraticCurveTo(x + width, y, x + width, y + radius);
    this.lineTo(x + width, y + height - radius);
    this.quadraticCurveTo(x + width, y + height, x + width - radius, y + height);
    this.lineTo(x + radius, y + height);
    this.quadraticCurveTo(x, y + height, x, y + height - radius);
    this.lineTo(x, y + radius);
    this.quadraticCurveTo(x, y, x + radius, y);
    this.closePath();

    if (fill) {
        this.fillStyle = fill;
        this.fill();

        this.strokeStyle = fill;
        this.stroke();
    }
}

commonAppConfig.$inject = ['$httpProvider', 'toastrConfig'];
function commonAppConfig($httpProvider, toastrConfig) {
    $httpProvider.interceptors.push('authHttpResponseInterceptor');
    $httpProvider.interceptors.push('httpRequestInterceptorCacheBuster');

    angular.extend(toastrConfig, {
        allowHtml: true,
        closeButton: true,
        autoDismiss: true,
        containerId: 'toast-container',
        maxOpened: 0,
        newestOnTop: true,
        positionClass: 'toast-top-center',
        preventDuplicates: false,
        preventOpenDuplicates: true,
        target: 'body',
        timeOut: 2500,
    });
}
function fetchPermissions(ngAppName, initAppFunc, args) {
    var obj = {};
    obj.headers = {
        "PortalAliasId": args.PortalAliasId,
        "ModuleId": args.ModuleId,
        "TabId": args.TabId,
        "Content-Type": "application/json; charset=utf-8"
    };

    var initInjector = angular.injector(["ng"]);
    var $http = initInjector.get("$http");

    var callBack = function (result) {
        if (result.data) result = result.data;

        if (result.d == null) {
            return {
                initAppFunc: initAppFunc,
                ngAppName: ngAppName,
                permissions: [],
                currentUser: {},
                args: args
            };
        } else {
            return {
                initAppFunc: initAppFunc,
                ngAppName: ngAppName,
                permissions: result.d.permissions,
                currentUser: result.d.currentUser,
                args: args
            };
        }
    };

    var promise = $http({
        method: 'POST',
        url: args.ServiceUrl + "/UserPermissions",
        headers: obj.headers,
        data: ''
    });

    if (promise.then) return promise.then(callBack);
    else if (promise.success) return promise.success(callBack);
    else return null;
};
function bootstrapApplication(result) {
    result.initAppFunc(result.ngAppName);

    var ngApp = angular.module(result.ngAppName);
    ngApp.constant('permissions', result.permissions);
    ngApp.constant('currentUser', result.currentUser);
    ngApp.constant('ModuleInfo', result.args);

    angular.bootstrap(document.getElementById('module-' + result.args.ModuleId), [result.ngAppName]);
}