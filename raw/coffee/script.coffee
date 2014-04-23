class Tafels
	constructor: ->
		@body = jQuery 'body'
	
		@score = jQuery '.scoreboard'
		@timer = jQuery '#timer'
		
		@times = jQuery '#times'
		@tafel = jQuery '#tafel'
		@answer = jQuery '#answer'
		
		@form = jQuery '#form'
		
		jQuery('.start').click => @start()
		jQuery('.settings').click => @settings()
		jQuery('.keyboard button').click (e) => @key e.currentTarget
		
		@form.submit =>
			@check()
		
		setInterval () =>
			time = @timer.text() * 1
			if @body.hasClass 'game'
				if time > 0 and 
					@time time - 0.1
				else
					@stop()
		, 100

	start: ->
		@reset()
		if @tafels().length > 0
			@body.addClass 'game'
			@next()
		else
			@settings()
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
			score = (@score.eq(0).text() * 1) + 1
			time = @timer.text() * 1 + 1
			@time time
		@score.text score
		
	next: ->
		tafels = @tafels()
		@answer.val ''
		@tafel.text tafels[Math.floor Math.random()*tafels.length]
		@times.text Math.floor Math.random()*10 + 1
	
	stop: ->
		@body.removeClass 'game right wrong'
		@body.addClass 'result'
		
	reset: ->
		@body.removeClass 'result settings right wrong'
		@answer.val ''
		@scored 0
		@time 20
		
	settings: ->
		@body.removeClass 'game result right wrong'
		@body.addClass 'settings'
		false
		
	tafels: ->
		tafels = []
		jQuery('input.tafel:checked').each ->
			tafels.push jQuery(@).val()
		return tafels

	key: (button) ->
		switch jQuery(button).val()
			when 'x' then @answer.val ''
			when 'go' then @check()
			else 
				@answer.val @answer.val() + jQuery(button).val()

jQuery ->
	tafels = new Tafels()
	FastClick.attach document.body
	