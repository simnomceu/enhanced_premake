#!lua

-- platform_specific.lua

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

local PlatformSpecific = { id = "PlatformSpecific"}
PlatformSpecific.__index = PlatformSpecific

function PlatformSpecific:new(obj)
    if obj then
        assert(type(obj) == "userdata" and obj.id == "PlatformSpecific", "PlatformSpecific:new expects a prototype of PlatformSpecific.")
    end

    local this = obj or {
        _common = {},
        _unix = {},
        _windows = {},
        _macosx = {}
    }
    setmetatable(this, PlatformSpecific)
    self.__index = self

    return this
end

function PlatformSpecific:addToCommon(list)
    assert(type(list) == "table", "PlatformSpecific:addToCommon expects a table.")
    self._common = Table.append(self._common, list)
end

function PlatformSpecific:addToUnix(list)
    assert(type(list) == "table", "PlatformSpecific:addToUnix expects a table.")
    self._unix = Table.append(self._unix, list)
end

function PlatformSpecific:addToWindows(list)
    assert(type(list) == "table", "PlatformSpecific:addToWindows expects a table.")
    self._windows = Table.append(self._windows, list)
end

function PlatformSpecific:addToMacOSX(list)
    assert(type(list) == "table", "PlatformSpecific:addToMacOSX expects a table.")
    self._macosx = Table.append(self._macosx, list)
end

function PlatformSpecific:getAll()
    local result = self._common
    if os.target() == "windows" then
        result = Table.append(result, self._windows)
    elseif os.target() == "linux" then
        result = Table.append(result, self._unix)
    elseif os.target() == "macosx" then
        result = Table.append(result, self._macosx)
    end
    return result
end

return PlatformSpecific
