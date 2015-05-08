angular.module('biomodelos').controller('group_users_ctrl', ['$scope', '$http', function($scope, $http ){
    $scope.my_var= "texto";

    $scope.msg_is_member = '';

    $scope.text_is_member = function(){
        if ($scope.is_member == true){
            $scope.msg_is_member= "Abandonar Grupo";
        }
        else{
            $scope.msg_is_member= "Unirse al Grupo";
        }
    }

    $scope.unirse=function(group_id){
        if( $scope.button_member) {
            $scope.button_member = true
            $html.post('/group_users', {group_id: group_id}).success(function (data) {
                $scope.is_member = data
                text_is_member();
                $scope.button_member = false
            }).error(function () {

            });
        }
    }
}
]);