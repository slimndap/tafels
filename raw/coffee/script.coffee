answered = 0
questions = 10
tafels = [1,2,3,4,5,10]




maak_som = ->
	jQuery('#tafel').text tafels[Math.floor Math.random()*tafels.length]
	jQuery('#times').text Math.floor Math.random()*10 + 1


check_som = ->
	if (jQuery('#tafel').text() * jQuery('#times').text()) == jQuery('#answer').val() - 0
		answered++
		maak_som()
		jQuery('#answer').val('').focus()
		jQuery('#score').text jQuery('#score').text() * 1 + 1
		jQuery('body').removeClass('wrong').addClass 'right'
	else
		jQuery('body').removeClass('right').addClass 'wrong'
	false

timer = ->
	jQuery('#time').text jQuery('#time').text() * 1 - .5


class Tafels
	constructor: ->
		@body = jQuery 'body'
	
		@tafels = [1,2,3,4,5,10]

		@score = jQuery '#score'
		@timer = jQuery '#timer'
		
		@times = jQuery '#times'
		@tafel = jQuery '#tafel'
		@answer = jQuery '#answer'
		
		@form = jQuery '#form'
		
		jQuery('.start').click => @start()
		
		@form.submit =>
			@check()
		
		setInterval () =>
			time = @timer.text() * 1
			if time > 0
				@time time - 0.5
			else
				@stop()
		, 500

	start: ->
		@reset()
		@body.addClass 'game'
		@next()
		false
		
	time: (time) ->
		@timer.text time.toFixed 1	
	
	check: ->
		if (@tafel.text() * @times.text()) == @answer.val() - 0
			@scored()
			@next()
			@body.removeClass('wrong').addClass 'right'
		else
			@body.removeClass('right').addClass 'wrong'
		false
	
	scored: (score) ->
		if score==undefined
			score = (@score.text() * 1 + 1)
			time = @timer.text() * 1 + 1
			@time time
		@score.text score
		
	next: ->
		@answer.val ''
		@tafel.text @tafels[Math.floor Math.random()*@tafels.length]
		@times.text Math.floor Math.random()*10 + 1
		@answer.focus()
	
	stop: ->
		@body.removeClass 'game right wrong'
		@body.addClass 'result'
	reset: ->
		@body.removeClass 'result right wrong'
		@answer.val ''
		@scored 0
		@time 20

jQuery ->
	tafels = new Tafels()
	