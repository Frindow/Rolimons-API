local module = {}

local endpoints = {
	["ItemDetails"] = "https://api.rolimons.com/items/v1/itemdetails",
	["DealActivity"] = "https://api.rolimons.com/market/v1/dealactivity", -- Coming soon/unused
	["PlayerInfo"] = "https://api.rolimons.com/players/v1/playerinfo/",
	["GetRecentAds"] = "https://api.rolimons.com/tradeads/v1/getrecentads"
}

local httpService = game:GetService("HttpService")

function module.GetItems()
	local ep = endpoints.ItemDetails
	local response
	local success, message = pcall(function()
		response = httpService:GetAsync(ep)
	end)
	if not success then
		warn(message)
		return nil
	end
	local data = httpService:JSONDecode(response)
	if data.success then
		return data.items
	else
		warn(ep .. " responded with a success status of false")
		return nil
	end
end

function module.GetItemDetails(ItemId : number)
	local ep = endpoints.ItemDetails
	local response
	local success, message = pcall(function()
		response = httpService:GetAsync(ep)
	end)
	if not success then
		warn(message)
		return nil
	end
	local data = httpService:JSONDecode(response)

	local demands = {
		[-1] = "Unassigned",
		[0] = "Terrible",
		[1] = "Low",
		[2] = "Normal",
		[3] = "High",
		[4] = "Amazing"
	}

	local trends = {
		[-1] = "None",
		[0] = "Lowering",
		[1] = "Unstable",
		[2] = "Stable",
		[3] = "Raising",
		[4] = "Fluctuating"
	}

	if data.success then
		local item = data.items[tostring(ItemId)]
		local list = {
			["Success"] = true :: boolean,
			["RawData"] = item :: {},
			["Name"] = item[1] :: string,
			["Acronym"] = item[2] :: string,
			["RAP"] = item[3] :: number,
			["Value"] = item[4] :: number,
			["DefaultValue"] = item[5] :: number,
			["Demand"] = demands[item[6]] :: string,
			["Trend"] = trends[item[7]] :: string,
			["Projected"] = item[8] ~= -1 and true or false,
			["Hyped"] = item[9] ~= -1 and true or false,
			["Rare"] = item[10] ~= -1 and true or false
		}
		return list
	else
		warn(ep .. " responded with a success status of false")
		return nil
	end
end

function module.GetRecentAds()
	local ep = endpoints.GetRecentAds
	local response
	local success, message = pcall(function()
		response = httpService:GetAsync(ep)
	end)
	if not success then
		warn(message)
		return nil
	end
	local data = httpService:JSONDecode(response)
	if data.success then
		local returnTable = {
			["TradeAdCount"] = 0,
			["TradeAds"] = {}
		}
		local tagToString = {
			[1] = "Demand",
			[2] = "Rares",
			[3] = "Robux",
			[4] = "Any",
			[5] = "Upgrading",
			[6] = "Downgrade",
			[7] = "RAP",
			[8] = "Wishlist",
			[9] = "Projecteds",
			[10] = "Adds"
		}
		for i, tradeAd in pairs(data.trade_ads) do
			local username = tradeAd[4]
			local offeringItems = tradeAd[5].items
			local offeringRobux = tradeAd[5].robux
			local requestingItems = tradeAd[6].items
			local tags = tradeAd[6].tags
			local function getTags()
				if tags ~= nil then
					local tagTable = {}
					for i, tag in pairs(tags) do
						table.insert(tagTable, tagToString[tag])
					end
					return tagTable
				end
				return nil
			end
			local returningAd = {
				["Username"] = username,
				["OfferingItems"] = offeringItems,
				["OfferingRobux"] = offeringRobux,
				["RequestingItems"] = requestingItems,
				["Tags"] = getTags()
			}
			table.insert(returnTable.TradeAds, returningAd)
		end
		returnTable.TradeAdCount = data.trade_ad_count
		return returnTable
	else
		warn(ep .. " responded with success status of false")
		return nil
	end
end

function module.GetPlayerInfo(UserId : number)
	local ep = endpoints.PlayerInfo .. UserId
	local response
	local success, message = pcall(function()
		response = httpService:GetAsync(ep)
	end)
	if not success then
		warn(message)
		return nil
	end
	local data = httpService:JSONDecode(response)
	if data.success == true then
		local list = {
			["Name"] = data.name,
			["Value"] = data.value,
			["RAP"] = data.rap,
			["Rank"] = data.rank,
			["Premium"] = data.premium,
			["PrivacyEnabled"] = data.privacy_enabled,
			["Terminated"] = data.terminated,
			["StatsUpdated"] = data.stats_updated,
			["LastScan"] = data.last_scan,
			["LastOnline"] = data.last_online,
			["LastLocation"] = data.last_location,
			["Rolibadges"] = data.rolibadges
		}
		return list
	elseif data.success then
		warn("Player does not exist")
	else
		warn(ep .. " responded with success status of false")
	end
	return nil
end

function module.GetItemCount()
	local ep = endpoints.ItemDetails
	local response
	local success, message = pcall(function()
		response = httpService:GetAsync(ep)
	end)
	if not success then
		warn(message)
		return nil
	end
	local data = httpService:JSONDecode(response)

	if data.success == true then
		return data.item_count :: number
	else
		return nil
	end
end

function module.GetRAPChange(OldPrice : number, NewPrice : number)
	local RAP = tonumber(OldPrice)
	local originalRAP
	local expectedRAP
	local RAPChange
	local percentChange
	local isGainingRAP
	local price = tonumber(NewPrice)
	if price >= RAP then
		--<< Ascending formula >>--
		local RAPsub = price - RAP
		local inititalChange = RAPsub / 10
		local gain = math.floor(inititalChange)
		local finalRAP = RAP + gain
		local increasePercent = math.round(100 * gain / finalRAP * 100) / 100
		expectedRAP = finalRAP
		isGainingRAP = true
		percentChange = increasePercent
		RAPChange = gain
	else
		--<< Decending formula >>--
		local RAPsub = RAP - price
		local inititalChange = RAPsub / 10
		local loss = math.floor(inititalChange)
		local finalRAP = RAP - loss
		local decreasePercent = math.round(100 * loss / finalRAP * 100) / 100
		expectedRAP = finalRAP
		isGainingRAP = false
		percentChange = tonumber("-" .. decreasePercent)
		RAPChange = tonumber("-" .. loss)
	end
	return 
		{
			["OriginalRAP"] = RAP,
			["ExpectedRAP"] = expectedRAP,
			["RAPChange"] = RAPChange,
			["PercentChange"] = percentChange,
			["IsGainingRAP"] = isGainingRAP
		}
end

return module
