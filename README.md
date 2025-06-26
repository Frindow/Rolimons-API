# 🚀 Rolimons API Module for Roblox

[![Lua Version](https://img.shields.io/badge/Lua-5.1-blue)](https://www.lua.org/) [![License: MIT](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A lightweight Roblox Lua module to fetch item, market, and player data from the Rolimons API.

---

## 🔗 Table of Contents

1. [Features](#✨-features)  
2. [Installation](#📥-installation)  
3. [Usage](#🛠️-usage)  
   - [Require & Setup](#require--setup)  
   - [Functions Overview](#functions-overview)  
4. [API Endpoints](#🔍-api-endpoints)  
5. [Examples](#📚-examples)  
6. [Error Handling](#⚠️-error-handling)  
7. [Contributing](#🤝-contributing)  
8. [License](#📄-license)  

---

## ✨ Features

- ✅ Fetch **all** non-UGC limited item details  
- ✅ Get **single** item stats (RAP, Value, Demand, Trend, etc.)  
- ✅ Calculate **RAP change** between two prices  
- ✅ Retrieve **recent trade ads** with tag parsing  
- ✅ Lookup **player info** (value, RAP, premium status, last online, badges)  

---

## 📥 Installation

1. **Clone** or **download** this repo.  
2. Copy `API.lua` into your game.  
3. Enable `HttpService` in your game settings.

---

## 🛠️ Usage

### Require & Setup

```lua
local HttpService = game:GetService("HttpService")
local Rolimons   = require(path.to.rolimons)
```

### Functions Overview

| Function                           | Parameters                        | Returns                              |
| ---------------------------------- | --------------------------------- | ------------------------------------ |
| `GetItems()`                       | —                                 | `table` of all limited items         |
| `GetItemDetails(itemId)`           | `number`                          | `table` with item stats              |
| `GetRAPChange(oldPrice, newPrice)` | `number, number`                  | `table` of RAP change info           |
| `GetRecentAds()`                   | —                                 | `table` of recent trade ads          |
| `GetPlayerInfo(userId)`            | `number`                          | `table` of player metadata           |
| `GetItemCount()`                   | —                                 | `number` total items in database     |

---

## 🔍 API Endpoints

| Key            | URL                                                            |
| -------------- | -------------------------------------------------------------- |
| `ItemDetails`  | `https://api.rolimons.com/items/v1/itemdetails`                |
| `DealActivity` | *(Unused / Coming Soon)*                                       |
| `PlayerInfo`   | `https://api.rolimons.com/players/v1/playerinfo/{UserId}`      |
| `GetRecentAds` | `https://api.rolimons.com/tradeads/v1/getrecentads`            |

---

## 📚 Examples

### 1. Get All Items

```lua
local items = Rolimons.GetItems()
for _, item in pairs(items) do
    print(item.Name, "— RAP:", item.RAP)
end
```

### 2. Get Details for One Item

```lua
local id = 130213380  -- “Madness Face”
local info = Rolimons.GetItemDetails(id)
if info.Success then
    print(("Name: %s | RAP: %d | Demand: %s | Trend: %s")
        :format(info.Name, info.RAP, info.Demand, info.Trend))
end
```

### 3. Calculate RAP Change

```lua
local delta = Rolimons.GetRAPChange(2000, 1500)
print(("Original: %d → Expected: %d (%+.2f%%)")
    :format(delta.OriginalRAP, delta.ExpectedRAP, delta.PercentChange))
```

### 4. Fetch Recent Trade Ads

```lua
local ads = Rolimons.GetRecentAds()
print("Total ads:", ads.TradeAdCount)
for _, ad in ipairs(ads.TradeAds) do
    print(ad.Username, "offers", #ad.OfferingItems, "items")
end
```

### 5. Lookup Player Info

```lua
local userId = 491970127
local player = Rolimons.GetPlayerInfo(userId)
if player then
    print(("Player %s — RAP: %d | Premium: %s")
        :format(player.Name, player.RAP, tostring(player.Premium)))
end
```

---

## ⚠️ Error Handling

All network calls use `pcall`. If a request fails or the API returns `success = false`, the module:

- Logs a warning (`warn(...)`)  
- Returns `nil`  

Be sure to check for `nil` before using returned tables.

---

## 🤝 Contributing

1. Fork the repo  
2. Create a feature branch (`git checkout -b feature/YourIdea`)  
3. Commit your changes (`git commit -am 'Add new feature'`)  
4. Push to the branch (`git push origin feature/YourIdea`)  
5. Open a Pull Request  

Please follow standard [semantic versioning](https://semver.org/) and write clear PR titles.

---

## 📄 License

This project is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.
