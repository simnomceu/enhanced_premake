#!lua

-- project.lua

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

Project = { id = "Project"}
Project.__index = Project

function Project:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "Project", "Project:new expects a prototype of Project.")
    end

    local this = obj or {
        _name = "",
        _type = "",
        _dependencies = {},
        _extlibs = PlatformSpecific:new(),
        _linkOptions = PlatformSpecific:new(),
        _preprocessors = PlatformSpecific:new(),
        _additionalSources = {},
        _additionalHeaders = {},
        _pch = true
    }
    setmetatable(this, Project)
    self.__index = self

    return this
end

function Project:setName(name)
    assert(type(name) == "string", "Project:setName expects a string parameter.")
    self._name = name
end

function Project:getName()
    return self._name
end

function Project:setType(projectType)
    assert(type(projectType) == "string", "Project:setType expects a string parameter.")
    assert(projectType == "Lib" or projectType == "ConsoleApp" or projectType == "WindowedApp" or projectType == "Test", "A project type expects to be one of the following: 'ConsoleApp', 'WindowedApp', 'Lib', 'Test'.")
    self._type = projectType
end

function Project:getType()
    return self._type
end

function Project:addDependencies(dependencies)
    assert(type(dependencies) == "table", "Project:addDependencies expects a table parameter.")
    self._dependencies = Table.append(self._dependencies, dependencies)
end

function Project:getDependencies()
    return self._dependencies
end

function Project:addExtlibs(target, extlibs)
    assert(type(target) == "string", "Project:addExtlibs expects a string parameter as first parameter.")
    assert(target == "Windows" or target == "Linux" or target == "MacOSX" or target == "Common", "Extlibs can only be for 'Common', 'Windows', 'Linux', or 'MacOSX'.")
    assert(type(extlibs) == "table", "Project:addExtlibs expects a table parameter as second parameter.")
    if target == "Common" then
        self._extlibs:addToCommon(extlibs)
    elseif target == "Linux" then
        self._extlibs:addToUnix(extlibs)
    elseif target == "Windows" then
        self._extlibs:addToWindows(extlibs)
    elseif target == "MacOSX" then
        self._preprocessors:addToMacOSX(extlibs)
    end
end

function Project:getExtlibs()
    return self._extlibs:getAll()
end

function Project:addLinkOptions(target, linkOptions)
    assert(type(target) == "string", "Project:addLinkOptions expects a string parameter as first parameter.")
    assert(target == "Windows" or target == "Linux" or target == "MacOSX" or target == "Common", "linkOption can only be for 'Common', 'Windows', 'Linux', or 'MacOSX'.")
    assert(type(linkOptions) == "table", "Project:addLinkOptions expects a table parameter as second parameter.")
    if target == "Common" then
        self._linkOptions:addToCommon(linkOptions)
    elseif target == "Linux" then
        self._linkOptions:addToUnix(linkOptions)
    elseif target == "Windows" then
        self._linkOptions:addToWindows(linkOptions)
    elseif target == "MacOSX" then
        self._preprocessors:addToMacOSX(linkOptions)
    end
end

function Project:getLinkOptions()
    return self._linkOptions:getAll()
end

function Project:addPreprocessors(target, preprocessors)
    assert(type(target) == "string", "Project:addPreprocessors expects a string parameter as first parameter.")
    assert(target == "Windows" or target == "Linux" or target == "MacOSX" or target == "Common", "preprocessors can only be for 'Common', 'Windows', 'Linux', or 'MacOSX'.")
    assert(type(preprocessors) == "table", "Project:addPreprocessors expects a table parameter as second parameter.")
    if target == "Common" then
        self._preprocessors:addToCommon(preprocessors)
    elseif target == "Linux" then
        self._preprocessors:addToUnix(preprocessors)
    elseif target == "Windows" then
        self._preprocessors:addToWindows(preprocessors)
    elseif target == "MacOSX" then
        self._preprocessors:addToMacOSX(preprocessors)
    end
end

function Project:getPreprocessors()
    return self._preprocessors:getAll()
end

function Project:addAdditionalSources(sources)
    assert(type(sources) == "table", "Project:addAdditionalSources expects a table parameter.")
    self._additionalSources = Table.append(self._additionalSources, sources)
end

function Project:getAdditionalSources()
    return self._additionalSources
end

function Project:addAdditionalHeaders(headers)
    assert(type(headers) == "table", "Project:addAdditionalHeaders expects a table parameter.")
    self._additionalHeaders = Table.append(self._additionalHeaders, headers)
end

function Project:getAdditionalHeaders()
    return self._additionalHeaders
end

function Project:enablePCH(enabled)
    assert(type(enabled) == "boolean", "Project:enablePCH expects a boolean parameter.")
    self._pch = enabled
end

function Project:isPCHEnabled()
    return self._pch
end
