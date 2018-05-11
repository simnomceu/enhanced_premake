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

local Table = require "scripts.helpers.table"
local PlatformSpecific = require "scripts.helpers.platform_specific"
local Dependency = require "scripts.helpers.dependency"
local Project = require "scripts.helpers.project"
-- local Pair, Option = require "scripts.helpers.option"

local SolutionBuilder = require "scripts.solution_builder"
local DependencyLoader = require "scripts.dependency_loader"
local ProjectLoader = require "scripts.project_loader"
--local OptionLoader = require "scripts.option_loader"

print("Load CLI options ...")
--OptionLoader:loadOptions()
newoption {
    trigger = "libs",
    value = "Type",
    description = "Choose to compile static or shared libraries for the engine",
    default = "static",
    allowed = {
        { "static", "Static libraries" },
        { "shared", "Shared libraries" }
    }
}

print("Start building solution ...")
SolutionBuilder.build()
print("Start loading dependencies ...")
DependencyLoader:loadDependencies()
print("Start loading projects ...")
ProjectLoader:loadProjects()
print("Start processing projects ...")
ProjectLoader:process()
print("Building solution completed ...")
