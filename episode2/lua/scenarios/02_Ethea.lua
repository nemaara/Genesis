local helper = wesnoth.require "lua/helper.lua"

function wesnoth.wml_actions.initialize_puzzles(cfg)
    wesnoth.put_unit(7, 5, { type = "Giant Scorpling", side = 2 })
    wesnoth.put_unit(7, 6, { type = "Giant Scorpling", side = 2 })
    wesnoth.put_unit(8, 5, { type = "Giant Scorpling", side = 2 })
    wesnoth.put_unit(10, 4, { type = "Giant Scorpling", side = 2 })
    
    if wesnoth.get_variable("ethea.bat") < 3 then
        wesnoth.put_unit(29, 11, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(24, 10, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(24, 13, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(28, 14, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(30, 12, { type = "Vampire Bat", side = 2 })
    else
        wesnoth.put_unit(29, 11, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(24, 10, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(24, 13, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(28, 14, { type = "Vampire Bat", side = 2 })
        wesnoth.put_unit(26, 13, { type = "Blood Bat", side = 2, name = "Eksi" })
    end
    if wesnoth.get_variable("ethea.river") < 3 then
        wesnoth.set_terrain(53,18,"Gd^Dr")
        wesnoth.set_terrain(50,16,"Wwg")
        wesnoth.set_terrain(51,16,"Wwg")
        wesnoth.set_terrain(49,17,"Ss")
        wesnoth.set_terrain(48,17,"Ss")
        wesnoth.set_terrain(48,18,"Sm")
        wesnoth.set_terrain(47,19,"Sm")
        wesnoth.set_terrain(46,19,"Ss")
        wesnoth.set_terrain(45,20,"Ss")
        wesnoth.set_terrain(45,19,"Sm")
        wesnoth.set_terrain(46,20,"Ss")
        wesnoth.set_terrain(46,21,"Ss")
        wesnoth.set_terrain(45,22,"Sm")
        wesnoth.set_terrain(44,22,"Sm")
        wesnoth.set_terrain(42,21,"Sm")
        wesnoth.set_terrain(41,22,"Sm")
        wesnoth.set_terrain(42,22,"Sm")
        wesnoth.set_terrain(40,23,"Sm")
        wesnoth.set_terrain(41,24,"Sm")
        wesnoth.set_terrain(41,23,"Sm")
        wesnoth.set_terrain(44,25,"Sm")
        wesnoth.set_terrain(45,25,"Sm")
        wesnoth.set_terrain(45,24,"Sm")
        wesnoth.set_terrain(44,23,"Ss")
        wesnoth.set_terrain(44,24,"Ss")
        wesnoth.set_terrain(43,24,"Ss")
        wesnoth.set_terrain(43,23,"Ss")
        wesnoth.set_terrain(42,23,"Ss")
        wesnoth.set_terrain(42,24,"Ss")
        wesnoth.set_terrain(41,25,"Ss")
    else
        wesnoth.set_terrain(49,18,"Wwt")
        wesnoth.set_terrain(48,17,"Gd^Dr")
    end
    if wesnoth.get_variable("ethea.scorpion") > 2 then
        wesnoth.set_terrain(15,2,"Hhd")
        wesnoth.set_terrain(9,4,"Qdrt^Efs")
    else
    end
    if wesnoth.get_variable("ethea.fishing") > 1 then
        wesnoth.set_terrain(55,32,"Wwt")
    end
    if wesnoth.get_variable("ethea.temple") > 0 then
        wesnoth.set_terrain(48,5,"Dd")
        wesnoth.set_terrain(48,6,"Drt")
    end
end

function wesnoth.wml_actions.bat_dialogue_hex(cfg)
    if wesnoth.get_variable("ethea.bat") == 0 then
        wesnoth.wml_actions.message {speaker="Esther", message="Whoa, what are all of these bats doing here?"}
        wesnoth.wml_actions.message {speaker="Ebitta", message="They're my pets! Aren't they cute?"}
        wesnoth.wml_actions.message {speaker="Esther", message="Erm... yes. I suppose they're cute. How do you keep them from biting you, though?"}
        wesnoth.wml_actions.message {speaker="Ebitta", message="Oh, are you worried about that? There's no need. They're really all very well behaved. Well, except for Eksi. She likes to run off on her own."}
        wesnoth.wml_actions.message {speaker="Aryel", message="Where is she now?"}
        wesnoth.wml_actions.message {speaker="Ebitta", message="Hmm. I'm not really sure. Would you mind helping me look for her?"}
        wesnoth.wml_actions.message {speaker="Aryel", message="Meh, why not."}

        wesnoth.set_variable("ethea.bat",1)
    elseif wesnoth.get_variable("ethea.bat") == 1 then
        wesnoth.wml_actions.message {speaker="Ebitta", message="Oh Eskiiii, where are youuuuu?"}
    elseif wesnoth.get_variable("ethea.bat") == 2 then
        wesnoth.wml_actions.message {speaker="Ebitta", message="Oh, you found my cute little Eksi! Come here girl, mommy's got a little treat for you!"}
        wesnoth.wml_actions.message {speaker="Eksi", message="Neep! Neep!"}
        wesnoth.wml_actions.message {speaker="Ebitta", message="Thanks for finding Eksi for me, faeries. You gals are always so helpful!"}
        wesnoth.wml_actions.message {speaker="Esther", message="Haha, it's kind of what we do."}

        local experience=wesnoth.get_variable("puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

        wesnoth.set_variable("ethea.bat",3)
    elseif wesnoth.get_variable("ethea.bat") == 3 then
        wesnoth.wml_actions.message {speaker="Ebitta", message="Thanks again for helping me find Eksi!"}
    end
end

function wesnoth.wml_actions.river_dialogue_hex(cfg)
    if wesnoth.get_variable("ethea.river") == 0 then
        wesnoth.wml_actions.message {speaker="Esther", message="Yikes. What happened here?"}
        wesnoth.wml_actions.message {speaker="Villager", message="We dunna kno. Just a coupla days ago, I tells ma boy to goes fetch some water from tha pond. He comes aback 'n it's all mucky and poison-looking, like dat sewer water 'n tha cities. We been livin' on tha well water fo' now. Dun suppose yew faeries kinna help us, no?"}
        wesnoth.wml_actions.message {speaker="Esther", message=string.format("(<i>glances at Aryel</i>)")}
        wesnoth.wml_actions.message {speaker="Aryel", message=string.format("(<i>shrugs</i>) Might as well take a look.")}
        wesnoth.wml_actions.message {speaker="Villager", message="Thank ye, kind faeries!"}

        wesnoth.set_variable("ethea.river",1)
    elseif wesnoth.get_variable("ethea.river") == 1 then
        wesnoth.wml_actions.message {speaker="Villager", message="Please help us clean tha water!"}
    elseif wesnoth.get_variable("ethea.river") == 3 then
        wesnoth.wml_actions.message {speaker="Villager", message="Tha water be clean again! Many thanks and blessings for ye faeries!"}
        wesnoth.wml_actions.message {speaker="Aryel", message="Yup, yup, no problem."}

        local experience=wesnoth.get_variable("puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

        wesnoth.set_variable("ethea.river",4)
    elseif wesnoth.get_variable("ethea.river") == 4 then
        wesnoth.wml_actions.message {speaker="Villager", message="Tha water be crystal clear!"}
    end
end

function wesnoth.wml_actions.river_stone_hex(cfg)
    if wesnoth.get_variable("ethea.river") == 0 then
        wesnoth.wml_actions.message {speaker="Aryel", message="I wonder what this rock is for."}
    elseif wesnoth.get_variable("ethea.river") == 1 then
        wesnoth.wml_actions.message {speaker="Aryel", message="I guess this rock could be useful."}
        wesnoth.set_terrain(53,18,"Gd")
        wesnoth.set_variable("ethea.river",2)
    end
end

function wesnoth.wml_actions.river_puzzle_hex(cfg)
    if wesnoth.get_variable("ethea.river") == 2 then
        wesnoth.wml_actions.message {speaker="Aryel", message="Hey, looks like we can block the river here and make the water flow around the rock to keep it from being corrupted."}
        wesnoth.delay(300)
        wesnoth.set_terrain(48,17,"Gd^Dr")
        wesnoth.fire("redraw")
        wesnoth.delay(450)
        wesnoth.play_sound("water-blast.wav")
        wesnoth.delay(450)
        wesnoth.set_terrain(51,16,"Wwt")
        wesnoth.set_terrain(50,16,"Wwt")
        wesnoth.set_terrain(49,17,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(49,18,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(48,18,"Wwt")
        wesnoth.set_terrain(47,19,"Wwt")
        wesnoth.set_terrain(46,19,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(45,20,"Wwt")
        wesnoth.set_terrain(45,19,"Wwt")
        wesnoth.set_terrain(46,20,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(46,21,"Wwt")
        wesnoth.set_terrain(45,22,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(44,22,"Wwt")
        wesnoth.set_terrain(44,23,"Wwt")
        wesnoth.set_terrain(43,23,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(42,22,"Wwt")
        wesnoth.set_terrain(42,23,"Wwt")
        wesnoth.set_terrain(43,24,"Wwt")
        wesnoth.set_terrain(44,24,"Wwt")
        wesnoth.set_terrain(45,24,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(45,25,"Wwt")
        wesnoth.set_terrain(44,25,"Wwt")
        wesnoth.set_terrain(41,24,"Wwt")
        wesnoth.set_terrain(42,24,"Wwt")
        wesnoth.set_terrain(41,22,"Wwt")
        wesnoth.set_terrain(41,23,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(350)
        wesnoth.set_terrain(40,23,"Wwt")
        wesnoth.set_terrain(42,21,"Wwt")
        wesnoth.set_terrain(41,25,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.delay(700)
        wesnoth.wml_actions.message {speaker="Aryel", message="Piece of cake."}
        wesnoth.set_variable("ethea.river",3)
    end
end

function wesnoth.wml_actions.scorpion_dialogue_hex(cfg)
    if wesnoth.get_variable("ethea.scorpion") == 0 then
        wesnoth.wml_actions.message {speaker="Aryel", message="Whoa. That's a lot of scorpions!"}
        wesnoth.wml_actions.message {speaker="Mika", message="Pretty little things, right? But be careful around them. Flies around here have been gettin' crafty, so it's been hard to feed the little scorpies."}
        wesnoth.wml_actions.message {speaker="Esther", message="There should be a way to attract those pesky flies."}
        wesnoth.wml_actions.message {speaker="Aryel", message="Like what?"}
        wesnoth.wml_actions.message {speaker="Esther", message="I don't know. Why don't we have a look around?"}
        wesnoth.wml_actions.message {speaker="Mika", message="Don't know if you'll find much, but good luck!"}

        wesnoth.set_variable("ethea.scorpion",1)
    elseif wesnoth.get_variable("ethea.scorpion") == 1 then
        wesnoth.wml_actions.message {speaker="Mika", message="Try not to get bitten by those annoying flies!"}
    elseif wesnoth.get_variable("ethea.scorpion") == 2 then
        wesnoth.set_terrain(9,4,"Qdrt^Efs")
        wesnoth.fire("redraw")
        wesnoth.wml_actions.message {speaker="Mika", message="Oooh, that's clever. The flies do seem to like those pretty lights."}
        wesnoth.wml_actions.message {speaker="Aryel", message="Yeah, looks like they're coming now. Your scorpions are going to have a feast."}
        wesnoth.wml_actions.message {speaker="Mika", message="Super. Thanks so much!"}

        local experience=wesnoth.get_variable("puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

        wesnoth.set_variable("ethea.scorpion",3)
    elseif wesnoth.get_variable("ethea.scorpion") == 3 then
        wesnoth.wml_actions.message {speaker="Mika", message="Go play with the scorpies, it's fun!"}
    end
end

function wesnoth.wml_actions.scorpion_sconce_hex(cfg)
    if wesnoth.get_variable("ethea.scorpion") == 1 then
        wesnoth.wml_actions.message {speaker="Esther", message="I think flies like lights like these, right?"}
        wesnoth.wml_actions.message {speaker="Aryel", message="Looks like it - see how many of 'em are around here? Let's take it with us."}
        wesnoth.set_terrain(15,2,"Hhd")
        wesnoth.fire("redraw")
        wesnoth.set_variable("ethea.scorpion",2)
    end
end

function wesnoth.wml_actions.chicken_dialogue_hex(cfg)
    if wesnoth.get_variable("ethea.chicken") == 0 then
        wesnoth.wml_actions.message {speaker="Kadishi", message="(<i>squints</i>) Well hello! Y'all are faeries, aren't ya?"}
        wesnoth.wml_actions.message {speaker="Aryel", message=string.format("Erm, yeah. Why do you ask?")}
        wesnoth.wml_actions.message {speaker="Kadishi", message="Well it's not just every day ya see a faerie wanderin' around here. Yer from Irdya, aren't ya?"}
        wesnoth.wml_actions.message {speaker="Esther", message="Yup, we're just visiting for a while. Heard the food here is really good, you know."}
        wesnoth.wml_actions.message {speaker="Kadishi", message="Yeah, we're famous for our eggs! You wanna try one? Your friend over there looks like she might like a taste."}
        wesnoth.wml_actions.message {speaker="Yumi", message=string.format("(<i>fidgets</i>)")}
        wesnoth.wml_actions.message {speaker="Esther", message="Haha, don't be shy, you glutton. Go for it."}
        wesnoth.wml_actions.message {speaker="Yumi", message=string.format("(<i>rolls eyes</i>)")}

        wesnoth.wml_actions.add_hp {hp=1,{"filter",{id="Yumi"}}}
        wesnoth.set_variable("ethea.chicken",1)
    elseif wesnoth.get_variable("ethea.chicken") == 1 then
        wesnoth.wml_actions.message {speaker="Kadishi", message="Look at all the chickens! Aren't they cute?"}
    end
end

function wesnoth.wml_actions.fisherman_dialogue_hex(cfg)
    if wesnoth.get_variable("ethea.fishing") == 0 then
        wesnoth.wml_actions.message {speaker="Xlzyx", message="Giiiit outta my house ya damn- oh. Ye ain't dem blasted imps."}
        wesnoth.wml_actions.message {speaker="Esther", message="... right. What'd those imps do to you?"}
        wesnoth.wml_actions.message {speaker="Xlzyx", message="Stole my ice pick, that be what they did! Now I gots no way to crack open tha ice and gets me some fish."}
        wesnoth.wml_actions.message {speaker="Aryel", message="And fire doesn't work?"}
        wesnoth.wml_actions.message {speaker="Xlzyx", message="Don't got any. 'n don't even think about suggestin' I make some like them other damn demons. Why ya think I live out here all by myself? It's coz I hate bein' bothered about all this schmuck!"}
        wesnoth.wml_actions.message {speaker="Esther", message="Well... okay. We'll stop troubling you for now, then."}
        wesnoth.set_variable("ethea.fishing",1)
    elseif wesnoth.get_variable("ethea.fishing") == 1 then
        wesnoth.wml_actions.message {speaker="Xlzyx", message="If ye gots nothin' to say, leave me alone!"}
    elseif wesnoth.get_variable("ethea.fishing") == 2 then
        wesnoth.wml_actions.message {speaker="Xlzyx", message="So, yall melted the ice. Now I can finally gets me some fish."}
        local u = wesnoth.get_unit("Xlzyx")
        wesnoth.erase_unit(u)
        wesnoth.delay(700)
        wesnoth.wml_actions.message {speaker="Aryel", message="Alright, then. You're welcome, weirdo."}

        local experience=wesnoth.get_variable("puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Aryel"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Esther"}}}
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

        wesnoth.set_variable("ethea.fishing",3)
    elseif wesnoth.get_variable("ethea.fishing") == 3 or wesnoth.get_variable("ethea.fishing") == 4 then
        wesnoth.wml_actions.message {speaker="Xlzyx", message="What ya starin' at, huh?"}
    end
end

function wesnoth.wml_actions.fishing_puzzle_hex(cfg)
    local u = wesnoth.get_unit("Esther")
    if wesnoth.get_variable("ethea.fishing") == 1 and u.x == 55 and u.y ==32 then
        wesnoth.wml_actions.message {speaker="Esther", message="Hmm. I suppose I could melt the ice for that crabby old dog."}
        wesnoth.wml_actions.message {speaker="Aryel", message="If you want."}
        wesnoth.wml_actions.message {speaker="Esther", message="Well, why not?"}
        wesnoth.delay(500)
        wesnoth.play_sound("fire.wav")
        wesnoth.set_terrain(55,32,"Wwt")
        wesnoth.fire("redraw")
        wesnoth.wml_actions.message {speaker="Esther", message="All done."}
        wesnoth.set_variable("ethea.fishing",2)
    elseif wesnoth.get_variable("ethea.fishing") == 1 then
        wesnoth.wml_actions.message {speaker="Aryel", message="Guess we need Esther for this."}
    elseif wesnoth.get_variable("ethea.fishing") == 3 then
        wesnoth.wml_actions.message {speaker="Aryel", message="Should be easy to catch some fish, if you gals are hungry."}
        wesnoth.wml_actions.message {speaker="Esther", message="Not me. Yumi?"}
        wesnoth.wml_actions.message {speaker="Yumi", message="It stinks..."}
        wesnoth.wml_actions.message {speaker="Aryel", message="Alright. All for me, then."}
        wesnoth.wml_actions.add_hp {hp=1,{"filter",{id="Aryel"}}}
        wesnoth.set_variable("ethea.fishing",4)
    end
end

function wesnoth.wml_actions.temple_lights(cfg)
    local t1 = wesnoth.get_terrain(45,9)
    local t2 = wesnoth.get_terrain(47,10)
    local t3 = wesnoth.get_terrain(48,11)
    local t4 = wesnoth.get_terrain(47,13)
    local t5 = wesnoth.get_terrain(45,14)
    local t6 = wesnoth.get_terrain(43,13)
    local t7 = wesnoth.get_terrain(42,11)
    local t8 = wesnoth.get_terrain(43,10)
    if t1 == "Bryd^Ii" then
        wesnoth.set_terrain(45,9,"Bryd")
        wesnoth.set_terrain(47,10,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t2 == "Bryd^Ii" then
        wesnoth.set_terrain(47,10,"Bryd")
        wesnoth.set_terrain(48,11,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t3 == "Bryd^Ii" then
        wesnoth.set_terrain(48,11,"Bryd")
        wesnoth.set_terrain(47,13,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t4 == "Bryd^Ii" then
        wesnoth.set_terrain(47,13,"Bryd")
        wesnoth.set_terrain(45,14,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t5 == "Bryd^Ii" then
        wesnoth.set_terrain(45,14,"Bryd")
        wesnoth.set_terrain(43,13,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t6 == "Bryd^Ii" then
        wesnoth.set_terrain(43,13,"Bryd")
        wesnoth.set_terrain(42,11,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t7 == "Bryd^Ii" then
        wesnoth.set_terrain(42,11,"Bryd")
        wesnoth.set_terrain(43,10,"Bryd^Ii")
        wesnoth.fire("redraw")
    elseif t8 == "Bryd^Ii" then
        wesnoth.set_terrain(43,10,"Bryd")
        wesnoth.set_terrain(45,9,"Bryd^Ii")
        wesnoth.fire("redraw")
    end
end

function wesnoth.wml_actions.temple_puzzle_hex(cfg)
    local t = wesnoth.get_terrain(45,9)
    if t == "Bryd^Ii" and wesnoth.get_variable("ethea.temple") == 0 then
        wesnoth.delay(200)
        wesnoth.play_sound("rumble.ogg")
        wesnoth.play_sound("rumble.ogg")
        wesnoth.delay(500)
        wesnoth.set_terrain(48,5,"Dd")
        wesnoth.set_terrain(48,6,"Drt")
        wesnoth.fire("redraw")
        wesnoth.delay(500)
        wesnoth.wml_actions.message {speaker="Esther", message="Whoa. Those mountains just... disappeared. Looks like there's some kind of temple inside?"}
        wesnoth.wml_actions.message {speaker="Aryel", message="Might be worth checking out."}
        wesnoth.set_variable("ethea.temple",1)
    end
end

--[[


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

function wesnoth.wml_actions.puzzle_ice_blender_hex(cfg)
    if wesnoth.get_variable("puzzle_ice.fruit") == 1 then
        wesnoth.wml_actions.message {speaker="narrator", message="You blended some strawberries."}
        wesnoth.set_terrain(44,3,"Ai")
        wesnoth.set_variable("puzzle_ice.fruit",2)
    elseif wesnoth.get_variable("puzzle_ice.fruit")==2 then
        wesnoth.wml_actions.message {speaker="narrator", message="You picked up the blended strawberries."}
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
    elseif wesnoth.get_variable("puzzle_ice.complete") == 0 then
        wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
    end
end

function wesnoth.wml_actions.puzzle_water_fire_scepter_hex(cfg)
    if wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
        wesnoth.wml_actions.message {speaker="narrator", message="You picked up a lighter."}
        wesnoth.set_variable("puzzle_water_fire.scepter",1)
    end
end

function wesnoth.wml_actions.puzzle_water_fire_brazier_hex(cfg)
    if wesnoth.get_variable("puzzle_water_fire.scepter") == 1 then
        wesnoth.wml_actions.message {speaker="narrator", message="You lit the brazier."}
        wesnoth.set_variable("puzzle_water_fire.scepter",2)
    elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 2 then
        wesnoth.wml_actions.message {speaker="narrator", message="You picked up the fire."}
        wesnoth.set_variable("puzzle_water_fire.scepter",3)
    elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
        wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
    end
end

function wesnoth.wml_actions.puzzle_water_fire_whirlpool_hex(cfg)
    if wesnoth.get_variable("puzzle_water_fire.scepter") == 3 then
        wesnoth.wml_actions.message {speaker="narrator", message="Steam rises from the water."}
        wesnoth.set_variable("puzzle_water_fire.scepter",4)
    elseif wesnoth.get_variable("puzzle_water_fire.scepter") == 0 then
        wesnoth.wml_actions.message {speaker="narrator", message="Something is missing."}
    end
end

function wesnoth.wml_actions.puzzle_water_fire_grain_hex(cfg)
    if wesnoth.get_variable("puzzle_water_fire.grain") == 0 then
        wesnoth.wml_actions.message {speaker="narrator", message="You picked up some grain."}
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

        local experience=wesnoth.get_variable("large_puzzle_exp")
        wesnoth.wml_actions.add_exp {experience=experience,{"filter",{id="Yumi"}}}

        wesnoth.set_variable("puzzle_water_fire.scepter",5)
        wesnoth.set_variable("puzzle_water_fire.grain",2)
        wesnoth.set_variable("puzzle_water_fire.complete",1)
    end
end

function wesnoth.wml_actions.clear_all_vars(cfg)
    wesnoth.set_variable("large_puzzle_exp",nil)
    wesnoth.set_variable("small_puzzle_exp",nil)

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
--]]