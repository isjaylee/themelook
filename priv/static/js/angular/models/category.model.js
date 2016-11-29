(function() {
  'use strict';

  angular.module('themelook').factory('Category', [
    '$http', '$log',

    function($http, $log) {
      $log.info('{Model} Defining the Category model.');

      return {
        getAll:  getAll,
        loadMore: loadMore
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

      function loadMore(category, offset) {
        return $http({
          method: 'GET',
          url: _url(category) + `?offset=${offset}`
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
