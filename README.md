# EnhancedPremake

## Introduction
EnhancedPremake is a module for [Premake5]{https://premake.github.io/}. It create a solution with the following folder-tree:
```
root\
	|- build\
    	|- premake5.lua
        |- ...
	|- include\
	|- src\
	|- bin\
	|- obj\
```
The solution built is only for C++17 project, with some specific settings. Have a look into the code to see what are exactly these settings.

## Using EnhancedPremake
### Including EnhancedPremake to your solution
There is two ways to include it to your solution: the basic one and the embedded one. For the embedded including, a documentation from premake is available [HERE](https://github.com/premake/premake-core/wiki/Embedding-Modules).
For a more classic including, you can just put the EnhancedProject in a folder close to the premake5 binary. For example, for windows it could look like:
```
build\
	|- modules\
		|- enhanced_premake\
    		|- ....
	|- premake5.exe
```
### Creating a premake solution
The basic code to create a premake solution using EnhancedPremake is the following:
```lua
#!lua

-- premake5.lua
local EnhancedPremake = require "modules.enhanced_premake.enhanced_premake"

EnhancedPremake.load("<my_solution>.lua")
```

Then, the configuration file that describes your solution should inherit from the solution class:
```lua
#!lua

-- v.lua

local resource = Solution:new()

resource:setName("my_solution")
....

return resource
```

Projects, options, or external dependencies are working exactly like the solution, using respectively, Project, Option, and Dependency classes.
Paths to those configuration files has to be set in the solution file.

## Contributing to EnhancedPremake

Bugs can be reported on the Framagit issue tracker here: [(https://img.shields.io/badge/Framagit-Open%20an%20issue-blue.svg)](https://framagit.org/simnomce_u/enhanced_premake/issues)

## Authors
* IsilinBN

## Copyright and Licensing
EnhancedPremake is delivered under the [GNU-GPLv3](https://www.gnu.org/licenses/gpl-3.0.fr.html).

EnhancedPremake is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
