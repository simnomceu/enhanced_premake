#!lua

-- dependency_loader.lua

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

local Dependency = require "helpers.dependency"

local DependencyLoader = {dependencies = {}}

function DependencyLoader:loadDependencies()
    local files = os.matchfiles("scripts/dependencies/*.lua")
    for key,file in pairs(files) do
        local name = string.gsub(string.sub(file, 1, -5), '/', '.')
        local f = require(name)
        if not f then
            print("Error while loading "..file)
        else
            DependencyLoader.dependencies[string.lower(f:getName())] = f
        end
    end
end

function DependencyLoader:process()
    for key,proj in pairs(DependencyLoader.dependencies) do
        DependencyLoader:processDependency(proj)
    end
end

function DependencyLoader:processDependency(dependency)
    dofile(dependency:getPathToScript())
    libdirs{ dependecy.getPathToLib() }
end


return DependencyLoader
