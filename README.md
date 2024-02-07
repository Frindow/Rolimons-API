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
>Returns: table
~~~lua
--<< Returns the item table >>--
function fetchItems()
    local items = module.fetchItems()
    if items.Success then
        return items.Items
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
>Returns: table
~~~lua
--<< Prints the item details for ROBLOX Madness Face >>--
function printMadnessFaceDetails()
    local madnessFace = module.fetchItemDetails(130213380)
    print("Madness Face RAP: " .. madnessFace.RAP)
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
>Returns: table
~~~lua
--<< Returns the changes in RAP if the madness face were to be sold at 1,000 robux >>--
function madnessFaceRAPChangeFrom1000()
    local data = module.getRAPChangeFromItem(1000, 130213380)
    if data.Success then
        print("Original RAP: " .. data.OriginalRAP)
        print("Expected RAP: " .. data.ExpectedRAP)
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
>Returns: table
~~~lua
--<< Prints the changes in RAP between two numbers (BestPrice, CurrentRAP) >>--
function getRAPChangeFrom2000IfSoldAt1000()
    local data = module.getRAPChange(1000, 2000)
    print("Original RAP: " .. data.OriginalRAP)
    print("Expected RAP: " .. data.ExpectedRAP)
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
>Returns: table
~~~lua
--<< Prints the current amount of limiteds in the Rolimon's database >>--
function printItemCount()
    local data = module.getItemCount()
    if data.Success then
        print(data.ItemCount)
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
>Returns: (table)
~~~lua
--<< Prints a table which includes the players assets >>--
function fetchPlayerAssets(userId)
    local data = module.fetchPlayerAssets(userId)
    if data.Success then
        print(data.PlayerAssets)
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
>Returns: table
~~~lua
--<< Prints various information about the player >>--
function fetchUserDetails(userId)
    local data = module.fetchUserDetails(userId)
    if data.Success then
        print("Is terminated? " .. data.Terminated)		
        print("Inventory private? " .. data.PrivacyEnabled)
    end
end

fetchUserDetails(491970127)
~~~
<br>
