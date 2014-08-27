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

  nextCounter: ->
    next = parseInt(@get('counter'))
    console.log next
    @set('counter', next+1)
    next

  postLane: (laneData) ->
    console.log laneData.join('\n')
    $.ajax(
      type: 'POST'
      scriptCharset: "utf-8"
      contentType: "application/text, charset=UTF-8"
      dataType: "text"
      url: 'http://89.20.87.230:9000/seacon_tarieven_invoer/sti_inbound'
      data: laneData.join('\n')
    )
    .done (response) ->
      console.log response
    .fail (jqXHR, textStatus) ->
      console.log 'fail', textStatus

  getTariffs: ->
    scales = @get('data')[0]
    rowIndex = 1

    while rowIndex <= @get('_count')
      @set('_tariffs', [])
      @get('_tariffs').push ""
      row = @get('data')[rowIndex]
      pricesLength = row.length - 2
      pricesIndex = 3
      lane = row[0]
      laneCounter = @nextCounter()
      while pricesIndex <= pricesLength
        price = row[pricesIndex]
        scale = scales[pricesIndex]

        tariff = row[1]
        group = row[2]
        scaleFrom = scale.match(/(\d+.\d{3})/g)[0]
        scaleTo = scale.match(/(\d+.\d{3})/g)[1]
        @get('_tariffs').push "m;#{tariff};1;#{lane};EUR;1001;N;1;1;0;;0.00;1;0.00;1;0.00;1;#{group};0;2;0;;;#{@get('fromDate')};#{@get('toDate')};0;#{scaleFrom};#{scaleTo};0;#{price};0;#{price};#{price};0;0;;;;"
        pricesIndex += 1
      @postLane (@get('_tariffs'))

      rowIndex += 1

    @get('_tariffs').join("\n")


