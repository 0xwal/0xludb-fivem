---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 9/5/23 4:02 PM
---

local function make_key_unique_for_resource(key)
	local resource = GetInvokingResource()
	return ('%s/%s'):format(resource, key)
end

local function transform_array_key(key)
	return table.concat(key, '/')
end

exports('save', function(key, value)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	ludb_save(make_key_unique_for_resource(key), value)
end)

exports('saveGlobal', function(key, value)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	print(('global/%s'):format(key))
	ludb_save(('global/%s'):format(key), value)
end)

exports('retrieve', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	return ludb_retrieve(make_key_unique_for_resource(key))
end)

exports('retrieveGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	return ludb_retrieve(('global/%s'):format(key))
end)

exports('delete', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	ludb_delete(make_key_unique_for_resource(key))
end)

exports('deleteGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	ludb_delete(('global/%s'):format(key))
end)

RegisterCommand('0xludb-export', function(serverId)
	print('serverId', serverId, type(serverId))
	if serverId ~= 0 then
		return
	end
	local time = os.time()
	local ret  = SaveResourceFile(
					GetCurrentResourceName(),
					('dump-%s.json'):format(time),
					json.encode(ludb_retrieve('*'))
	)
	print('ret', ret, type(ret))
end, true)