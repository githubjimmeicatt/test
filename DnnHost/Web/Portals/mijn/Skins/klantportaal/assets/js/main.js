document.addEventListener('DOMContentLoaded', function () {

    // check for classList support

    if (!!document.createElement('p').classList) {

        var html = document.getElementsByTagName('html')[0];

        // add android class

        if (is.android()) {

            html.classList.add('on-android');

        // add ios class

        } else if (is.ios()) {

            html.classList.add('on-ios');

        }

    };

});