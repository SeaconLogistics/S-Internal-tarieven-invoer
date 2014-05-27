#= require_self
#= require router
#= require_tree ./templates

window.STI = Em.Application.create
  rootElement: '#wrap'
  LOG_TRANSITIONS: true

$ ->
  a = ->
    data = [
        [" ", " "," "]
    ]

    $('#table').handsontable
      data: data
      startRows: 1
      startCols: 3
      colHeaders: ["Lane", "Staffel"]
      minSpareCols: 1
      beforeChange: (changes, source) ->
        fieldCount = changes.length - 1
        i = 0
        startScale = 0.000

        while i <= fieldCount
          fieldValue = changes[i][3]

          if fieldValue.match /\d+/
            fieldValue.replace /(\d+)/, (match) =>
              endScale = parseFloat(match)

              changes[i][3] = "#{startScale.toFixed(3)} - #{endScale.toFixed(3)}"

              startScale = endScale + 0.001

          i += 1


