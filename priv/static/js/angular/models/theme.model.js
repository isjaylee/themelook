(function() {
  'use strict';

  angular.module('themelook').factory('Theme', [
    '$http', '$log',

    function($http, $log) {
      $log.info('{Model} Defining the Theme model.');

      return {
        getAll: getAll,
        loadMore: loadMore,
        sort: sort,
        searchLoadMore: searchLoadMore
      };

      /*----------------------------------------------------------------------------------------------
       * MANAGEMENT METHODS
       *--------------------------------------------------------------------------------------------*/
      function getAll() {
        return $http({
          method: 'GET',
          url: _url()
        }).then(_success);
      }

      function loadMore(offset) {
        return $http({
          method: 'GET',
          url: _url() + `?offset=${offset}`
        }).then(_success);
      }

      function sort(sortBy, params, limit) {
        return $http({
          method: 'GET',
          url: `api/v1/search_themes?${params}&sort=${sortBy}&count=${limit}`
        }).then(_success);
      }

      function searchLoadMore(offset, searchParams, limit) {
        return $http({
          method: 'GET',
          url: `/api/v1/search_themes?${searchParams}&offset=${offset}&count=${limit}`
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

      function _url(theme) {
        var baseUrl = '/api/v1/themes';

        if(_.isEmpty(theme)) {
          return baseUrl;
        } else {
          return baseUrl + '/' + theme.id; 
        }
      }

  }]);
})();
