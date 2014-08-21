STI.IndexView = Em.View.extend
  _table: null
  fromDate: null
  toDate: null
  counter: "1"

  submit: ->
    if !@get('fromDate') or !@get('toDate') or !@get('counter')
      alert 'vanaf datum, tot datum en teller zijn verplicht'
      return

    data = @get('_table').getData()
    factory = STI.LaneTariffsFactory.create
      data: data
      fromDate: @get('fromDate')
      toDate: @get('toDate')
      counter: @get('counter')

    tariffs = factory.getTariffs()
    console.log { tariffs: tariffs }

  didInsertElement: ->
    $('#scale_table').handsontable
      data: [[" ", " "," "," "]]
      startRows: 2
      startCols: 5
      colHeaders: (col) => @get('_colHeaders')(col)
      minSpareCols: 1
      minSpareRows: 1
      beforeChange: (changes, source) => @get('_beforeChange')(changes, source)

    @set('_table', $('#scale_table').data('handsontable'))

  willDestroyElement: ->
    if @get('_table')
      @get('_table').destroy()
    @set('_table', null)

  _beforeChange: (changes, source) ->
    fieldCount = changes.length - 1
    startScale = 0.001

    i = 0
    while i <= fieldCount
      row = changes[i][0]
      col = changes[i][1]
      fieldValue = changes[i][3]

      if row == 0
        if fieldValue.match /\d+/
          fieldValue.replace /(\d+)/, (match) =>
            endScale = parseFloat(match)

            changes[i][3] = "#{startScale.toFixed(3)} - #{endScale.toFixed(3)}"

            startScale = endScale + 0.001

          i += 1
        else
          changes.splice i, 1
          fieldCount -= 1

      else
        if col > 2
          centValue = fieldValue.replace /\D/g, ''
          changes[i][3] = (centValue / 100.0).toFixed(2)

        i += 1

  _colHeaders: (col) ->
    if col == 0
      "Lane"
    else
      if col == 1
        "Tariff"
      else
        if col == 2
          "Group"
        else
          "Staffel"
      
        
