# 0xludb-fivem
An easy to use key-value pair database library for FiveM


## API
### Saving data
#### Saving simple data
```lua
local ludb = exports['0xludb-fivem']

ludb:save('the-key', 'the-value')
ludb:save('the-key', {
  color = "red"
})
```

#### Saving nested data
```lua
local ludb = exports['0xludb-fivem']

ludb:save('the-parent/the-child', 'the-child-value')
local data = ludb:retrieve('the-parent/the-child')
print(data.value) -- the-child-value

local data = ludb:retrieve('the-parent/*')
print(data)
-- output
--[[
{
  "the-child-parent" = {
    value = "the-child-value"
  }
}

]]
```

### Retrieving data
#### Retrieve a saved value
```lua
local ludb = exports['0xludb-fivem']
ludb:save('the-key', 'the-value')
local data = ludb:retrieve('the-key')
print(data.value) -- the-value
```


### Deleting data
#### Delete a single value
```lua
local ludb = exports['0xludb-fivem']
ludb:save('the-key', 'the-value')
ludb:delete('the-key')
local data = ludb:retrieve('the-key')
print(data) -- nil
```