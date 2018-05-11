#!lua

-- option_loader.lua

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

local Option = require "scripts.helpers.option"

local OptionLoader = {options = {}}

function OptionLoader:loadOptions()
    local files = os.matchfiles("scripts/options/*.lua")
    for key,file in pairs(files) do
        local name = string.gsub(string.sub(file, 1, -5), '/', '.')
        local f = require(name)
        if not f then
            print("Error while loading "..file)
        else
            OptionLoader:processOption(f)
        end
    end
end

function OptionLoader:processOption(option)
    local opt = {
        trigger = option:getTrigger(),
        description = option:getDescription(),
    }

    if option:getValue() ~= "" then
        opt.value = option:getValue()
    end

    if option:getDefault() ~= "" then
        opt.value = option:getDefault()
    end

    if option:getAllowed() ~= {} then
        opt.allowed = option:getAllowed()
    end

    newoption(opt)
end


return OptionLoader
