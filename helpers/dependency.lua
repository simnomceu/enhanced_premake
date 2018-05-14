#!lua

-- dependency.lua

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

Dependency = { id = "Dependency" }
Dependency.__index = Dependency

function Dependency:new(obj)
    if obj then
        assert(type(obj) == "userdata" and obj.id == "Dependency", "Dependency:new expects a prototype of Dependency.")
    end

    local this = obj or {
        _name = "",
        _pathToScript = "",
        _pathToLib = ""
    }
    setmetatable(this, Dependency)
    self.__index = self

    return this
end

function Dependency:setName(name)
    assert(type(name) == "string", "Dependency:setName expects a string parameter.")
    self._name = name
end

function Dependency:getName()
    return self._name
end

function Dependency:setPathToScript(path)
    assert(type(path) == "string", "Dependency:setPathToScript expects a string parameter.")
    self._pathToScript = path
end

function Dependency:getPathToScript()
    return self._pathToScript
end

function Dependency:setPathToLib(path)
    assert(type(path) == "string", "Dependency:setPathToLib expects a string parameter.")
    self._pathToLib = path
end

function Dependency:getPathToLib()
    return self._pathToLib
end
