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

local ludb = ludb_new()
ludb:setDriver(kvp_driver())

local ludbInMemory = ludb_new()

exports('save', function(key, value)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = make_key_unique_for_resource(key)
	log('save', name, value)
	ludb:save(name, value)
end)

exports('saveGlobal', function(key, value)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = ('global/%s'):format(key)
	log('saveGlobal', name, value)
	ludb:save(name, value)
end)

exports('saveInMemory', function(key, value)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = make_key_unique_for_resource(key)
	log('saveInMemory', name, value)
	ludbInMemory:save(name, value)
end)

exports('retrieve', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name  = make_key_unique_for_resource(key)
	local value = ludb:retrieve(name)
	log('retrieve', name, value)
	return value
end)

exports('retrieveGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name  = ('global/%s'):format(key)
	local value = ludb:retrieve(name)
	log('retrieveGlobal', name, value)
	return value
end)

exports('retrieveFromMemory', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name  = make_key_unique_for_resource(key)
	local value = ludbInMemory:retrieve(name)
	log('retrieveFromMemory', name, value)
	return value
end)

exports('delete', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name = make_key_unique_for_resource(key)
	log('delete', name)
	ludb:delete(name)
end)

exports('deleteGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = ('global/%s'):format(key)
	log('deleteGlobal', name)
	ludb:delete(name)
end)

exports('deleteInMemory', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = make_key_unique_for_resource(key)
	log('deleteInMemory', name)
	ludbInMemory:delete(name)
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
					json.encode(ludb:retrieve('*'))
	)
	print('ret', ret, type(ret))
end, true)