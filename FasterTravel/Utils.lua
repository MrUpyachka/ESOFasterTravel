
local u = FasterTravel.Utils or {}

-- http://www.lua.org/pil/19.3.html
local function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
	i = i + 1
	if a[i] == nil then return nil
	else return a[i], t[a[i]]
	end
  end
  return iter
end

local function stringIsEmpty(str)
	return str == nil or str == ""
end

local function stringStartsWith(str,value)
	return string.sub(str,1,string.len(value)) == value
end

local function copy(source,target)
	target = target or {}
	for i,v in ipairs(source) do
		table.insert(target,v)
	end
	return target
end

local function toTable(value)
	local t = type(value)
	
	if t == "table" then
		return copy(value)
	elseif t == "function" then
		local tbl = {}
		for i in value do
			table.insert(tbl,i)
		end
		
		return tbl
	end
end

local function where(iter,predicate)
	local t = type(iter)
	
	if t == "table" then
		local tbl = {}
		for i,v in ipairs(iter) do
			if predicate(v) == true then
				table.insert(tbl,v)
			end
		end
		return tbl
	elseif t == "function" then
		local cur
		return function()
			repeat
				cur = iter()
			until cur == nil or predicate(cur) == true
			return cur
		end
	end
end



local function map(iter,func)
	local t = type(iter)
	if t == "table" then
		local tbl = {}
		for i,v in ipairs(iter) do
			tbl[i]=func(v)
		end
		return tbl
	elseif t == "function" then
		local cur
		return function()
			cur = iter()
			if cur == nil then return nil end
			return func(cur)
		end
	end
end

u.pairsByKeys = pairsByKeys
u.copy = copy
u.stringIsEmpty = stringIsEmpty
u.stringStartsWith = stringStartsWith
u.toTable = toTable
u.map = map
u.where = where 

FasterTravel.Utils = u