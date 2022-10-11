local items = require(game:GetService("ReplicatedStorage")["Rolimon's API"].Items)
local userDetails = require(game:GetService("ReplicatedStorage")["Rolimon's API"].UserDetails)
local userAssets = require(game:GetService("ReplicatedStorage")["Rolimon's API"].UserAssets)

items.fetchItems() -- Generates a table based off of the Rolimon's item API 
print("--------------------")
print("Generated table:")
print(items.Items) -- Prints the generated table

items.fetchItemDetails(2409285794) -- Fetches item details for "Playful Vampire"
print("--------------------")
print("Name: " .. items.Name) -- Prints the  items name
print("Acronym: " .. items.Acronym) -- Prints the  items acronym
print("RAP: " .. items.RAP) -- Prints the  items RAP
print("Value: " .. items.Value) -- Prints the  items value
print("Default value: " .. items.DefaultValue) -- Prints the  items value
print("Demand: " .. items.Demand) -- Prints the  items demand
print("Trend: " .. items.Trend) -- Prints the  items trend
print("Projected:") -- Prints a boolean determining if the item is projected
print(items.Projected)
print("Hyped:") -- Prints a boolean determining if the item is hyped
print(items.Hyped)
print("Rare:") -- Prints a boolean determining if the item is rare
print(items.Rare)

items.getRAPChangeFromItem(1000, 2409285794) -- Generates the expected price and other details if "Playful Vampire" were to be sold at 1000 robux
print("--------------------")
print("Original RAP: " .. items.originalRAP)
print("Expected RAP: " .. items.expectedRAP) -- Prints the expected RAP
print("Percent change: " .. items.percentChange .. "%") -- Prints the percent the RAP increased or decreased
print("Is gaining RAP:")
print(items.isGainingRAP) -- Prints a boolean on whether or not the RAP is increasing or decreasing (true is gaining, false is decreasing)
print("RAP change: " .. items.RAPChange) -- The change in RAP

items.getRAPChange(1000, 25000) -- Generates the expected price and other details if a limited were to be sold at 1000 with the current rap being 25,000
print("--------------------")
print("Original RAP: " .. items.originalRAP)
print("Expected RAP: " .. items.expectedRAP) -- Prints the expected RAP
print("Percent change: " .. items.percentChange .. "%") -- Prints the percent the RAP increased or decreased
print("Is gaining RAP:")
print(items.isGainingRAP) -- Prints a boolean on whether or not the RAP is increasing or decreasing (true is gaining, false is decreasing)
print("RAP change: " .. items.RAPChange) -- The change in RAP

items.updateItemCount() -- Updates the item count variable
print("--------------------")
print("Item count: " .. items.itemCount) -- Prints the item count


userDetails.fetchUserDetails(491970127)
print("--------------------")
print("Username: " .. userDetails.Username)
print("Value: " .. userDetails.Value)
print("RAP: " .. userDetails.RAP)
print("Rank: " .. userDetails.Rank)
print("Has premium:")
print(userDetails.Premium)
print("Privacy enabled:")
print(userDetails.PrivacyEnabled)
print("Terminated:")
print(userDetails.Terminated)
print("Stats updated: " .. userDetails.StatsUpdated)
print("Last online: " .. userDetails.LastOnline)
print("Last location" .. userDetails.LastLocation)
print("Rolibadges:")
print(userDetails.RoliBadges)

userAssets.fetchPlayerAssets(491970127)
print(userAssets.Assets)
