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
	create_animations()
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


function create_animations()
	--Spritesheet animation
	create_animation("blue_flash")
	add_keyframe("blue_flash", 0, 0.7, 4)
	add_keyframe("blue_flash", 0, 1.5, 0)
	add_keyframe("blue_flash", 150, 1.0, 0)
	create_sprite("blue_flash", "images/h4glowsprite.png", "blue_flash")
	sprite_properties("blue_flash", false, 1, 4, 30, 0, 0)

	--H4 medal animation
	create_animation("h4_ani")
	add_keyframe("h4_ani", 0, 2.0, 0)
	add_keyframe("h4_ani", 30, 2.0, 0)
	add_keyframe("h4_ani", 60, 1.5, 0)
	--add_keyframe("h4_ani", 90, 1.3, 0)
	add_keyframe("h4_ani", 90, 1.0, 0)

	add_keyframe("h4_ani", 0, 0.2, 4)
	add_keyframe("h4_ani", 30, 0.2, 4)
	add_keyframe("h4_ani", 90, 0.75, 4)
	add_keyframe("h4_ani", 1620, 0.75, 4)
	add_keyframe("h4_ani", 1710, 0.0, 4)

	--Slide animation
	create_animation("slide")
	add_keyframe("slide", 0, 0.0, 8)

	--Main animation
	create_animation("main")
	add_keyframe("main", 0, 0.010, 8)
	add_keyframe("main", 0, 0.49, 9)
	add_keyframe("main", 0, 1.0, 0)
	add_keyframe("main", 1710, 1.0, 0)
	
	--Kill medal
	create_sprite("kill", "images/kill.png", "h4_ani")
	create_medal("kill_medal", "main")
	attach_sprite("kill_medal", "kill")
	attach_sprite("kill_medal", "blue_flash")
	medal_slide_animation("kill_medal", "slide")

	--Double kill
	create_sprite("double_kill", "images/double_kill.png", "h4_ani")
	create_medal("double_kill_medal", "main")
	attach_sprite("double_kill_medal", "double_kill")
	attach_sprite("double_kill_medal", "blue_flash")
	medal_slide_animation("double_kill_medal", "slide")

	--From the grave
	create_sprite("from_the_grave", "images/from_the_grave.png", "h4_ani")
	create_medal("from_the_grave_medal", "main")
	attach_sprite("from_the_grave_medal", "from_the_grave")
	attach_sprite("from_the_grave_medal", "blue_flash")
	medal_slide_animation("from_the_grave_medal", "slide")

	--Revenge
	create_sprite("revenge", "images/revenge.png", "h4_ani")
	create_medal("revenge_medal", "main")
	attach_sprite("revenge_medal", "revenge")
	attach_sprite("revenge_medal", "blue_flash")
	medal_slide_animation("revenge_medal", "slide")

	--Triple kill
	create_sprite("triple_kill", "images/triple_kill.png", "h4_ani")
	create_medal("triple_kill_medal", "main")
	attach_sprite("triple_kill_medal", "triple_kill")
	attach_sprite("triple_kill_medal", "blue_flash")
	medal_slide_animation("triple_kill_medal", "slide")
	
	--Flag capture
	create_sprite("flag_capture", "images/flag_capture.png", "h4_ani")
	create_medal("flag_capture_medal", "main")
	attach_sprite("flag_capture_medal", "flag_capture")
	attach_sprite("flag_capture_medal", "blue_flash")
	medal_slide_animation("flag_capture_medal", "slide")
	
	--Flag runner
	create_sprite("flag_runner", "images/flag_runner.png", "h4_ani")
	create_medal("flag_runner_medal", "main")
	attach_sprite("flag_runner_medal", "flag_runner")
	attach_sprite("flag_runner_medal", "blue_flash")
	medal_slide_animation("flag_runner_medal", "slide")
	
	--Flag champion
	create_sprite("flag_champion", "images/flag_champion.png", "h4_ani")
	create_medal("flag_champion_medal", "main")
	attach_sprite("flag_champion_medal", "flag_champion")
	attach_sprite("flag_champion_medal", "blue_flash")
	medal_slide_animation("flag_champion_medal", "slide")
	
	--Avenger
	create_sprite("avenger", "images/avenger.png", "h4_ani")
	create_medal("avenger_medal", "main")
	attach_sprite("avenger_medal", "avenger")
	attach_sprite("avenger_medal", "blue_flash")
	medal_slide_animation("avenger_medal", "slide")
	
	--Comeback
	create_sprite("comeback", "images/comeback_kill.png", "h4_ani")
	create_medal("comeback_medal", "main")
	attach_sprite("comeback_medal", "comeback")
	attach_sprite("comeback_medal", "blue_flash")
	medal_slide_animation("comeback_medal", "slide")
	
	--Killjoy
	create_sprite("killjoy", "images/killjoy.png", "h4_ani")
	create_medal("killjoy_medal", "main")
	attach_sprite("killjoy_medal", "killjoy")
	attach_sprite("killjoy_medal", "blue_flash")
	medal_slide_animation("killjoy_medal", "slide")
	
	--Overkill
	create_sprite("overkill", "images/overkill.png", "h4_ani")
	create_medal("overkill_medal", "main")
	attach_sprite("overkill_medal", "overkill")
	attach_sprite("overkill_medal", "blue_flash")
	medal_slide_animation("overkill_medal", "slide")
	
	--Killtacular
	create_sprite("killtacular", "images/killtacular.png", "h4_ani")
	create_medal("killtacular_medal", "main")
	attach_sprite("killtacular_medal", "killtacular")
	attach_sprite("killtacular_medal", "blue_flash")
	medal_slide_animation("killtacular_medal", "slide")
	
	--Killtrocity
	create_sprite("killtrocity", "images/killtrocity.png", "h4_ani")
	create_medal("killtrocity_medal", "main")
	attach_sprite("killtrocity_medal", "killtrocity")
	attach_sprite("killtrocity_medal", "blue_flash")
	medal_slide_animation("killtrocity_medal", "slide")
	
	--Killimanjaro
	create_sprite("killimanjaro", "images/killimanjaro.png", "h4_ani")
	create_medal("killimanjaro_medal", "main")
	attach_sprite("killimanjaro_medal", "killimanjaro")
	attach_sprite("killimanjaro_medal", "blue_flash")
	medal_slide_animation("killimanjaro_medal", "slide")
	
	--Killtastrophe
	create_sprite("killtastrophe", "images/killtastrophe.png", "h4_ani")
	create_medal("killtastrophe_medal", "main")
	attach_sprite("killtastrophe_medal", "killtastrophe")
	attach_sprite("killtastrophe_medal", "blue_flash")
	medal_slide_animation("killtastrophe_medal", "slide")
	
	--Killpocalypse
	create_sprite("killpocalypse", "images/killpocalypse.png", "h4_ani")
	create_medal("killpocalypse_medal", "main")
	attach_sprite("killpocalypse_medal", "killpocalypse")
	attach_sprite("killpocalypse_medal", "blue_flash")
	medal_slide_animation("killpocalypse_medal", "slide")
	
	--Killionaire
	create_sprite("killionaire", "images/killionaire.png", "h4_ani")
	create_medal("killionaire_medal", "main")
	attach_sprite("killionaire_medal", "killionaire")
	attach_sprite("killionaire_medal", "blue_flash")
	medal_slide_animation("killionaire_medal", "slide")
	
	--Killing spree
	create_sprite("killing_spree", "images/killing_spree.png", "h4_ani")
	create_medal("killing_spree_medal", "main")
	attach_sprite("killing_spree_medal", "killing_spree")
	attach_sprite("killing_spree_medal", "blue_flash")
	medal_slide_animation("killing_spree_medal", "slide")
	
	--Killing frenzy
	create_sprite("killing_frenzy", "images/killing_frenzy.png", "h4_ani")
	create_medal("killing_frenzy_medal", "main")
	attach_sprite("killing_frenzy_medal", "killing_frenzy")
	attach_sprite("killing_frenzy_medal", "blue_flash")
	medal_slide_animation("killing_frenzy_medal", "slide")
	
	--Running riot
	create_sprite("running_riot", "images/running_riot.png", "h4_ani")
	create_medal("running_riot_medal", "main")
	attach_sprite("running_riot_medal", "running_riot")
	attach_sprite("running_riot_medal", "blue_flash")
	medal_slide_animation("running_riot_medal", "slide")
	
	--Rampage
	create_sprite("rampage", "images/rampage.png", "h4_ani")
	create_medal("rampage_medal", "main")
	attach_sprite("rampage_medal", "rampage")
	attach_sprite("rampage_medal", "blue_flash")
	medal_slide_animation("rampage_medal", "slide")
	
	--Untouchable
	create_sprite("untouchable", "images/untouchable.png", "h4_ani")
	create_medal("untouchable_medal", "main")
	attach_sprite("untouchable_medal", "untouchable")
	attach_sprite("untouchable_medal", "blue_flash")
	medal_slide_animation("untouchable_medal", "slide")
	
	--Invincible
	create_sprite("invincible", "images/invincible.png", "h4_ani")
	create_medal("invincible_medal", "main")
	attach_sprite("invincible_medal", "invincible")
	attach_sprite("invincible_medal", "blue_flash")
	medal_slide_animation("invincible_medal", "slide")
	
	--Inconceivable
	create_sprite("inconceivable", "images/inconceivable.png", "h4_ani")
	create_medal("inconceivable_medal", "main")
	attach_sprite("inconceivable_medal", "inconceivable")
	attach_sprite("inconceivable_medal", "blue_flash")
	medal_slide_animation("inconceivable_medal", "slide")
	
	--Unfriggenbelievable
	create_sprite("unfriggenbelievable", "images/unfriggenbelievable.png", "h4_ani")
	create_medal("unfriggenbelievable_medal", "main")
	attach_sprite("unfriggenbelievable_medal", "unfriggenbelievable")
	attach_sprite("unfriggenbelievable_medal", "blue_flash")
	medal_slide_animation("unfriggenbelievable_medal", "slide")
end