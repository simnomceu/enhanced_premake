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

Solution = { id = "Solution"}
Solution.__index = Solution

function Solution:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "Solution", "Solution:new expects a prototype of Solution.")
    end

    local this = obj or {
        _name = "",
        _headerDir = {},
        _libraryDir = {},
        _projectsDir = "",
        _optionsDir = "",
        _dependenciesDirs = {},
        _preprocessors = ConfigurationSpecific:new(),
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
    assert(type(dir) == "table", "Solution:addHeaderDir expects a table parameter.")
    self._headerDir = Table.append(self._headerDir, dir)
end

function Solution:getHeaderDir()
    return self._headerDir
end

function Solution:addLibraryDir(dir)
    assert(type(dir) == "table", "Solution:addLibraryDir expects a table parameter.")
    self._libraryDir = Table.append(self._libraryDir, dir)
end

function Solution:getLibraryDir()
    return self._libraryDir
end

function Solution:setProjectsDir(path)
    assert(type(path) == "string", "Solution:setProjectsDir expects a string parameter.")
    self._projectsDir = path
end

function Solution:getProjectsDir()
    return self._projectsDir
end

function Solution:setOptionsDir(path)
    assert(type(path) == "string", "Solution:setOptionsDir expects a string parameter.")
    self._optionsDir = path
end

function Solution:getOptionsDir()
    return self._optionsDir
end

function Solution:addDependenciesDirs(path)
    assert(type(path) == "table", "Solution:addDependenciesDirs expects a table parameter.")
    self._dependenciesDirs = Table.append(self._dependenciesDirs, path)
end

function Solution:getDependenciesDirs()
    return self._dependenciesDirs
end

function Solution:addPreprocessorsIn(entries, table1)
    assert(type(entries) == "table", "Project:addPreprocessorsIn expects a table as first parameter.")
    assert(type(table1) == "string", "Project:addPreprocessorsIn expects a string as second parameter.")
    self._preprocessors:addEntriesIn(entries, table1)
end

function Solution:getPreprocessorsFrom(table1)
    assert(type(table1) == "string", "Project:getPreprocessorsFrom expects a string parameter")
    return self._preprocessors:getEntriesFrom(table1)
end
