#!lua

-- solution_builder.lua

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

local SolutionBuilder = {}

function SolutionBuilder.build()
    workspace "eROMA"
        location("./" .. _ACTION)
        includedirs { "../extlibs/EdenCraft/extlibs/OpenGL-Registry/api", "../extlibs/EdenCraft/include", "../include", "../extlibs" }
        libdirs { "../extlibs/EdenCraft/bin/%{cfg.system}/%{cfg.buildcfg}/" }
        configurations {"Debug", "Release"}
        platforms {"x86", "x64"}
    	warnings 'Extra'
        language "C++"
    	cppdialect 'C++17'

        filter {"platforms:x86"}
            architecture "x86"

        filter {"platforms:x64"}
            architecture "x86_64"

        filter {"action:vs*"}
            buildoptions {"/MP"}

        filter {"action:gmake"}
            buildoptions {"-pedantic"}

        filter {"action:vs*", "platforms:x86"}

        filter {"action:vs*", "platforms:x64"}

        filter {}

        filter {"configurations:Debug"}
            symbols "Default"
            warnings "Extra"
            flags { "FatalWarnings" }

        filter {"configurations:Release"}
    		optimize "On"
    		symbols "Off"
            warnings "Off"

        filter {}
end

return SolutionBuilder
