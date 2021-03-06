local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.swap_starting_terrain(cfg)
	wesnoth.wml_actions.store_locations {x="10",y="5",radius=9,variable="hexes"}
	wesnoth.wml_actions.terrain {x="10",y="5",radius=9,terrain="Xu"}
	wesnoth.wml_actions.terrain {x="10",y="5",radius=7,terrain="Woby"}
	wesnoth.wml_actions.redraw {}
end

function wesnoth.wml_actions.unswap_starting_terrain(cfg)
	local hexes = helper.get_variable_array("hexes")
	for i,v in ipairs(hexes) do
		wesnoth.set_terrain(hexes[i].x,hexes[i].y,hexes[i].terrain)
	end
	wesnoth.wml_actions.redraw {}
	wesnoth.set_variable("hexes",nil)
end

function wesnoth.wml_actions.clear_sound_puzzle(cfg)
	wesnoth.set_variable("puzzle_sound.counter",nil)
	wesnoth.wml_actions.remove_item {x=10,y=7}
	wesnoth.wml_actions.remove_item {x=8,y=3}
	wesnoth.wml_actions.remove_item {x=10,y=3}
	wesnoth.wml_actions.remove_item {x=12,y=3}
end

function wesnoth.wml_actions.initialize_puzzles(cfg)
    wesnoth.set_variable("puzzle_earth.complete",0)
    wesnoth.set_variable("puzzle_ice.complete",0)
    wesnoth.set_variable("puzzle_water_fire.complete",0)
    wesnoth.set_variable("puzzle_life.complete",0)
	
    wesnoth.set_variable("puzzle_earth.sunlight",0)
    wesnoth.set_variable("puzzle_earth.flower",0)
    wesnoth.set_variable("puzzle_earth.hotwater",0)
    wesnoth.set_variable("puzzle_earth.water",0)
	
	wesnoth.wml_actions.item {x=14,y=6,image="items/holy-water.png"}
	wesnoth.wml_actions.item {x=15,y=10,image="items/crystal-glyph-message.png"}
	
	wesnoth.set_variable("puzzle_ice.fruit",0)
	
	wesnoth.wml_actions.item {x=46,y=12,image="items/strawberry.png"}
	wesnoth.wml_actions.item {x=44,y=3,image="scenery/whirlpool.png"}
	wesnoth.wml_actions.item {x=43,y=15,image="items/crystal-glyph-message.png"}
	
    wesnoth.set_variable("puzzle_water_fire.scepter",0)
    wesnoth.set_variable("puzzle_water_fire.grain",0)
	
	wesnoth.wml_actions.item {x=3,y=50,image="items/sceptre-of-fire.png"}
	wesnoth.wml_actions.item {x=29,y=47,image="scenery/windmill-01.png"}
	wesnoth.wml_actions.item {x=28,y=47,image="scenery/whirlpool.png"}
	wesnoth.wml_actions.item {x=24,y=44,image="items/straw-bale1.png"}
	wesnoth.wml_actions.item {x=31,y=45,image="items/crystal-glyph-message.png"}
	
	wesnoth.set_variable("puzzle_life.fire",0)
	wesnoth.set_variable("puzzle_life.milk",0)
	wesnoth.set_variable("puzzle_life.eggs",0)
	wesnoth.set_variable("puzzle_life.chocolate",0)
	wesnoth.set_variable("puzzle_life.vanilla",0)
	wesnoth.set_variable("puzzle_life.sugar",0)
	
	wesnoth.wml_actions.item {x=11,y=27,image="items/potion-white.png"} -- milk
	wesnoth.wml_actions.item {x=13,y=30,image="items/flower1.png"} -- vanilla
	wesnoth.wml_actions.item {x=30,y=24,image="scenery/nest-full.png"}
	wesnoth.wml_actions.item {x=35,y=30,image="items/chocolate.png"}
	wesnoth.wml_actions.item {x=21,y=34,image="items/sugar.png"}
	wesnoth.wml_actions.item {x=24,y=27,image="items/crystal-glyph-message.png"}
	-- pot at 23 26
	-- fire 22 26
end

function wesnoth.wml_actions.initialize_sound_puzzle(cfg)
	wesnoth.set_variable("puzzle_sound.counter",0)
	wesnoth.set_variable("puzzle_sound.complete",0)
	wesnoth.wml_actions.item {x=10,y=7,image="items/crystal-glyph-message.png"}
	wesnoth.wml_actions.item {x=8,y=3,image="items/crystal-glyph.png"}
	wesnoth.wml_actions.item {x=10,y=3,image="items/crystal-glyph.png"}
	wesnoth.wml_actions.item {x=12,y=3,image="items/crystal-glyph.png"}
end

function wesnoth.wml_actions.sound_hex_one(cfg)
    if wesnoth.get_variable("puzzle_sound.complete") == 0 then
        wesnoth.play_sound("flute_g#_high.ogg")
        wesnoth.wml_actions.item {x=10,y=3,image="items/crystal-glyph-message-dark-1.png"}
        wesnoth.set_variable("puzzle_sound.counter",1)
    end
end

function wesnoth.wml_actions.sound_hex_two(cfg)
    if wesnoth.get_variable("puzzle_sound.complete") == 0 then 
        wesnoth.play_sound("flute_d#.ogg")
        if wesnoth.get_variable("puzzle_sound.counter") == 1 then
            wesnoth.set_variable("puzzle_sound.counter",2)
        else
            wesnoth.set_variable("puzzle_sound.counter",0)
        end
    end
end

function wesnoth.wml_actions.sound_hex_three(cfg)
    if wesnoth.get_variable("puzzle_sound.complete") == 0 then 
        wesnoth.play_sound("flute_f#.ogg")
        wesnoth.wml_actions.item {x=12,y=3,image="items/crystal-glyph-light.png"}
        if wesnoth.get_variable("puzzle_sound.counter") == 2 then
            wesnoth.set_variable("puzzle_sound.counter",3)
            local experience=wesnoth.get_variable("small_puzzle_exp")
            wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
            
            wesnoth.set_variable("puzzle_sound.complete",1)
            wesnoth.wml_actions.unswap_starting_terrain()
            wesnoth.wml_actions.clear_sound_puzzle()
            wesnoth.wml_actions.initialize_puzzles()
            wesnoth.wml_actions.fire_event {name = "transition"}
        else
            wesnoth.set_variable("puzzle_sound.counter",0)
        end
    end
end

function wesnoth.wml_actions.puzzle_earth_flower_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.flower") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="There are some flower seeds on the ground."}
		wesnoth.set_terrain(10,9,"Gll^Fp")
		wesnoth.set_variable("puzzle_earth.flower",1)
	end
end

function wesnoth.wml_actions.puzzle_earth_sunlight_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.flower") == 1 and wesnoth.get_variable("puzzle_earth.sunlight") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="The seeds blossom into a flower."}
		wesnoth.set_terrain(13,9,"Gll")
		wesnoth.wml_actions.item {x=13,y=9,image="items/flower2.png"}
		wesnoth.set_variable("puzzle_earth.flower",2)
		wesnoth.set_variable("puzzle_earth.sunlight",1)
	elseif wesnoth.get_variable("puzzle_earth.sunlight") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="A sprig of lavender has grown here."}
		wesnoth.wml_actions.remove_item {x=13,y=9}
		wesnoth.set_variable("puzzle_earth.flower",3)
		wesnoth.set_variable("puzzle_earth.sunlight",2)
	elseif wesnoth.get_variable("puzzle_earth.flower") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_earth_water_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.water") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up a glass of water."}
		wesnoth.set_terrain(14,6,"Gll^Fp")
		wesnoth.wml_actions.remove_item {x=14,y=6}
		wesnoth.set_variable("puzzle_earth.water",1)
	end
end

function wesnoth.wml_actions.puzzle_earth_fire_hex(cfg)
    if wesnoth.get_variable("puzzle_earth.water") == 1 and wesnoth.get_variable("puzzle_earth.hotwater") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="The fire heats the water."}
		wesnoth.set_terrain(18,9,"Gs^Fms")
		wesnoth.wml_actions.item {x=18,y=9,image="items/holy-water.png"}
		wesnoth.set_variable("puzzle_earth.water",2)
		wesnoth.set_variable("puzzle_earth.hotwater",1)
	elseif wesnoth.get_variable("puzzle_earth.flower") == 3 and wesnoth.get_variable("puzzle_earth.hotwater") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You made some tea!"}
		wesnoth.wml_actions.message {speaker="Yumi", message=string.format("(<i>sips</i>)")}
		wesnoth.set_terrain(15,10,"Gll^Fp")
		wesnoth.wml_actions.remove_item {x=18,y=9}
		wesnoth.wml_actions.remove_item {x=15,y=10}
		
		local experience=wesnoth.get_variable("large_puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

		wesnoth.set_variable("puzzle_earth.hotwater",2)
		wesnoth.set_variable("puzzle_earth.complete",1)
	elseif wesnoth.get_variable("puzzle_earth.complete") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_ice_fruit_hex(cfg)
	if wesnoth.get_variable("puzzle_ice.fruit") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="There are some strawberries growing here."}
		wesnoth.set_terrain(46,12,"Ai")
		wesnoth.wml_actions.remove_item {x=46,y=12}
		wesnoth.set_variable("puzzle_ice.fruit",1)
	end
end

function wesnoth.wml_actions.puzzle_ice_blender_hex(cfg)
	if wesnoth.get_variable("puzzle_ice.fruit") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You blended some strawberries."}
		wesnoth.set_terrain(44,3,"Ai")
		wesnoth.wml_actions.remove_item {x=44,y=3}
		wesnoth.wml_actions.item {x=44,y=3,image="items/potion-red.png"}
		wesnoth.set_variable("puzzle_ice.fruit",2)
	elseif wesnoth.get_variable("puzzle_ice.fruit")==2 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up the blended strawberries."}
		wesnoth.wml_actions.remove_item {x=44,y=3}
		wesnoth.set_variable("puzzle_ice.fruit",3)
	elseif wesnoth.get_variable("puzzle_ice.fruit") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_ice_freezer_hexes(cfg)
	if wesnoth.get_variable("puzzle_ice.fruit") == 3 then
		wesnoth.wml_actions.message {speaker="narrator", message="You made a popsicle!"}
		wesnoth.wml_actions.message {speaker="Yumi", message=string.format("<i>It's sweet.</i>")}
		wesnoth.set_variable("puzzle_ice.fruit",4)
		wesnoth.set_variable("puzzle_ice.complete",1)
		
		local experience=wesnoth.get_variable("small_puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
		
		wesnoth.wml_actions.remove_item {x=43,y=15}
		wesnoth.set_terrain(43,15,"Ai")
	elseif wesnoth.get_variable("puzzle_ice.complete") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_water_fire_scepter_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up a lighter."}
		wesnoth.wml_actions.remove_item {x=3,y=50}
		wesnoth.set_variable("puzzle_water_fire.scepter",1)
	end
end

function wesnoth.wml_actions.puzzle_water_fire_brazier_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You lit the brazier."}
		wesnoth.set_terrain(9,46,"Woby^Ebn")
		wesnoth.set_variable("puzzle_water_fire.scepter",2)
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 2 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up the fire."}
		wesnoth.set_terrain(9,46,"Woby")
		wesnoth.set_variable("puzzle_water_fire.scepter",3)	
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_water_fire_whirlpool_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") == 3 then
		wesnoth.wml_actions.message {speaker="narrator", message="Steam rises from the water."}
		wesnoth.wml_actions.remove_item {x=28,y=47}
		wesnoth.wml_actions.remove_item {x=29,y=47}
		wesnoth.wml_actions.item {x=29,y=47,halo="scenery/windmill-[01~18].png:80"}
		wesnoth.set_variable("puzzle_water_fire.scepter",4)
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") < 2 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_water_fire_grain_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.grain") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up some grain."}
		wesnoth.wml_actions.remove_item {x=24,y=44}
		wesnoth.set_variable("puzzle_water_fire.grain",1)
	end
end

function wesnoth.wml_actions.puzzle_water_fire_windmill_hex(cfg)
	if wesnoth.get_variable("puzzle_water_fire.scepter") < 4 then
		wesnoth.wml_actions.message {speaker="narrator", message="The windmill is not running."}
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 4 and wesnoth.get_variable("puzzle_water_fire.grain") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="The windmill is running."}
	elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 4 and wesnoth.get_variable("puzzle_water_fire.grain") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You made some bread!"}
		wesnoth.wml_actions.message {speaker="Yumi", message=string.format("(<i>nibbles</i>)")}
		wesnoth.wml_actions.remove_item {x=31,y=45}
		wesnoth.wml_actions.remove_item {x=20,y=47}
		
		local experience=wesnoth.get_variable("large_puzzle_exp")
		wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

		wesnoth.set_variable("puzzle_water_fire.scepter",5)
		wesnoth.set_variable("puzzle_water_fire.grain",2)
		wesnoth.set_variable("puzzle_water_fire.complete",1)
	end
end

function wesnoth.wml_actions.puzzle_life_fire_hex(cfg)
	if wesnoth.get_variable("puzzle_life.fire") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You got some fire."}
		wesnoth.set_terrain(22,26,"Brym")
		wesnoth.set_variable("puzzle_life.fire",1)
	end
end

function wesnoth.wml_actions.puzzle_life_brazier_hex(cfg)
	if wesnoth.get_variable("puzzle_life.fire") == 1 then
		wesnoth.wml_actions.message {speaker="narrator", message="You lit the brazier."}
		wesnoth.set_terrain(23,26,"Brym^Ebn")
		wesnoth.set_variable("puzzle_life.fire",2)
	elseif wesnoth.get_variable("puzzle_life.fire") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	elseif wesnoth.get_variable("puzzle_life.fire") == 2 then
		if wesnoth.get_variable("puzzle_life.milk") == 1 then
			wesnoth.wml_actions.message {speaker="narrator", message="You added some milk."}
			wesnoth.set_variable("puzzle_life.milk",2)
		elseif wesnoth.get_variable("puzzle_life.milk") == 0 then
			wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
		elseif wesnoth.get_variable("puzzle_life.milk") == 2 and wesnoth.get_variable("puzzle_life.eggs") == 1 then
			wesnoth.wml_actions.message {speaker="narrator", message="You put in some eggs."}
			wesnoth.set_variable("puzzle_life.eggs",2)
		elseif wesnoth.get_variable("puzzle_life.milk") == 2 and wesnoth.get_variable("puzzle_life.eggs") == 0 then
			wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
		elseif wesnoth.get_variable("puzzle_life.milk") == 2 and wesnoth.get_variable("puzzle_life.eggs") == 2 then
			if wesnoth.get_variable("puzzle_life.chocolate") ~= 1 and wesnoth.get_variable("puzzle_life.vanilla") ~= 1 and wesnoth.get_variable("puzzle_life.sugar") ~= 1 and wesnoth.get_variable("puzzle_life.vanilla") ~= 3 then
				wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
			end
			if wesnoth.get_variable("puzzle_life.chocolate") == 1 then
				wesnoth.wml_actions.message {speaker="narrator", message="You added some chocolate."}
				wesnoth.set_variable("puzzle_life.chocolate",2)
			end
			if wesnoth.get_variable("puzzle_life.vanilla") == 1 then
				wesnoth.wml_actions.message {speaker="narrator", message="You added some vanilla."}
				wesnoth.set_variable("puzzle_life.vanilla",2)
			end
			if wesnoth.get_variable("puzzle_life.sugar") == 1 then
				wesnoth.wml_actions.message {speaker="narrator", message="You added some sugar."}
				wesnoth.set_variable("puzzle_life.sugar",2)
			end
			if wesnoth.get_variable("puzzle_life.chocolate") == 2 and wesnoth.get_variable("puzzle_life.vanilla") == 2 and wesnoth.get_variable("puzzle_life.sugar") == 2 then
				wesnoth.wml_actions.message {speaker="narrator", message="You made a pudding!"}
				
				local experience=wesnoth.get_variable("large_puzzle_exp")
				wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}
				wesnoth.wml_actions.message {speaker="Yumi", message=string.format("<i>Tasty.</i>")}
				
				wesnoth.set_terrain(23,26,"Brym")
				wesnoth.wml_actions.remove_item {x=24,y=27}
				
				wesnoth.set_variable("puzzle_life.vanilla",3)
				wesnoth.set_variable("puzzle_life.chocolate",3)
				wesnoth.set_variable("puzzle_life.sugar",3)
				wesnoth.set_variable("puzzle_life.complete",1)
			end
		end
	else 
		wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
	end
end

function wesnoth.wml_actions.puzzle_life_milk_hex(cfg)
	if wesnoth.get_variable("puzzle_life.fire") == 2 and wesnoth.get_variable("puzzle_life.milk") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You got some milk."}
		wesnoth.wml_actions.remove_item {x=11,y=27}
		wesnoth.set_variable("puzzle_life.milk",1)
	elseif wesnoth.get_variable("puzzle_life.fire") == 1 or wesnoth.get_variable("puzzle_life.fire") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You need to do something else first."}
	end
end

function wesnoth.wml_actions.puzzle_life_eggs_hex(cfg)
	if wesnoth.get_variable("puzzle_life.milk") == 2 and wesnoth.get_variable("puzzle_life.eggs") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You picked up some eggs."}
		wesnoth.wml_actions.remove_item {x=30,y=24}
		wesnoth.set_variable("puzzle_life.eggs",1)
	elseif wesnoth.get_variable("puzzle_life.milk") == 1 or wesnoth.get_variable("puzzle_life.milk") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You need to do something else first."}
	end
end

function wesnoth.wml_actions.puzzle_life_chocolate_hex(cfg)
	if wesnoth.get_variable("puzzle_life.eggs") == 2 and wesnoth.get_variable("puzzle_life.chocolate") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You got some chocolate."}
		wesnoth.wml_actions.remove_item {x=35,y=30}
		wesnoth.set_variable("puzzle_life.chocolate",1)
	elseif wesnoth.get_variable("puzzle_life.eggs") == 1 or wesnoth.get_variable("puzzle_life.eggs") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You need to do something else first."}
	end
end

function wesnoth.wml_actions.puzzle_life_vanilla_hex(cfg)
	if wesnoth.get_variable("puzzle_life.eggs") == 2 and wesnoth.get_variable("puzzle_life.vanilla") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You got some vanilla."}
		wesnoth.wml_actions.remove_item {x=13,y=30}
		wesnoth.set_variable("puzzle_life.vanilla",1)
	elseif wesnoth.get_variable("puzzle_life.eggs") == 1 or wesnoth.get_variable("puzzle_life.eggs") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You need to do something else first."}
	end
end

function wesnoth.wml_actions.puzzle_life_sugar_hex(cfg)
	if wesnoth.get_variable("puzzle_life.eggs") == 2 and wesnoth.get_variable("puzzle_life.sugar") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You got some sugar."}
		wesnoth.wml_actions.remove_item {x=21,y=34}
		wesnoth.set_variable("puzzle_life.sugar",1)
	elseif wesnoth.get_variable("puzzle_life.eggs") == 1 or wesnoth.get_variable("puzzle_life.eggs") == 0 then
		wesnoth.wml_actions.message {speaker="narrator", message="You need to do something else first."}
	end
end

function wesnoth.wml_actions.clear_all_vars(cfg)
	wesnoth.set_variable("large_puzzle_exp",nil)
	wesnoth.set_variable("small_puzzle_exp",nil)
	
	wesnoth.set_variable("puzzle_sound.complete",nil)
	wesnoth.set_variable("puzzle_earth.complete",nil)
    wesnoth.set_variable("puzzle_ice.complete",nil)
    wesnoth.set_variable("puzzle_water_fire.complete",nil)
    wesnoth.set_variable("puzzle_life.complete",nil)
	
    wesnoth.set_variable("puzzle_earth.sunlight",nil)
    wesnoth.set_variable("puzzle_earth.flower",nil)
    wesnoth.set_variable("puzzle_earth.hotwater",nil)
    wesnoth.set_variable("puzzle_earth.water",nil)
	
	wesnoth.set_variable("puzzle_ice.fruit",nil)
	
    wesnoth.set_variable("puzzle_water_fire.scepter",nil)
    wesnoth.set_variable("puzzle_water_fire.grain",nil)
	
	wesnoth.set_variable("puzzle_life.fire",nil)
	wesnoth.set_variable("puzzle_life.milk",nil)
	wesnoth.set_variable("puzzle_life.eggs",nil)
	wesnoth.set_variable("puzzle_life.chocolate",nil)
	wesnoth.set_variable("puzzle_life.vanilla",nil)
	wesnoth.set_variable("puzzle_life.sugar",nil)
end

function wesnoth.wml_actions.set_ethea_variables(cfg)
    wesnoth.set_variable("ethea.prev_scenario","none")
    wesnoth.set_variable("ethea.lake",0)
    wesnoth.set_variable("ethea.vale",0)
    wesnoth.set_variable("ethea.gorge",0)
    wesnoth.set_variable("ethea.bells",0)
    wesnoth.set_variable("ethea.summit",0)
	
    wesnoth.set_variable("ethea.bat",0)
    wesnoth.set_variable("ethea.river",0)
    wesnoth.set_variable("ethea.scorpion",0)
    wesnoth.set_variable("ethea.fishing",0)
    wesnoth.set_variable("ethea.chicken",0)
    wesnoth.set_variable("ethea.temple",0)
end