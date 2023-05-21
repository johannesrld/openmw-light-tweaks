-- Copyright (c) 2023 Johannes Richard Levi Dickenson
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

local types = require("openmw.types")
local world = require("openmw.world")
local blacklist: {string:boolean} = {
   ["cavern of the incarnate"] = true,
}
return {
  engineHandlers = {
		onInit = function()
			for _, cell in ipairs(world.cells) do
        if blacklist[cell.name] then goto cont end
				for _, light in ipairs(cell:getAll(types.Light)) do
					local light_record = types.Light.record(light)
					if ((light_record.model == "meshes\\" or light_record.model == "meshes\\" and light_record.id:sub(1, 5) == "dark_")) and light.enabled ~= false then
						light.enabled = false
					end
				end
        ::cont::
			end
		end
	}
}
