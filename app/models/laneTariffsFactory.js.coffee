#= require models/laneTariffs

STI.LaneTariffsFactory = Em.Object.extend
  data: null
  fromDate: null
  toDate: null
  counter: null

  _tariffs: null
  _count: 0

  init: ->
    @set '_tariffs', STI.LaneTariffs.create()
    @set '_count', (@get('data').length - 2)

  getTariffs: ->
    @set('_tariffs', [])

    scales = @get('data')[0]
    rowIndex = 1

    while rowIndex <= @get('_count')
      row = @get('data')[rowIndex]
      pricesLength = row.length - 2
      pricesIndex = 1
      lane = row[0]

      while pricesIndex <= pricesLength
        price = row[pricesIndex]
        scale = scales[pricesIndex]
        scaleFrom = scale.match(/(\d+.\d{3})/g)[0]
        scaleTo = scale.match(/(\d+.\d{3})/g)[1]

        @get('_tariffs').push "i;#{@get('counter')};1;#{lane};EUR;1699;N;1;1;0;;0.00;1;0.00;1;0.00;1;SCJV;0;2;0;;;#{@get('fromDate')};#{@get('toDate')};0;#{scaleFrom};#{scaleTo};0;#{price};0;#{price};#{price};0;0;;;;"
        pricesIndex += 1

      rowIndex += 1

    @get('_tariffs').join("\n")
