STI.IndexView = Em.View.extend
  didInsertElement: ->
    $('#scale_table').handsontable
      data: [[" ", " "," "]]
      startRows: 2
      startCols: 3
      colHeaders: ["Lane", "Staffel", "Staffel", "Staffel"]
      minSpareCols: 1
      minSpareRows: 1
      beforeChange: (changes, source) ->
        fieldCount = changes.length - 1
        i = 0
        startScale = 0.000

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
            if col != 0
              centValue = fieldValue.replace /\D/g, ''
              changes[i][3] = (centValue / 100.0).toFixed(2)

            i += 1

