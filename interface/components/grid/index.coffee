
require "./index.styl"

ko.components.register "tf-grid",
  template: do require "./index.pug"
  viewModel: ( params ) ->
    unless ko.isObservable params.model
      throw new TypeError "components/grid:
      expects [model] to be observable"

    unless params.table?
      throw new TypeError "components/grid:
      expects [table] to exist"

    @name = params.name
    @table = params.table
    @result_table = params.result_table or "result"
    @result = ko.observableArray [ ]
    @start = ko.observable 0

    model       = params.model() # now static
    @dependent  = model.dependent
    @results    = model[@result_table]
    @tbl        = model[@table]
    @cols       = @tbl().cols
    @rows       = @tbl().rows

    console.log(@result_table, @results())

    # TODO: make this computed data for rows
    # to avoid strange logic in save and jade
    @clear = ( ) =>
      @tbl null

    @save = ( ) =>
      csv = @cols()
        .map ( v ) -> v.name
        .concat [ "Dependent", "Predicted", "Residual" ]
        .join ","

      pred = @results().predicted
      dep = @dependent()

      for row, index in @rows()
        d = row[dep]; p = pred[index]
        csv += "\n" + row.concat([d, p, d - p]).join ","

      blob = new Blob [ csv ]
      uri = URL.createObjectURL blob
      link = document.createElement "a"
      link.setAttribute "href", uri
      link.setAttribute "download", "data.csv"
      document.body.appendChild link

      link.click()
      document.body.removeChild link

      return undefined

    return this
