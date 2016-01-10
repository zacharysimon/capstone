/* global angular */


(function() {
  "use strict";

  angular.module("app").controller("listingCtrl", function($scope, $http) {

    $http.get("/api/v1/listings.json").then(function(response) {
      $scope.listings = response.data;
    });

    $http.get("/api/v1/dashboard.json").then(function(response) {
      $scope.headings = response.data;
    });

    window.$scope = $scope;
  });
})();