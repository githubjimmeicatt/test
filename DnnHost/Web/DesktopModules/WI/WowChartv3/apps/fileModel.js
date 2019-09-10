WowChartv3_fileModel.$inject = [];
function WowChartv3_fileModel() {
    return {
        restrict: "A",
        transclude: true,
        scope: {
            ngModel: '='
        },
        link: function (scope, element, attrs) {
            var $element = $(element);
            $element.change(function () {
                for (var i = 0; i < this.files.length; i++) {
                    if (scope.ngModel.constructor === Array) {
                        scope.ngModel.push({
                            Title: this.files[i].name,
                            File: this.files[i]
                        });
                    } else {
                        scope.ngModel.Title = this.files[i].name;
                        scope.ngModel.File = this.files[i];
                    }
                }
                scope.$apply();
            });
        }
    };
}

WowGallery_ngfSrc.$inject = ['$parse', '$timeout'];
function WowGallery_ngfSrc($parse, $timeout) {
    return {
        restrict: 'A',
        scope: {
            ngfSrc: '='
        },
        link: function (scope, elem, attr) {
            if (window.FormData == undefined) {
                alert("This browser doesn't support HTML5 multiple file uploads!");
                return;
            }

            if (scope.ngfSrc &&
                (!window.FileAPI || navigator.userAgent.indexOf('MSIE 8') === -1 || scope.ngfSrc.size < 20000) &&
                (!window.FileAPI || navigator.userAgent.indexOf('MSIE 9') === -1 || scope.ngfSrc.size < 4000000)) {

                $timeout(function () {
                    var fileReader = new FileReader();
                    fileReader.readAsDataURL(scope.ngfSrc);
                    fileReader.onload = function (e) {
                        $timeout(function () {
                            elem.attr('src', e.target.result);
                        });
                    }
                });
            }
        }
    }
};