/* global angular */


(function() {
  "use strict";

  angular.module("app").controller("listingCtrl", function($scope, $http) {
    
    $scope.setUser = function(id) {
      $scope.currentUserId = id;
    };

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
          $scope.models.lists.Visible.push({label: $scope.allHeadings[i].header_title, id: $scope.allHeadings[i].characteristic_id, visible: ""});
        } else {
          $scope.models.lists.Hidden.push({label: $scope.allHeadings[i].header_title, id: $scope.allHeadings[i].characteristic_id, visible: ""});
        }
      }
    });

    $scope.updateDashboard = function(inputs, user) {
      var lists = [];
      var data = {"data": {"lists": lists, "user": user}};

      for (var i = 0; i < inputs.models.lists.Visible.length; i++) {
        inputs.models.lists.Visible[i]["visible"] = "true";
        lists.push(inputs.models.lists.Visible[i]);
      }

      for (var i = 0; i < inputs.models.lists.Hidden.length; i++) {
        inputs.models.lists.Hidden[i]["visible"] = "false";
        lists.push(inputs.models.lists.Hidden[i]);
      }

      $http.patch("/api/v1/dashboard.json", data).then(function(response) {
        console.log(response);
      }, function(error) {
        console.log(error);
        $scope.errors = error.data.errors;
      });
    };
      
    $scope.checkZillow = function(address, city, state) {
      $scope.results = [];
      $scope.showZillow = true;

      $http.get('/api/v1/listings/zillow_search?address=' + address + '&city=' + city + '&state=' + state).then(function(response) {
        $scope.initialResults = response.data["results"][0];

        
        if ($scope.initialResults.length === undefined) {
          $scope.results = [$scope.initialResults];
        } else {
          $scope.results = $scope.initialResults;
        }
      });
    };


    $scope.selectListing = function(listing) {
      $scope.showProperties = true;
      $scope.createListingButton = true;

      $scope.selectedListing = {
        "price": listing.result.zestimate.amount.__content__,
        "bedrooms": listing.result.bedrooms,
        "bathrooms": listing.result.bathrooms,
        "sqft": listing.result.finishedSqFt,
        "hoa_assessment": (listing.result.taxAssessment * 0.02).toFixed(2),
        "tax_assessment": (listing.result.taxAssessment * 0.18).toFixed(2),
        "longitude": listing.result.address.longitude,
        "latitude": listing.result.address.latitude,
        "zip_code": listing.result.address.zipcode,
        "zpid": listing.result.zpid,
        "user_id": $scope.currentUserId,
        "address": listing.result.address.street,
        "city": listing.result.address.city,
        "state": listing.result.address.state,
        "url": listing.result.links.homedetails
      };
    
      $scope.selectedPrice = $scope.selectedListing.price;
      $scope.selectedBathrooms = $scope.selectedListing.bathrooms;
      $scope.selectedBedrooms = $scope.selectedListing.bedrooms;
      $scope.selectedSqft = $scope.selectedListing.Sqft;
      $scope.selectedHoa = $scope.selectedListing.hoa_assessment;
      $scope.selectedTax = $scope.selectedListing.tax_assessment;
      $scope.selectedLongitude = $scope.selectedListing.longitude;
      $scope.selectedLatitude = $scope.selectedListing.latitude;
      $scope.selectedZpid = $scope.selectedListing.zpid;
      $scope.selectedZipCode = $scope.selectedListing.zip_code;
      $scope.selectedUrl = $scope.selectedListing.url;

      if (listing.result.address.street !== "No Zillow listings found. Click here to manually enter data.") {
        $scope.address = listing.result.address.street;
        $scope.city = listing.result.address.city;
        $scope.state = listing.result.address.state;
      }
    };

    $scope.createListing = function() {
      $http.post('/listings', {
        "price": $scope.selectedPrice,
        "bedrooms": $scope.selectedBedrooms,
        "bathrooms": $scope.selectedBathrooms,
        "sqft": $scope.selectedSqft,
        "hoa_assessment": $scope.selectedHoa,
        "tax_assessment": $scope.selectedTax,
        "longitude": $scope.selectedListing.longitude,
        "latitude": $scope.selectedLatitude,
        "zip_code": $scope.selectedZipCode,
        "zpid": $scope.selectedZpid,
        "user_id": $scope.currentUserId,
        "address": $scope.address,
        "city": $scope.city,
        "state": $scope.state,
        "url": $scope.selectedUrl
      }).then(function() {
        window.location.href = '/listings';
      });
    };


    $scope.sortListings = function(input) {
      var column_name = input.column_name;

      function compare(a,b) {
        if (a[column_name] < b[column_name]) {
          return -1;
        } else if (a[column_name] > b[column_name]) {
          return 1;
        } else {
          return 0;
        }
      }

      if (input.isSorted) {
        input.isSorted = false;
        $scope.listings.reverse();
      }else {
        input.isSorted = true;
        $scope.listings.sort(compare);
      }
    };


    $scope.search = function(listing) {
      if (!$scope.listingFilter ||
        listing.address.toLowerCase().indexOf($scope.listingFilter) !== -1 ||
        listing.address.toLowerCase().indexOf($scope.listingFilter) !== -1 ||
        listing.zip_code.toLowerCase().indexOf($scope.listingFilter) !== -1
        ) {
        return true;
      }
      return false;
    };


    $scope.goToShow = function(inputs) {
      window.location.href = '/listings/' + inputs;
    };

    window.$scope = $scope;
  });
})();