-- a lib to generate placeholder images
local placeholdme = {}

-- from: http://lua-users.org/wiki/StringInterpolation
local function interp(s, tab)
	return (s:gsub('%%%((%a%w*)%)([-0-9%.]*[cdeEfgGiouxXsq])',
			function(k, fmt) return tab[k] and ("%"..fmt):format(tab[k]) or
				'%('..k..')'..fmt end))
end
-- refer to: https://docs.python.org/2/library/stdtypes.html#string-formatting if confused

-- from: https://github.com/rxi/lume/#lumemerge
local function tableMerge(t, t2, retainkeys)
	for k, v in pairs(t2) do
		t[retainkeys and k or (#t + 1)] = v
	end
	return t
end

local function newPlaceHolder(self, width, height, columns, rows, sprintstring, sprintvars, fontcolor, fillcolor)
	columns = columns or 1
	rows = rows or 1
	sprintstring = sprintstring or "placeholder\n%(width)sx%(height)s \n%(column)s,%(row)s"
	fontcolor = fontcolor or {255, 255, 255, 255}
	fillcolor = fillcolor or {128, 128, 128, 255}
	--[[
		valid vars:
			column	column number of frame
			row		row number of frame
			width	frame width
			height	frame height
	]]
	local precolor = {love.graphics.getColor()}
	local precanvas = love.graphics.getCanvas()
	local iData = love.image.newImageData(width*columns, height*rows)
	local canvas = love.graphics.newCanvas(width, height)
	love.graphics.setCanvas(canvas)
	for h=1,rows do
		for w=1,columns do
			-- @TODO: Precalculate image/font height to center things horizontally.
			-- fill
			canvas:clear(fillcolor)
			
			-- do the text
			love.graphics.setColor(fontcolor)
			local providedVars = {column=w, row=h, width=width, height=height}
			local str2sprint = interp(sprintstring, tableMerge(providedVars, sprintvars))
			love.graphics.printf(str2sprint, 0, 0, width, "center")
			
			-- put the canvas on the master image
			local canvasData = canvas:getImageData()
			iData:paste(canvasData, width*(w-1), height*(h-1), 0, 0, width, height)
		end
	end
	
	-- reset the graphical state
	if precanvas then
		love.graphics.setCanvas(precanvas)
	end
	love.graphics.setColor(precolor)
	return iData
end

local metaTable = {
	__call = newPlaceHolder
}

setmetatable(placeholdme, metaTable)

return placeholdme