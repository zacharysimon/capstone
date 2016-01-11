/* global angular */


(function() {
  "use strict";

  angular.module("app").controller("listingCtrl", function($scope, $http) {

    $http.get("/api/v1/listings.json").then(function(response) {
      $scope.listings = response.data.listings;
      $scope.headings = response.data.dashboard;
    });

    $scope.models = {
      selected: null,
      lists: {"Visible": [], "Hidden": []}
    };

    $http.get("/api/v1/dashboard.json").then(function(response) {
      $scope.allHeadings = response.data.dashboard;

      for (var i = 0; i < $scope.allHeadings.length; i++) {
        if ($scope.allHeadings[i].visible === true ) {
          $scope.models.lists.Visible.push({label: $scope.allHeadings[i].header_title});
        } else {
          $scope.models.lists.Hidden.push({label: $scope.allHeadings[i].header_title});
        }
      }
    });
      
     // Model to JSON for demo purpose
    $scope.$watch('models', function(model) {
      $scope.modelAsJson = angular.toJson(model, true);
    }, true);

    $scope.updateDashboard = function() {
      for (var i = 0; i < $scope.models.lists.Visible.length; i++) {
        
      }

      console.log($scope.models.lists.Visible);
    };

    window.$scope = $scope;
    
  });
})();