local API = {}
local URL = "https://www.rolimons.com/itemapi/itemdetails"

API.fetchedItems = {}

function API.fetchItems()
	local HttpService = game:GetService("HttpService")
	
	local response = HttpService:GetAsync(URL)
	local data = HttpService:JSONDecode(response)

	if data.success == true then
		API.isWorking = true
		API.fetchedItems = data.items
	end
end

API.fetchedName = ""
API.fetchedAcronym = ""
API.fetchedRAP = 0
API.fetchedValue = 0

function API.fetchItemDetails(ItemId)
	local HttpService = game:GetService("HttpService")

	local response = HttpService:GetAsync(URL)
	local data = HttpService:JSONDecode(response)
	if data.success == true then
		local item = data.items[tostring(ItemId)]
		API.fetchedName = item[1]
		API.fetchedAcronym = item[2]
		API.fetchedRAP = item[3]
		API.fetchedValue = item[4]
--		print("Name: " .. item[1] .. ", Acronym: " .. item[2] .. ", RAP: " .. item[3] .. ", Value: " .. item[4])
	end
end

API.originalRAP = 0
API.expectedRAP = 0
API.RAPChange = 0
API.percentChange = 0
API.isGainingRAP = false

function API.getRAPChangeFromItem(BestPrice, ItemId)
	local HttpService = game:GetService("HttpService")

	local response = HttpService:GetAsync(URL)
	local data = HttpService:JSONDecode(response)

	if data.success == true then
		local item = data.items[tostring(ItemId)]
		local RAP = item[3]
		API.originalRAP = RAP
		local price = tonumber(BestPrice)
		if price >= RAP then -- Ascending formula
			local RAPsub = price - RAP
			local inititalChange = RAPsub / 10
			local gain = math.floor(inititalChange)
			local finalRAP = RAP + gain
			local increasePercent = math.round(100 * gain / finalRAP * 100) / 100
			API.expectedRAP = finalRAP
			API.isGainingRAP = true
			API.percentChange = increasePercent
			API.RAPChange = gain
		else -- Decending formula
			local RAPsub = RAP - price
			local inititalChange = RAPsub / 10
			local loss = math.floor(inititalChange)
			local finalRAP = RAP - loss
			local decreasePercent = math.round(100 * loss / finalRAP * 100) / 100
			API.expectedRAP = finalRAP
			API.isGainingRAP = false
			API.percentChange = tonumber("-" .. decreasePercent)
			API.RAPChange = tonumber("-" .. loss)
		end
	end
end

function API.getRAPChange(BestPrice, CurrentRap)
		local RAP = tonumber(CurrentRap)
		API.originalRAP = RAP
		local price = tonumber(BestPrice)
		if price >= RAP then -- Ascending formula
		local RAPsub = price - RAP
		local inititalChange = RAPsub / 10
		local gain = math.floor(inititalChange)
		local finalRAP = RAP + gain
		local increasePercent = math.round(100 * gain / finalRAP * 100) / 100
		API.expectedRAP = finalRAP
		API.isGainingRAP = true
		API.percentChange = increasePercent
		API.RAPChange = gain
	else -- Decending formula
		local RAPsub = RAP - price
		local inititalChange = RAPsub / 10
		local loss = math.floor(inititalChange)
		local finalRAP = RAP - loss
		local decreasePercent = math.round(100 * loss / finalRAP * 100) / 100
		API.expectedRAP = finalRAP
		API.isGainingRAP = false
		API.percentChange = tonumber("-" .. decreasePercent)
		API.RAPChange = tonumber("-" .. loss)
	end
end

API.itemCount = 0

function API.updateItemCount(BestPrice, ItemId)
	local HttpService = game:GetService("HttpService")

	local response = HttpService:GetAsync(URL)
	local data = HttpService:JSONDecode(response)

	if data.success == true then
		API.itemCount = data.item_count
	end
end

return API