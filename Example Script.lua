local api = require(game:GetService("ReplicatedStorage").API)

api.fetchItems() -- Generates a table based off of the Rolimon's item API 
print("--------------------")
print("Generated table:")
print(api.fetchedItems) -- Prints the generated table

api.fetchItemDetails(2409285794) -- Fetches item details for "Playful Vampire"
print("--------------------")
print("Fetched name: " .. api.fetchedName) -- Prints the fetched items name
print("Fetched acronym: " .. api.fetchedAcronym) -- Prints the fetched items acronym
print("Fetched RAP: " .. api.fetchedRAP) -- Prints the fetched items RAP
print("Fetched value: " .. api.fetchedValue) -- Prints the fetched items value

api.getRAPChangeFromItem(1000, 2409285794) -- Generates the expected price and other details if "Playful Vampire" were to be sold at 1000 robux
print("--------------------")
print("Original RAP: " .. api.originalRAP)
print("Expected RAP: " .. api.expectedRAP) -- Prints the expected RAP
print("Percent change: " .. api.percentChange .. "%") -- Prints the percent the RAP increased or decreased
print("Is gaining RAP:")
print(api.isGainingRAP) -- Prints a boolean on whether or not the RAP is increasing or decreasing (true is gaining, false is decreasing)
print("RAP change: " .. api.RAPChange) -- The change in RAP

api.getRAPChange(1000, 25000) -- Generates the expected price and other details if a limited were to be sold at 1000 with the current rap being 25,000
print("--------------------")
print("Original RAP: " .. api.originalRAP)
print("Expected RAP: " .. api.expectedRAP) -- Prints the expected RAP
print("Percent change: " .. api.percentChange .. "%") -- Prints the percent the RAP increased or decreased
print("Is gaining RAP:")
print(api.isGainingRAP) -- Prints a boolean on whether or not the RAP is increasing or decreasing (true is gaining, false is decreasing)
print("RAP change: " .. api.RAPChange) -- The change in RAP

api.updateItemCount() -- Updates the item count variable
print("--------------------")
print("Item count: " .. api.itemCount) -- Prints the item count