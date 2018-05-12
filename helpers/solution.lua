#!lua

-- solution.lua

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

local Table = require "helpers.table"

local Solution = { id = "Solution"}
Solution.__index = Solution

function Solution:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "Solution", "Solution:new expects a prototype of Solution.")
    end

    local this = obj or {
        _name = "",
        _headerDir = {},
        _libraryDir = {},
        _projectDir = "",
    }
    setmetatable(this, Solution)
    self.__index = self

    return this
end

function Solution:setName(name)
    assert(type(name) == "string", "Solution:setName expects a string parameter.")
    self._name = name
end

function Solution:getName()
    return self._name
end

function Solution:addHeaderDir(dir)
    assert(type(dir) == "string", "Solution:addHeaderDir expects a string parameter.")
    self._headerDir = Table.append(self._headerDir, dir)
end

function Solution:getHeaderDir()
    return self._headerDir
end

function Solution:addLibraryDir(dir)
    assert(type(dir) == "string", "Solution:addLibraryDir expects a string parameter.")
    self._libraryDir = Table.append(self._libraryDir, dir)
end

function Solution:getLibraryDir()
    return self._libraryDir
end

function Solution:setProjectDir(path)
    assert(type(path) == "string", "Solution:setProjectDir expects a string parameter.")
    self._projectDir = path
end

function Solution:getProjectDir()
    return self._projectDir
end

return Solution
