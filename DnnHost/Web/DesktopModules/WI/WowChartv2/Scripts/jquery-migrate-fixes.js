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