api_version = "1.0.0"

kills = 0;
deaths = 0;
lastKilledBy = -1
timedSpree = 0
lastKillTime = 0
spree = 0
lastDeath = 0
spreeCounters = {}
lastKillTimes = {}
captures = 0
deathSpree = 0
queued = 0

function register_callbacks()
	mute_announcer()
	register_callback(cb['PLAYER_KILLS'], "player_kills")
	register_callback(cb['PLAYER_ENVIRONMENTAL_DEATHS'], "player_environmental_death")
	register_callback(cb['CTF_EVENTS'], "ctf_events")
	register_callback(cb['GAME_OVER'], 'game_over')
	register_callback(cb['POST_MAP_LOAD'], 'map_load')
end

function display(message, name, sound, low_priority)
	low_priority = low_priority or false 
	hud_message(message)
	queue_audio(sound, low_priority)
	display_medal(name)
end

function gfx_display(message, name, low_priority)
	low_priority = low_priority or false 
	hud_message(message)
	display_medal(name)
end

function map_load()
	kills = 0;
	deaths = 0;
	lastKilledBy = -1
	timedSpree = 0
	lastKillTime = 0
	spree = 0
	lastDeath = 0
	spreeCounters = {}
	lastKillTimes = {}
	captures = 0
	deathSpree = 0
end

function game_over()
	if(kills >= 15 and deaths == 0) then
		display("Perfection!", "images/perfection.png", "audio/perfection.mp3")
	end
end

function player_environmental_death(event, victim, player, timestamp)
	if(victim == player) then
		if(event == 6) then
			queue_audio("audio/suicide.mp3")
		end
		spree = 0
		deaths = deaths + 1
		lastDeath = timestamp
	else
		spreeCounters[victim] = 0
	end
end

function ctf_events(event, killer, victim, player, timestamp)
	if(event == 33) then
		captures = captures + 1
		if(captures == 1) then
			gfx_display("Flag Captured!", "images/flag_score.png")
		elseif(captures == 2) then
			gfx_display("Flag Runner!", "images/flag_runner.png")
		elseif(captures >= 3) then
			gfx_display("Flag Champion!", "images/flag_champion.png")
		end
	end
end

function player_kills(event, killer, victim, player, timestamp)
	if(killer == player) then
		queued = 0
		spree = spree + 1
		kills = kills + 1
		
		if(deathSpree >= 3) then
			gfx_display("Comeback!", "images/comeback.png")
		else
			killDisplay = false
		end

		deathSpree = 0
		
		if(lastKillTimes[victim] ~= nil and timestamp - lastKillTimes[victim] <= 700 and victim ~= player) then
			display("Avenger!", "images/avenger.png", "audio/hologram.mp3", true)
		end
		
		if(spreeCounters[victim] ~= nil and spreeCounters[victim] >= 5) then
			display("Killjoy!", "images/killjoy.png", "audio/killjoy.mp3")
		end

		if((timestamp - lastDeath) <= 3000) then
			display("From the Grave!", "images/from_the_grave.png", "audio/beam.mp3", true)
		end

		if(lastKilledBy == victim) then
			display("Revenge!", "images/revenge.png", "audio/revenge.mp3")
			lastKilledBy = -1
		end
		
		if((timestamp - lastKillTime) <= 4000) then
			timedSpree = timedSpree + 1
		else
			timedSpree = 1
		end

		lastKillTime = timestamp

		if(timedSpree == 2) then
			display("Double Kill!", "images/double_kill.png", "audio/double_kill.mp3")
		elseif(timedSpree == 3) then
			display("Triple Kill!", "images/triple_kill.png", "audio/triple_kill.mp3")
		elseif(timedSpree == 4) then
			display("Overkill!", "images/overkill.png", "audio/overkill.mp3")
		elseif(timedSpree == 5) then
			display("Killtacular!", "images/killtacular.png", "audio/killtacular.mp3")
		elseif(timedSpree == 6) then
			display("Killtrocity!", "images/killtrocity.png", "audio/killtrocity.mp3")
		elseif(timedSpree == 7) then
			display("Killimanjaro!", "images/killimanjaro.png", "audio/killimanjaro.mp3")
		elseif(timedSpree == 8) then
			display("Killtastrophe!", "images/killtastrophe.png", "audio/killtastrophe.mp3")
		elseif(timedSpree == 9) then
			display("Killpocalypse!", "images/killpocalypse.png", "audio/killpocalypse.mp3")
		elseif(timedSpree == 10) then
			display("Killionaire!", "images/killionaire.png", "audio/killionaire.mp3")
		end

		if(spree == 5) then
			display("Killing Spree!", "images/killing_spree.png", "audio/killing_spree.mp3")
		elseif(spree == 10) then
			display("Killing Frenzy!", "images/killing_frenzy.png", "audio/killing_frenzy.mp3")
		elseif(spree == 15) then
			display("Running Riot!", "images/running_riot.png", "audio/running_riot.mp3")
		elseif(spree == 20) then
			display("Rampage!", "images/rampage.png", "audio/rampage.mp3")
		elseif(spree == 25) then
			display("Untouchable!", "images/untouchable.png", "audio/untouchable.mp3")
		elseif(spree == 30) then
			display("Invincible!", "images/invincible.png", "audio/invincible.mp3")
		elseif(spree == 35) then
			display("Inconceivable!", "images/inconceivable.png", "audio/inconceivable.mp3")
		elseif(spree == 40) then
			display("Unfriggenbelievable!", "images/unfriggenbelievable.png", "audio/unfriggenbelievable.mp3")
		end
	else
		if(spreeCounters[killer] == nil) then
			spreeCounters[killer] = 1
		else
			spreeCounters[killer] = spreeCounters[killer] + 1
		end

		lastKillTimes[killer] = timestamp
	end

	if(victim == player) then
		lastKilledBy = killer
		lastDeath = timestamp
		spree = 0
		deaths = deaths + 1
		deathSpree = deathSpree + 1
	else
		spreeCounters[victim] = 0
	end
end