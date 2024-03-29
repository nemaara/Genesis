---
-- Lua WML actions taken from the Wesnoth Lua Pack add-on.
---

--! [store_shroud]
--! melinath

-- Given side= and variable=, stores that side's shroud data in that variable
-- Example:
-- [store_shroud]
--     side=1
--     variable=shroud_data
-- [/store_shroud]

function wesnoth.wml_actions.store_shroud(cfg)
	local side = wesnoth.get_sides( cfg )[1] or wml.error("No matching side found in [store_shroud]")
	local variable = cfg.variable or wml.error("Missing required variable= attribute in [store_shroud].")
	local current_shroud = side.__cfg.shroud_data
	wesnoth.set_variable(variable, current_shroud)
end

--! [set_shroud]
--! melinath

-- Given shroud data, removes the shroud in the marked places on the map.
-- Example:
-- [set_shroud]
--     side=1
--     shroud_data=$shroud_data # stored with store_shroud, for example!
-- [/set_shroud]

function wesnoth.wml_actions.set_shroud(cfg)
	local side = wesnoth.get_sides( cfg )[1] or wml.error("No matching side found in [set_shroud]")
	local team_number = side.side
	local shroud_data = cfg.shroud_data or wml.error("Missing required shroud_data= attribute in [set_shroud]")

	if shroud_data == nil then wml.error("[set_shroud] was passed an empty shroud string")
	elseif string.sub(shroud_data,1,1) ~= "|" then wml.error("[set_shroud] was passed an invalid shroud string")
	else
		-- yes, I prefer long variable names. I think that they make the code more understandable. E_H.
		local width, height, border = wesnoth.get_map_size()
		local shroud_x = ( 1 - border )

		-- my variation: to make code faster (hopefully), and avoid multiple callings of remove_shroud
		-- I append every location to a table, convert them as strings, and invoke remove_shroud
		-- only once, with these lists of locations. E_H.
		local rows, columns = {}, {}

		for row in string.gmatch ( shroud_data, "|(%d*)" ) do
			local shroud_y = ( 1 - border )
			for column in string.gmatch ( row, "%d" ) do
				if column == "1" then
					-- I tend to confuse them, so better specify: x are columns and y are rows. E_H.
					table.insert( rows, shroud_y ) -- appending them to the tables.
					table.insert( columns, shroud_x )
				end
				shroud_y = shroud_y + 1
			end
			shroud_x = shroud_x + 1
		end

		-- converting them to strings with separator
		local locs_x = table.concat( columns, "," )
		local locs_y = table.concat( rows, "," )

		if not wesnoth.sides[team_number].__cfg.shroud then
			wesnoth.wml_actions.modify_side { side = team_number, shroud = true } -- in case that shroud was removed by modify_side
		end

		wesnoth.wml_actions.place_shroud { side = team_number, x = string.format("%d-%d", 1 - border, height + border ), y = string.format("%d-%d", 1 - border, width + border ) }
		wesnoth.wml_actions.remove_shroud { side = team_number, x = locs_x, y = locs_y }
	end
end

--! [save_map],[load_map]
--! silene

--The [save_map] and [load_map] tags store and retrieve map data in a WML variable;
-- useful for dealing with dynamically modified yet persistent maps. They take a
-- variable=.
-- Example:
-- [save_map]
--     variable=saved_map[1].map
-- [/save_map]
-- [load_map]
--     variable=saved_map[1].map
-- [/load_map]

function wesnoth.wml_actions.save_map(cfg)
	local variable = cfg.variable or wml.error "[save_map] missing required variable= attribute"
	local width, height, border = wesnoth.get_map_size()
	local t = {} -- not table, to avoid overriding the table library!

	for y = 1 - border, height + border do
		local row = {}

		for x = 1 - border, width + border do
			row[ x + border ] = wesnoth.get_terrain ( x, y )
		end

		t[ y + border ] = table.concat ( row, ',' )
	end

	local s = table.concat( t, '\n' ) -- not string, to avoid overriding the string library!
	wesnoth.set_variable ( variable, string.format ( "border_size=%d\nusage=map\n\n%s", border, s ) )
end

function wesnoth.wml_actions.load_map(cfg)
	local variable = cfg.variable or wml.error "[load_map] missing required variable= attribute"
	wesnoth.wml_actions.replace_map { map = wesnoth.get_variable ( variable ), expand = true, shrink = true }
end
