# Information
For more information and changelogs, please take a look at this post on the developer forum:
https://devforum.roblox.com/t/rolimons-api-module/2015062

# Items Module Functions and Usage

## Get Items
~~~lua
GetItems()
~~~
Returns a table which includes information about every non-ugc limited in Rolimon's database.
>[!IMPORTANT]
>Returns: table
~~~lua
--<< Print every limited in the item table >>--
local limiteds = module.GetItems()
for i, limited in pairs(limiteds) do
    print(limited)
end
~~~
<br>

## Get Item Details
~~~lua
GetItemDetails(ItemId : number)
~~~
Returns a plethora of information about the item (RAP, Value, Demand, etc.)
>[!IMPORTANT]
>**Returns a table with the following values:** Success, Item, Name, Acronym, RAP, Value, DefaultValue, Demand, Trend, Projected, Hyped, Rare
~~~lua
--<< Prints the item details for ROBLOX Madness Face >>--
function printMadnessFaceDetails()
    local madnessFace = module.GetItemDetails(130213380)
    print("Madness Face RAP: " .. madnessFace.RAP)
end

printMadnessFaceDetails()
~~~
<br>

## Get RAP Change
~~~lua
GetRAPChange(BestPrice : number, CurrentRap : number)
~~~
Returns item RAP changes if sold at x price.
>[!IMPORTANT]
>Returns: table
~~~lua
--<< Prints the changes in RAP between two numbers (BestPrice, CurrentRAP) >>--
function getRAPChangeFrom2000IfSoldAt1000()
    local data = module.GetRAPChange(1000, 2000)
    print("Original RAP: " .. data.OriginalRAP)
    print("Expected RAP: " .. data.ExpectedRAP)
end

getRAPChangeFrom2000IfSoldAt1000()
~~~
<br>

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

## Get Player Info
~~~lua
GetUserDetails(UserId : number)
~~~
Returns information about the user under the following conditions:
- The player is listed on Rolimon's
- The player's inventory is not private
>[!IMPORTANT]
>Returns: table
~~~lua
--<< Prints various information about the player >>--
function GetPlayerInfo(userId)
    local data = module.GetPlayerInfo(userId)
    if data.Success then
        print("Is terminated? " .. data.Terminated)		
        print("Inventory private? " .. data.PrivacyEnabled)
    end
end

GetUserDetails(491970127)
~~~
<br>
