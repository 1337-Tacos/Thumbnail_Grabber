# Thumbnail Grabber
*A very special thanks to the maintainer of the [TVDB](http://thetvdb.com) and its content contributors that make this scraper possible. Feel free to donate to it because servers don't pay for themselves. :D*
##Simple
ThumbnailerSimple.lua is a simpler scraper that only relies on Lua Socket and is not resilient to changes, but depends on much fewer libraries.
###Dependencies
* Lua Sockets

###How to use:
1. Go to http://thetvdb.com/api/GetSeries.php?seriesname=showname to get the series id of the show.
 Replacing *showname* with the name of the series you want.
2. Go to http://thetvdb.com/api/6A2C4EF987BDF26B/series/seriesID/all/en.zip to get zip containing a bunch of info about the series.
 Replacing *seriesID* with the id you got in the previous step.
3. Extract the *en.xml* file and pass its location to the Lua script.
4. Watch as it downloads all the thumbnails for the series and be happy you don't have to do it manually.


*Please don't abuse the public API token.*

##License:
* Thumbnail Grabber: [GPLv3](http://www.gnu.org/licenses/gpl.txt)
* LuaSocket: [LuaSocket v3.0](https://raw.githubusercontent.com/diegonehab/luasocket/master/LICENSE)
