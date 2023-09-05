---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 9/5/23 4:02 PM
---

exports('save', function(key, value)
  ludb_save(key, value)
end)

exports('retrieve', function(key)
  return ludb_retrieve(key)
end)

exports('delete', function(key)
  ludb_delete(key)
end)
