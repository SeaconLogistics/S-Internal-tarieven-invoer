STI.DatePickerField = Em.TextField.extend
  _picker: null

  didInsertElement: ->
    currentYear = (new Date()).getFullYear()
    picker = new Pikaday
      field: @$()[0]
      format: 'YYYYMMDD'

    @set("_picker", picker)
