#!lua

-- premake5.lua

-- This file is part of enhanced_premake, a module for Premake5.
-- Copyright (C) 2018  Pierre Casati (@IsilinBN)
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local p = premake

p.modules.enhanced_premake = {}
p.path = p.path .. ";" .. path.getabsolute(os.getcwd())

local module = p.modules.enhanced_premake
module._VERSION = p._VERSION

module.load = function(path)
    assert(type(path) == "string", "EnhancedPremake.load expects a string parameter.")

    local solutionBuilder = SolutionBuilder:new()
    solutionBuilder:build(path)
end

include("helpers/configuration_specific.lua")
include("helpers/dependency.lua")
include("helpers/file_loader.lua")
include("helpers/option.lua")
include("helpers/platform_specific.lua")
include("helpers/project.lua")
include("helpers/solution.lua")
include("helpers/table.lua")

include("core/dependency_loader.lua")
include("core/option_loader.lua")
include("core/project_loader.lua")
include("core/solution_builder.lua")

return module
