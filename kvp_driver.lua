---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 9/5/23 3:52 PM
---


function kvp_driver()
	local o = {}

	function o.set(k, v)
		SetResourceKvp(k, json.encode(v))
	end

	function o.get(k)
		local content = GetResourceKvpString(k)
		return json.decode(content)
	end

	function o.delete(k)
		DeleteResourceKvp(k)
	end

	return o
end

ludb_set_driver(kvp_driver())