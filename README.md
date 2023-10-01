# 0xludb-fivem - Key-Value Pair Database Library

0xludb-fivem is a lightweight key-value pair (KVP) database library designed for use within your scripts. It allows you to store and retrieve data using keys, and it supports retrieving data with wildcards for nesting data.

## Features
- **Efficient Data Storage:** Streamlined key-value pair management.
- **Works Client and Server:** Streamlined key-value pair management.
- **Local and Global Data:** Store data locally or globally.
- **Wildcard Retrieval:** Retrieve data matching patterns.
- **Simple Integration:** Easy module import and use.
- **Backup and Export:** Export data to JSON for backup or analysis.
- **Resource-Based Keys:** Ensure key uniqueness within resources.
- **Self-Contained:** No need for external databases.


## Public Functions and Commands

### `save(key, value)`

Saves a value using a key. The key can be a string or a table. Data saved with this function is accessible only within the invoking resource.

### `saveGlobal(key, value)`

Saves a value globally using a key. The key can be a string or a table. Globally saved data is accessible from all resources.

### `retrieve(key)`

Retrieves a value using a key. The key can be a string or a table. Data retrieved with this function is specific to the invoking resource.

### `retrieveGlobal(key)`

Retrieves a globally saved value using a key. The key can be a string or a table. Globally retrieved data is accessible from all resources.

### `delete(key)`

Deletes a value using a key. The key can be a string or a table. Data deleted with this function is specific to the invoking resource.

### `deleteGlobal(key)`

Deletes a globally saved value using a key. The key can be a string or a table. Globally deleted data is removed from all resources.

### Command: `0xludb-export`

Exports data to a JSON file when invoked from the server console (serverId 0). This command is typically used to export data for backup or analysis.

## Usage Example

You can import the module using:

#### Local

```lua
-- Import the 0xludb-fivem module
local ludb = exports['0xludb-fivem']

-- Save player tokens
ludb:save("players/license:123/tokens", 1000)

-- Save player coordinates
ludb:save("players/license:123/coords", { x = 50, y = -30, z = 10 })

-- Confirmation message
print("Player tokens and coordinates saved.")


-- Retrieve player tokens
local tokens = ludb:retrieve("players/license:123/tokens")

-- Display retrieved tokens
print("Player Tokens:", tokens)


-- Retrieve all player information using wildcard (*)
local player = ludb.retrieve("players/license:123/*")

print(json.encode(player.tokens.value))
print(json.encode(player.coords.value))

-- Delete tokens
ludb:delete("players/license:123/tokens")

local tokens = ludb:retrieve("players/license:123/tokens")
print(tokens) -- nil
```

#### Globally (data accessible from all resources)
```lua
-- Import the 0xludb-fivem module
local ludb = exports['0xludb-fivem']

-- Save global player tokens
ludb:saveGlobal("players/license:123/tokens", 1000)

-- Save global player coordinates
ludb:saveGlobal("players/license:123/coords", { x = 50, y = -30, z = 10 })

-- Confirmation message
print("Global Player tokens and coordinates saved.")

-- In another resource (assuming you have access to ludb)

-- Retrieve global player tokens
local globalTokens = ludb:retrieveGlobal("players/license:123/tokens")

-- Display retrieved global tokens
print("Global Player Tokens:", globalTokens)

-- Retrieve all global player information using wildcard (*)
local globalPlayer = ludb:retrieveGlobal("players/license:123/*")

print(json.encode(globalPlayer.tokens.value))
print(json.encode(globalPlayer.coords.value))

-- Delete global tokens
ludb:deleteGlobal("players/license:123/tokens")

local globalTokens = ludb:retrieveGlobal("players/license:123/tokens")
print(globalTokens) -- nil

```