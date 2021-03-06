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

OptionLoader = { id = "OptionLoader" }
OptionLoader.__index = OptionLoader

function OptionLoader:new(obj)
    if(obj) then
        assert(type(obj) == "userdata" and obj.id == "OptionLoader", "OptionLoader:new expects a prototype of OptionLoader.")
    end


    local this = obj or {
    }
    setmetatable(this, OptionLoader)
    self.__index = self

    return this
end

function OptionLoader:process(path)
    assert(type(path) == "string", "OptionLoader:process expects a string parameter.")

    local loader = FileLoader:new()
    local obj = loader:load(path)

    local option = {
        trigger = obj:getTrigger(),
        description = obj:getDescription(),
    }

    if obj:getValue() ~= "" then
        option.value = obj:getValue()
    end

    if obj:getDefault() ~= "" then
        option.default = obj:getDefault()
    end

    if obj:getAllowed() ~= {} then
        option.allowed = obj:getAllowed()
    end

    newoption(option)
end
