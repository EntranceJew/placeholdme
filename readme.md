# placeholdme
A love lib for generating a temporary sprite sheet.

Use it anywhere you would usually reference an asset. You don't need to wait to have visual assets to start spinning out some code.

# Parameters
* **width**  _required_ `number/table` If a number: the width of a single frame of the spritesheet. If a table: it should contain key/value pairs for the rest of the parameters.
* **height** _required_ `number` The height of a single frame of the spritesheet.
* **columns** `number` The number of horizontal frames the spirtesheet should have.
* **rows** `number` The number of vertical frames the spritesheet should have.
* **sprintstring** `string` A formatted string with named parameters. [See: Named Parameters with Formatting Codes](http://lua-users.org/wiki/StringInterpolation) for more information. Provided parameters are:
	* `column` The current horizontal column number of the spritesheet that the image is in.
	* `row` The current vertical row number of the spritesheet that the image is in.
	* `width` The width of the individual frame of the spritesheet.
	* `height` The height of the individual frame of the spritesheet.
* **sprintvars** `table/string` If it is a table: named elements that will be merged with the above provided vars. This can be used to insert custom elements into the sprintstring. If it is a string: it will replace the default "placeholder" line in the example string, this can be used to simply insert your info before the frame data.
* **fontcolor** `colortable` The color of the font to use when drawing the text.
* **fillcolor** `colortable` The color to make the placeholder background.

# Simple Example
```lua
-- drop it in your project
placeholdme = require 'placeholdme'

function love.load()
	local imageSource = placeholdme(100,50,3,4)
	-- instead of 'image/path/here.png', just put a call to placeholdme
	placeholder = love.graphics.newImage(imageSource)
end

function love.draw()
	-- draw it like you would anything else
	love.graphics.draw(placeholder, 0, 0)
end
```
Output:

![a bunch of placeholders](http://i.imgur.com/ZHfulYb.png)

# Advanced Usage
```lua
-- drop it in your project
placeholdme = require 'placeholdme'

local parameters = {
	width = 100,
	height = 200,
	columns = 3,
	fillcolor = {58, 179, 54, 255}
}

-- set up what we're going to 
local values = {
	'Enemy\nidle',
	'Enemy\nwalk-up',
	'Enemy\nattack',
}

for _, pose in pairs(values) do
	-- don't provide parameters we're not going to use
	-- see: http://www.lua.org/pil/5.3.html
	local idata = placeholdme{
		width = 100,
		height = 200,
		columns = 3,
		fillcolor = {58, 179, 54, 255},
		sprintvars = pose
	}
	
	-- save the images to disk to prevent generating them again
	idata:encode(pose:gsub("\n", "_")..'.png')
end
```

Output: [imgur link](http://imgur.com/a/hM2nC)

![Enemy_attack.png](http://i.imgur.com/oeMaWc4.png)
![Enemy_idle.png](http://i.imgur.com/plWjq93.png)
![Enemy_walk-up.png](http://i.imgur.com/ABpWZGf.png)