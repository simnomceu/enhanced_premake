#!lua

-- loader.lua

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

local Loader = { id = "Loader"}
Loader.__index = Loader

function Loader:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "Loader", "Loader:new expects a prototype of Loader.")
    end

    local this = obj or {
        _pattern = {},
        _dataPath = "",
        _data = {},
    }
    setmetatable(this, Loader)
    self.__index = self

    return this
end

function Loader:setPattern(pattern)
    assert(type(name) == "userdata", "Loader:setPattern expects an object parameter.")
    self._pattern = pattern
end

function Loader:getPattern()
    return self._pattern
end

function Loader:setDataPath(path)
    assert(type(name) == "string", "Loader:setDataPath expects a string parameter.")
    self._dataPath = path
end

function Loader:getDataPath()
    return self._dataPath
end

function Loader:addData(key, data)
    assert(type(data) == type(self._pattern), "Loader:addData expects an object parameter following the data pattern set previously.")
    Loader._data[key] = data
end

function Loader:getData()
    return self._data
end

function Loader:loadAll()
    local files = os.matchfiles(self._dataPath.."/*.lua")
    for key,file in pairs(files) do
        local name = string.gsub(string.sub(file, 1, -5), '/', '.')
        local f = require(name)
        if not f then
            print("Error while loading "..file)
        else
            Loader._data[string.lower(f:getName())] = f
        end
    end
end

function Loader:processAll()
    for key,it in pairs(self._data) do
        self:process(it)
    end
end

function Loader:process()
end

return Loader
