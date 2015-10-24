local http = require'socket.http'
local ltn12 = require'ltn12'

function readLines(file)
local t = {}
local i = 1
for line in io.lines(file) do
	t[i] = line
	i = i + 1
end
return t
end

function hasTag(str, tag)
	str = str:gsub("^%s+", "")
	if str:sub(1,tag:len()) == tag then
		return true
	else
		return false
	end
end

function tagContents(line, tag)
	line = line:gsub("^%s+", "")
	return line:sub(tag:len() + 1, line:len() - tag:len() - 1)	
end

local content = readLines(arg[1])
local site = 'http://thetvdb.com/banners/_cache/'
local seriesTag = '<SeriesName>'
local fileTag = '<filename>'
local epTag = '<EpisodeNumber>'
local seasonTag = '<SeasonNumber>'
local nameTag = '<EpisodeName>'
local seriesName = ''
local thumbLoc = ''
local epInfo = {fileTag = '', epTag = '', seasonTag = '', nameTag = ''}

for k,str in ipairs(content) do
	if hasTag(str, seriesTag) then
		seriesName = tagContents(str, seriesTag)
		print('Series name found: ' .. seriesName)
	end
end

if seriesName == '' then
	print('Series name not found.')
	os.exit(1)
end

local count = 0
for k,str in ipairs(content) do
	if hasTag(str, fileTag) then
		epInfo[fileTag] = tagContents(str, fileTag)
		count = count + 1
	elseif hasTag(str, epTag) then
		epInfo[epTag] = tagContents(str, epTag)
		count = count + 1
	elseif hasTag(str, seasonTag) then
		epInfo[seasonTag] = tagContents(str, seasonTag) + 1
		count = count + 1
	elseif hasTag(str, nameTag) then
		epInfo[nameTag] = tagContents(str, nameTag)
		count = count + 1
	end
	
	if count == 4 then
		count = 0
		if epInfo[fileTag] ~= '' then
			http.request {
  			url = site .. epInfo[fileTag],
  			sink = ltn12.sink.file(io.open(seriesName .. '.S'.. epInfo[seasonTag] .. '.E' .. epInfo[epTag] .. '.' .. epInfo[nameTag] .. '.jpg', 'w')),
			}
			print(seriesName .. '.S'.. epInfo[seasonTag] .. '.E' .. epInfo[epTag] .. ' was found.')
		else
			print(seriesName .. '.S'.. epInfo[seasonTag] .. '.E' .. epInfo[epTag] .. ' was missing a thumbnail location around line ' .. k)
		end
	end
end
