var app = angular.module('Biomodelos', []);
app.controller('groupCtrl', function($scope) {
    $scope.group_form = false;
    $scope.toggle = function() {
        $scope.group_form = !$scope.group_form;
    }
});