#!lua

-- table.lua

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

Table = {}

function Table.hasKey(tab, key)
    assert(type(tab) == "table", "Table.hasKey expects a table as first parameter.")
    for tmpKey, val in pairs(tab) do
        if tmpKey == key then
            return true
        end
    end
    return false
end

function Table.hasValue (tab, value)
    assert(type(tab) == "table", "Table.hasValue expects a table as first parameter.")
    for key, val in pairs(tab) do
        if val == value then
            return true
        end
    end
    return false
end

function Table.append (table1, table2)
    assert(type(table1) == "table", "Table.append expects a table as first parameter.")
    assert(type(table2) == "table", "Table.append expects a table as second parameter.")
    result = table1
    for key, value in pairs(table2) do
        if type(key) == "number" then
            table.insert(result, value)
        elseif not result[key] then
            result[key] = value
        end
    end
    return result
end

function Table.insertPair(table1, pair)
    assert(type(table) == "table", "Table.append expects a table as first parameter.")
    assert(type(pair) == "table" and pair.id == "Pair", "Table.append expects a table as second parameter.")
    result = table1

    table.insert(result, {pair._value, pair._description})

    return result
end

function Table.size(tab)
    assert(type(tab) == "table", "Table.size expects a table parameter.")
    local count = 0
    for key, val in pairs(tab) do
        print(val)
        count = count + 1
    end
    return count
end

function Table.print(tab)
    assert(type(tab) == "table", "Table.print expects a table parameter.")
    for key,val in pairs(tab) do
        if type(val) == "table" then
            print(key,": ")
            Table.print(val)
        else
            print(key, ": ", val)
        end
    end
end
