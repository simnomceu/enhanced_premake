#!lua

-- project_loader.lua

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

ProjectLoader = { id = "ProjectLoader" }
ProjectLoader.__index = ProjectLoader

function ProjectLoader:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "ProjectLoader", "ProjectLoader:new expects a prototype of ProjectLoader.")
    end

    local this = obj or {
        _data = {},
        _external = {}
    }
    setmetatable(this, ProjectLoader)
    self.__index = self

    return this
end

function ProjectLoader:load(path, external)
    assert(type(path) == "string", "ProjectLoader:process expects a string parameter.")
    assert(type(external) == "boolean", "ProjectLoader:process expects a boolean parameter.")

    local loader = FileLoader:new()
    local proj = loader:load(path)
    if (not external) then
        self._data[proj:getName()] = proj
    else
        self._external[proj:getName()] = proj
    end
    return proj:getName()
end

function ProjectLoader:process(path)
    assert(type(path) == "string", "ProjectLoader:process expects a string parameter.")

    local obj = self._data[path]

    local includePath, srcPath
    local projectName = string.lower(obj:getName())

    if obj:getType() == "Lib" then
        includePath = "../include/"..projectName
        srcPath = "../src/"..projectName
    elseif obj:getType() == "ConsoleApp" then
        includePath = "../examples/"..projectName
        srcPath = "../examples/"..projectName
	else
		includePath = "../"..projectName
		srcPath = "../"..projectName
		obj:setType("ConsoleApp")
    end

    project(obj:getName())
        if obj:getType() == "Lib" then
            filter {"configurations:*Static"}
                kind "StaticLib"

            filter {"configurations:*Shared"}
                kind "SharedLib"
                defines {"ECE_"..projectName.."_SHARED"}

            filter {"configurations:DebugStatic"}
                targetsuffix("-s-d")

            filter {"configurations:DebugShared"}
                targetsuffix("-d")

            filter {"configurations:ReleaseStatic"}
                targetsuffix("-s")

            filter {}

            pic("On")
        else
            kind(obj:getType())
        end
        location("./" .. _ACTION)

        if obj:getType() == "ConsoleApp" then
            includedirs(includePath)
            includedirs(obj:getAdditionalHeaders())
        end

        objdir "../obj/%{cfg.system}"
        targetdir "../bin/%{cfg.system}"

        if obj:isPCHEnabled() then
            filter { "kind:*Lib" }
                pchheader(obj:getName().."/pch.hpp")
            filter { "kind:*Lib", "action:vs*" }
                pchsource(srcPath.."/pch.cpp")
            filter {}
        end

        files {
            includePath.."/**.inl",
            includePath.."/**.hpp",
            includePath.."/**.h",
            srcPath.."/**.cpp",
            srcPath.."/**.c",
			srcPath.."/**.frag",
			srcPath.."/**.vert",
			srcPath.."/**.geom",
        }

        files (obj:getAdditionalHeaders())
        files (obj:getAdditionalSources())

		filter { "system:windows", "files:**/cocoa/** or **/x11/**" }
			flags {"ExcludeFromBuild"}
		filter { "system:linux", "files:**/cocoa/** or **/win32/**" }
			flags {"ExcludeFromBuild"}
		filter { "system:macosx", "files:**/x11/** or **/win32/**" }
			flags {"ExcludeFromBuild"}

        filter { "system:linux" }
            linkoptions { "-fvisibility=hidden -fvisibility-inlines-hidden"}
            links("stdc++fs")

		filter {}

        links(self:GetDependencies(obj))

        linkoptions { obj:getLinkOptions() }
        defines { obj:getPreprocessors() }
        defines { "ECE_"..projectName.."_BUILD"}
end

function ProjectLoader:GetDependencies(proj)
    local tmpDep = proj:getExtlibs()
    tmpDep = Table.append(tmpDep, proj:getDependencies())

    for key,dependency in pairs(proj:getDependencies()) do
        if Table.hasKey(self._data, dependency) == true then
            local subdependencies = self:GetDependencies(self._data[dependency])
            for subkey,subdependency in pairs(subdependencies) do
                if not Table.hasValue(tmpDep, subdependency) then
                    table.insert(tmpDep, subdependency)
                end
            end
        elseif Table.hasKey(self._external, dependency) == true then
            local subdependencies = self:GetDependencies(self._external[dependency])
            for subkey,subdependency in pairs(subdependencies) do
                if not Table.hasValue(tmpDep, subdependency) then
                    table.insert(tmpDep, subdependency)
                end
            end
        end
    end

    return tmpDep
end
