---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 9/5/23 4:02 PM
---

function make_key_unique_for_resource(key)
	local resource = GetInvokingResource()
	return ('%s/%s'):format(resource, key)
end

exports('save', function(key, value)
	ludb_save(make_key_unique_for_resource(key), value)
end)

exports('saveGlobal', function(key, value)
	ludb_save(('global/%s'):format(key), value)
end)

exports('retrieve', function(key)
	return ludb_retrieve(make_key_unique_for_resource(key))
end)

exports('retrieveGlobal', function(key)
	return ludb_retrieve(('global/%s'):format(key))
end)

exports('delete', function(key)
	ludb_delete(make_key_unique_for_resource(key))
end)

exports('deleteGlobal', function(key)
	ludb_delete(('global/%s'):format(key))
end)

