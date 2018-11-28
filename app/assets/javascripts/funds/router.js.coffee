app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state('deposits', {
      url: '/deposits'
      templateUrl: "/templates/funds/deposits.html"
    })
    .state('deposits.currency', {
      url: "/:currency"
      templateUrl: "/templates/funds/deposit.html"
      controller: 'DepositsController'
      currentAction: 'deposit'
    })
    .state('withdraws', {
      url: '/withdraws'
      templateUrl: "/templates/funds/withdraws.html"
    })
    .state('withdraws.currency', {
      url: "/:currency"
      templateUrl: "/templates/funds/withdraw.html"
      controller: 'WithdrawsController'
      currentAction: "withdraw"
    })
    # manage address
    .state('manageaddress', {
      url: '/manageaddress'
      templateUrl: "/templates/funds/deposits.html"
    })
    .state('manageaddress.currency', {
      url: "/:currency"
      templateUrl: "/templates/funds/manageaddress.html"
      controller: 'FundSourcesController'
      currentAction: "manageaddress"
    })