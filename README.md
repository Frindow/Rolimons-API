# Information
This RBXM file provides you with two different modules to use, one for items and another one for players. For more information and changelogs, please take a look at this post on the developer forum:
https://devforum.roblox.com/t/rolimons-api-module/2015062

# Items Module Functions and Usage

## Fetch Items
~~~lua
fetchItems()
~~~
Returns a table which includes information about every non-ugc limited in Rolimon's database.
>[!IMPORTANT]
>Returns: (success : boolean, itemTable : table)
~~~lua
--<< Returns the item table >>--
function fetchItems()
	local success, items = module.fetchItems()
	if success then
		return items
	else
		warn("Failed to fetch items")
	end
end

local itemsTable = fetchItems()
print(itemsTable)
~~~
<br>

## Fetch Item Details
~~~lua
fetchItemDetails(ItemId : number)
~~~
Returns a plethora of information about the item (RAP, Value, Demand, etc.)
>[!IMPORTANT]
>Returns: (success : boolean, item : number, name : string, acronym : string, rap : number, value : number, defaultValue : number, demand : string, trend : string, projected : boolean, hyped : boolean, rare : boolean)
~~~lua
--<< Prints the item details for ROBLOX Madness Face >>--
function printMadnessFaceDetails()
	local success, item, name, acronym, rap, value, defaultValue, demand, trend, projected, hyped, rare
		= module.fetchItemDetails(130213380)
	if success then
		print(item)
		print(name)
		print(acronym)
		print(rap)
		print(value)
		print(defaultValue)
		print(demand)
		print(trend)
		print(projected)
		print(hyped)
		print(rare)
	end
end

printMadnessFaceDetails()
~~~
<br>

## Get RAP change from item
~~~lua
getRAPChangeFromItem(BestPrice : number, ItemId : number)
~~~
Returns what the RAP of an item will be if the item were to be sold at a certain price
>[!IMPORTANT]
>Returns: (success : boolean, originalRAP : number, expectedRAP : number, RAPChange : number, percentChange : number, isGainingRAP : boolean)
~~~lua
--<< Returns the changes in RAP if the madness face were to be sold at 1,000 robux >>--
function madnessFaceRAPChangeFrom1000()
	local success, originalRAP, expectedRAP, RAPChange, percentChange, isGainingRAP
		= module.getRAPChangeFromItem(1000, 130213380)
	if success then
		print(originalRAP)
		print(expectedRAP)
		print(RAPChange)
		print(percentChange)
		print(isGainingRAP)
	end
end

madnessFaceRAPChangeFrom1000()
~~~
<br>

## Get RAP change without referencing item
~~~lua
getRAPChange(BestPrice : number, CurrentRap : number)
~~~
Same as the previous function but numbers must be inputted manually
>[!IMPORTANT]
>Returns: (originalRAP : number, expectedRAP : number, RAPChange : number, percentChange : number, isGainingRAP : boolean)
~~~lua
--<< Prints the changes in RAP between two numbers (BestPrice, CurrentRAP) >>--
function getRAPChangeFrom2000IfSoldAt1000()
	local originalRAP, expectedRAP, RAPChange, percentChange, isGainingRAP = 
		module.getRAPChange(1000, 2000)
	print(originalRAP)
	print(expectedRAP) 
	print(RAPChange)
	print(percentChange)
	print(isGainingRAP)
end

getRAPChangeFrom2000IfSoldAt1000()
~~~
<br>

## Get RAP change without referencing item
~~~lua
getItemCount()
~~~
Returns the current amount of items listed in the Rolimon's database
>[!IMPORTANT]
>Returns: (success : boolean, itemCount : number)
~~~lua
--<< Prints the current amount of limiteds in the Rolimon's database >>--
function printItemCount()
	local success, itemCount = module.getItemCount()
	if success then
		print(itemCount)
	end
end

printItemCount()
~~~
<br>

# Players Module Functions and Usage

## Fetch Player Assets
~~~lua
fetchPlayerAssets(UserId : number)
~~~
Returns a table which includes every asset the player owns under the following conditions:
- The player is listed on Rolimon's
- The player's inventory is not private
>[!IMPORTANT]
>Returns: (success : boolean, assetsTable : table)
~~~lua
--<< Prints a table which includes the players assets >>--
function fetchPlayerAssets(userId)
	local success, playerAssets = module.fetchPlayerAssets(userId)
	if success then
		print(playerAssets)
	end
end

fetchPlayerAssets(491970127)
~~~
<br>

## Fetch User Details
~~~lua
fetchUserDetails(UserId : number)
~~~
Returns information about the provided user if the user is listed on Rolimon's
>[!IMPORTANT]
>Returns: (success : boolean, username : string, value : number, rap : number, ran : number, premium : boolean, privacyEnabled : boolean, terminated : boolean, statsUpdated : number, lastOnline : number, lastLocation : string, roliBadges : table)
~~~lua
--<< Prints various information about the player >>--
function fetchUserDetails(userId)
	local success, username, value, rap, rank, premium, privacyEnabled, terminated, statsUpdated, lastOnline, lastLocation, roliBadges =
		module.fetchUserDetails(userId)
	if success then
		print(username)       --<< String >>--
		print(value)          --<< Number >>--
		print(rap)            --<< Number >>--
		print(rank)           --<< Number or nil >>--
		print(premium)        --<< Boolean >>--
		print(privacyEnabled) --<< Boolean >>--
		print(terminated)     --<< Boolean >>--
		print(statsUpdated)   --<< Number (time in ticks) >>--
		print(lastOnline)     --<< Number (time in ticks) >>--
		print(lastLocation)   --<< String >>--
		print(roliBadges)     --<< Table >>--		
	end
end

fetchUserDetails(491970127)
~~~
<br>
