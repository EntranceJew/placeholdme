# placeholdme
A love lib for generating a temporary sprite sheet.

Use it anywhere you would usually reference an asset. You don't need to wait to have visual assets to start spinning out some code.

# Parameters
* `width` The width of a single frame of the spritesheet.
* `height` The height of a single frame of the spritesheet.
* `columns` The number of horizontal frames the spirtesheet should have.
* `rows` The number of vertical frames the spritesheet should have.
* `sprintstring` A formatted string with named parameters. [See: Named Parameters with Formatting Codes](http://lua-users.org/wiki/StringInterpolation) for more information. Provided parameters are:
	* `column` The current horizontal column number of the spritesheet that the image is in.
	* `row` The current vertical row number of the spritesheet that the image is in.
	* `width` The width of the individual frame of the spritesheet.
	* `height` The height of the individual frame of the spritesheet.
* `sprintvars` A table of named elements that will be merged with the above provided vars. This can be used to insert custom elements into the sprintstring.
* `fontcolor` The color of the font to use when drawing the text.
* `fillcolor` The color to make the placeholder background.

# Example
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

# Example Output
![a bunch of placeholders](http://i.imgur.com/ZHfulYb.png)
