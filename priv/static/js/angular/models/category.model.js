(function() {
  'use strict';

  angular.module('themelook').factory('Category', [
    '$http', '$log',

    function($http, $log) {
      $log.info('{Model} Defining the Category model.');

      return {
        getAll:  getAll,
        loadMore: loadMore,
        sort: sort,
        indexPageSort
      };

      /*----------------------------------------------------------------------------------------------
       * MANAGEMENT METHODS
       *--------------------------------------------------------------------------------------------*/
      function  getAll() {
        return $http({
          method: 'GET',
          url: _url()
        }).then(_success);
      }

      function loadMore(sortBy, category, offset) {
        return $http({
          method: 'GET',
          url: _url(category) + `?sort=${sortBy}&offset=${offset}&count=16`
        }).then(_success);
      }

      function sort(sortBy, category, limit) {
        return $http({
          method: 'GET',
          url: _url(category) + `?sort=${sortBy}&count=${limit}`
        }).then(_success);
      }

      function indexPageSort(sortBy, limit) {
        return $http({
          method: 'GET',
          url: `/api/v1/themes?sort=${sortBy}&count=${limit}`
        }).then(_success);
      }
      /*----------------------------------------------------------------------------------------------
      /*----------------------------------------------------------------------------------------------
       * HELPER METHODS
       *--------------------------------------------------------------------------------------------*/

      // This is a general success that strips response data off of the promise.
      function _success(response) {
        return response.data;
      }

      function _url(category) {
        var baseUrl = '/api/v1/categories';

        if(_.isEmpty(category)) {
          return baseUrl;
        } else {
          return baseUrl + '/' + category.id;
        }
      }

  }]);
})();
