// Matches dashed string for camelizing
var rmsPrefix = /^-ms-/, rdashAlpha = /-([a-z])/g;

// Used by jQuery.camelCase as callback to replace()
var fcamelCase = function (all, letter) {
    return letter.toUpperCase();
};

jQuery.camelCase = function (string) {
    try {
        return string.replace(rmsPrefix, "ms-").replace(rdashAlpha, fcamelCase);
    } catch (e) {
        if (jQuery._data)
            jQuery._data.apply(this, arguments);
    }
};

try {
    if (angular.version.major != 1 ||
        angular.version.minor < 6) {
        alert('Another angular library ver. ' + angular.version.full + ' is loaded and module might not working propertly. Please contact support.');
    }
} catch{ }