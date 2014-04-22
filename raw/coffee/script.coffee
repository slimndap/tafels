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
		jQuery('progress').attr 'value', answered
		jQuery('#answer').val('').focus()
		jQuery('body').removeClass('wrong').addClass 'right'
	else
		jQuery('body').removeClass('right').addClass 'wrong'
	
	false
	
jQuery ->
	maak_som()
	jQuery('#form').submit -> check_som()
	
	