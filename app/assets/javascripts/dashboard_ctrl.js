/* global angular */


(function() {
  "use strict";

  angular.module("app").controller("dashboardController", function($scope) {

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

    $scope.models = {
      selected: null,
      lists: {"Visible": [], "Hidden": []}
    };
    // Generate initial model
    for (var i = 1; i <= 3; ++i) {
      
      $scope.models.lists.Hidden.push({label: "Item B" + i});
    }

    $scope.models.lists.Hidden = [{
      label: "Transit Score"
    },{label: "Bedrooms"
    },{label: "Bathrooms"
    },{label: "HOA Assessment"
    },{label: "Property Tax"
    },{label: "Neighborhood Score"
    }];

    $scope.models.lists.Visible = [{
      label: "Price"
    },{label: "Cost"
    },{label: "Sq Ft"
    },{label: "Address"
    },{label: "Price"
    },{label: "Sq Ft"
    },{label: "Cost / SqFt"
    },{label: "Monthly Debt Service"
    },{label: "Walk Score"
    },{label: "Amenities Score"
    },{label: "Building Score"
    }];

    // Model to JSON for demo purpose
    $scope.$watch('models', function(model) {
      $scope.modelAsJson = angular.toJson(model, true);
    }, true);

    window.$scope = $scope;
  });
})();