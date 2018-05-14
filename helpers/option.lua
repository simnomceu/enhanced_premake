#!lua

-- option.lua

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

Pair = { id = "Pair" }
Pair.__index = Pair

function Pair:new(obj)
    if obj then
        assert(type(obj) == "userdata" and obj.id == "Pair", "Pair:new expects a prototype of Pair.")
    end

    local this = obj or {
        _value = "",
        _description = ""
    }
    setmetatable(this, Pair)
    self.__index = self

    return this
end

function Pair:make(value, description)
    assert(type(value) == "string", "First parameter of Pair:make has to be a string.")
    assert(type(description) == "string", "Second parameter of Pair:make has to be a string.")

    local obj = Pair:new()
    obj._value = value
    obj._description = description

    return obj
end



Option = { id = "Option" }
Option.__index = Option

function Option:new(obj)
    if obj then
        assert(type(obj) == "userdata" and obj.id == "Option", "Option:new expects a prototype of Option.")
    end

    local this = obj or {
        _name = "",
        _trigger = "",
        _value = "",
        _description = "",
        _default = "",
        _allowed = {}
    }
    setmetatable(this, Option)
    self.__index = self

    return this
end

function Option:setName(name)
    assert(type(name) == "string", "Option:setName expects a string parameter.")
    self._name = name
end

function Option:getName()
    return self._name
end

function Option:setTrigger(trigger)
    assert(type(trigger) == "string", "Option:setTrigger expects a string parameter.")
    self._trigger = trigger
end

function Option:getTrigger()
    return self._trigger
end

function Option:setValue(value)
    assert(type(value) == "string", "Option:setValue expects a string parameter.")
    self._value = trigger
end

function Option:getValue()
    return self._value
end

function Option:setDescription(description)
    assert(type(description) == "string", "Option:setDescription expects a string parameter.")
    self._description = description
end

function Option:getDescription()
    return self._description
end

function Option:setDefault(default)
    assert(type(default) == "string", "Option:setDefault expects a string parameter.")
    self._default = default
end

function Option:getDefault()
    return self._default
end

function Option:addAllowed(pair)
    assert(type(pair) == "table" and pair.id == "Pair", "Option:addAllowed expects a Pair parameter.")
    self._allowed = Table.insertPair(self._allowed, pair)
end

function Option:getAllowed()
    return self._allowed
end
