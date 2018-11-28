app.service 'accountService', ['$filter', '$gon', ($filter, $gon) ->

  filterBy: (filter) ->
    $filter('filter')($gon.fund_accounts, filter)

  findBy: (filter) ->
    result = @filterBy filter
    if result.length then result[0] else null

]
