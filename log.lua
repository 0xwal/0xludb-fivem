---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 1/7/24 3:39 AM
---

log = (function()
	local logEnabled = GetConvar('log', 'false') == 'true'

	if not logEnabled then
		return function()
		end
	end

	local function milli_to_time(milliseconds)
		local seconds = math.floor(milliseconds / 1000)
		local minutes = math.floor(seconds / 60)
		local hours = math.floor(minutes / 60)

		seconds = seconds % 60
		minutes = minutes % 60

		return ('%s:%s:%s'):format(hours, minutes, seconds)
	end

	return function(name, ...)
		local args = { ... }
		local prefix = {
			'[',
			milli_to_time(GetGameTimer()),
			']:'
		}

		local argsAsStrings = {}
		for _, arg in ipairs(args) do
			if type(arg) == 'table' then
				table.insert(argsAsStrings, json.encode(arg))
			else
				local arg = type(arg) == 'string' and ('"%s"'):format(arg) or arg
				table.insert(argsAsStrings, tostring(arg))
			end
		end
		print(('%s %s(%s)'):format(table.concat(prefix, ' '), name, table.concat(argsAsStrings, ', ')))
	end
end)()