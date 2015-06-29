--[[
Title: XML Lua Library
Description: Pure lua xml parser. 
Supports: 
	doctype
	element start
	attributes
	body
	element end
Working on:
	escape characters
Substitute:
	'\' acts as escape key. 
--]]

--Misc. Functions. 

local function tabIndex(tab, ...)
	local pos = {...}
	for i=1, #pos do
		tab=tab[pos[i]]
	end
	return tab
end

--[[]]--

local xml

--Read XML file. 
local function pull(self)
	--TODO Xml event check
end

function xml.open(path)
	local tab = io.open(path, "r")
	tab["pull"] = pull
	return tab
end

--Creating XML file. 
local element, body, stop, writeFile

function xml.create(filename, root, doctype)
	assert(type(filename)=="string", 
		"Filename, expected string got, "..type(filename))
	local tab = {
		["name"] = filename,
		["?doctype"] = doctype,
		[1] = {
			["name"] = root,
		},
		element = element,
		body = body,
		stop = stop,
		writeFile = writeFile,
	}
	return tab
end

local function element(self, name)
	assert(type(name)=="string",
		"Name, expected string got, "..type(name))
	local pos = self.pos
	local tab = tabIndex(self, pos)
	tab[#tab+1] = {
		["name"]=name,
	}
	self.pos[#pos+1] = #tab+1
end

local function body(self, data)
	if type(data)=="number" then
		data = tostring(data)
	end
	assert(type(data)=="string", "Expected str or num got, "..type(data))
	local pos = self.pos
	local tab = tabIndex(self, pos)
	tab[#tab+1] = data
end

local function stop(self)
	table.remove(self.pos, #self.pos)
end

--Write xml file to path or string. 
local function writeFile(self, path)
	
end

--Return library. 

return xml