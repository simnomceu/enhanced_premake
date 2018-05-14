#!lua

-- configuration_specific.lua

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

ConfigurationSpecific = { id = "ConfigurationSpecific" }
ConfigurationSpecific.__index = ConfigurationSpecific

function ConfigurationSpecific:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "ConfigurationSpecific", "ConfigurationSpecific:new expects a prototype of Project.")
    end

    local this = obj or {
        _data = {}
    }
    setmetatable(this, ConfigurationSpecific)
    self.__index = self

    return this
end

function ConfigurationSpecific:addEntriesIn(entries, table1)
    assert(type(entries) == "table", "ConfigurationSpecific:addEntriesIn expects a table as first parameter.")
    assert(type(table1) == "string", "ConfigurationSpecific:addEntriesIn expects a string as second parameter.")

    if (Table.hasKey(self._data, table1)) then
        self._data[table1] = Table.append(self._data[table1], entries)
    else
        self._data[table1] = entries
    end
end

function ConfigurationSpecific:getEntriesFrom(table1)
    assert(type(table1) == "string", "ConfigurationSpecific:getEntriesFrom expects a string parameter")

    return self._data[table1]
end
