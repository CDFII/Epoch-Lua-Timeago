-- Simple epoch to time ago formatter
-- Converts epoch timestamps to 'just now', 'X year ago', 'a minute ago', etc. formats.

-- Original code (in JavaScript): https://github.com/simonlc/epoch-timeago
-- Translated to Lua(u) by CDFII4

-- Provided with original MIT license, view original code for more information.

local module = {}

local TimeSegments = {
	31536000,	-- Year
	2592000,	-- ~Month (30 days)
	604800,		-- Week
	86400,		-- Day
	3600,		-- Hour
	60,			-- Minute
	-math.huge	-- Seconds and future
}

-- Determines whenever or not use prural or singular versions of the time units
function makeTimeString(Unit: string, SingularString: string)
	return function(TimeSegment: number, Time: number)
		if Time >= 2 * TimeSegment then
			return `{math.floor(Time / TimeSegment)} {Unit}s ago`
		else
			return SingularString
		end
	end
end

-- Index 0 is default, since Luau doesn't have 'default' or 'case' statements
local TimeFunctions = {
	[1] = makeTimeString("year", "1 year ago"),
	[2] = makeTimeString("month", "a month ago"),
	[3] = makeTimeString("week", "a week ago"),
	[4] = makeTimeString("day", "1 day ago"),
	[5] = makeTimeString("hour", "an hour ago"),
	[6] = makeTimeString("minute", "a minute ago"),
	[7] = function() return "just now" end
}

-- Main function
-- Uses 'workspace:GetServerTimeNow()' as default, if 'TimeNow' isn't provided
function module.GetTimeAgo(Epoch: number, TimeNow: number?)
	TimeNow = TimeNow or workspace:GetServerTimeNow()
	
	local TimeDiff = TimeNow - Epoch
	local index = 1
	
	for i, TimeSegment in TimeSegments do
		if TimeDiff >= TimeSegment then
			index = i
			break
		end
	end
	
	return TimeFunctions[index](TimeSegments[index], TimeDiff)
end

return module
