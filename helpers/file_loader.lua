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

FileLoader = { id = "FileLoader" }
FileLoader.__index = FileLoader

function FileLoader:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "FileLoader", "FileLoader:new expects a prototype of FileLoader.")
    end

    local this = obj or {
    }

    setmetatable(this, FileLoader)
    self.__index = self

    return this
end

function FileLoader:getFilesFrom(path)
    assert(type(path) == "string", "FileLoader:getFilesFrom expects a string parameter.")
    assert(os.isdir(path), path.." is not an existing directory.")
    return os.matchfiles(path.."/**.lua")
end

function FileLoader:load(filename)
    assert(type(filename) == "string", "FileLoader:load expects a string parameter.")
    assert(os.isfile(filename), filename.." is not an existing file.")
    local name
    if string.sub(filename, -3) == "lua" then
        name = string.gsub(string.sub(filename, 1, -5), '/', '.')
    else
        name = string.gsub(filename, '/', '.')
    end
    local resource = require(name)
    assert(type(resource._name) == "string", name.." does not contain any resource.")
    return resource
end
