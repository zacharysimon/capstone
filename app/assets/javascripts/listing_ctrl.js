/* global angular */


(function() {
  "use strict";

  angular.module("app").controller("listingCtrl", function($scope, $http) {

    $http.get("/api/v1/listings.json").then(function(response) {
      $scope.listings = response.data;
    });

    $scope.tableHeadings = [
      "address",
      "price",
      "sqft",
      "cost_per_sqft",
      "monthly_pmt",
      "walk_score",
      "amenities_score",
      "building_score"
    ];


    window.$scope = $scope;
  });
})();