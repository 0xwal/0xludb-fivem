---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 9/5/23 4:02 PM
---

local function make_key_unique_for_resource(key)
	local resource = GetInvokingResource()
	return key and ('%s/%s'):format(resource, key) or resource
end

local function transform_array_key(key)
	if not key then
		return ''
	end
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

	local name  = make_key_unique_for_resource(key or '*')
	local value = ludb:retrieve(name)
	log('retrieve', name, value)
	return value
end)

exports('retrieveGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name  = ('global/%s'):format(key or '*')
	local value = ludb:retrieve(name)
	log('retrieveGlobal', name, value)
	return value
end)

exports('retrieveFromMemory', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name  = make_key_unique_for_resource(key or '*')
	local value = ludbInMemory:retrieve(name)
	log('retrieveFromMemory', name, value)
	return value
end)

exports('delete', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name = make_key_unique_for_resource(key or '*')
	log('delete', name)
	ludb:delete(name)
end)

exports('deleteAll', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end

	local name = make_key_unique_for_resource(key or '*')
	log('deleteAll', name)
	ludb:deleteAll(name)
end)

exports('deleteGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = ('global/%s'):format(key or '*')
	log('deleteGlobal', name)
	ludb:delete(name)
end)

exports('deleteAllGlobal', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = ('global/%s'):format(key or '*')
	log('deleteAllGlobal', name)
	ludb:deleteAll(name)
end)

exports('deleteInMemory', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = make_key_unique_for_resource(key or '*')
	log('deleteInMemory', name)
	ludbInMemory:delete(name)
end)

exports('deleteAllInMemory', function(key)
	if type(key) == 'table' then
		key = transform_array_key(key)
	end
	local name = make_key_unique_for_resource(key or '*')
	log('deleteAllInMemory', name)
	ludbInMemory:deleteAll(name)
end)

function ludb_disk_export()
	local time = os.time()
	local resourceName = GetCurrentResourceName()
	local fileName = ('dump-%s.json'):format(time)
	local entries = ludb:retrieve('*') or {}
	local content = json.encode(entries)
	return SaveResourceFile(resourceName, fileName, content)
end

function ludb_reset_all()
	ludb:deleteAll('*')
	ludbInMemory:deleteAll('*')
end

RegisterCommand('0xludb-export', function(serverId)
	print('serverId', serverId, type(serverId))
	if serverId ~= 0 then
		return
	end

	local ret = ludb_disk_export()
	print('ret', ret, type(ret))
end, true)


RegisterCommand('0xludb-reset', function(serverId)
	print('serverId', serverId, type(serverId))
	if serverId ~= 0 then
		return
	end

	ludb_reset_all()
end)
