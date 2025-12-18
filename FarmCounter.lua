-- ============================================================================
-- FARMCOUNTER 7.1 - New Filters (Elements & Gems)
-- ============================================================================

local addonName, addonTable = ...
local L = addonTable.L

local FILTER_ALL = 1; local FILTER_ORES = 2; local FILTER_HERBS = 3
local FILTER_SKINNING = 4; local FILTER_HOUSING = 5; local FILTER_ENCHANTING = 6
local FILTER_COOKING = 7; local FILTER_ELEMENTAL = 8; local FILTER_GEMS = 9

local BORDER_COLORS = {
    [FILTER_ALL] = {1.0, 0.85, 0.0},        -- Gold
    [FILTER_ORES] = {1.0, 0.3, 0.2},        -- Red
    [FILTER_HERBS] = {0.2, 1.0, 0.2},       -- Green
    [FILTER_SKINNING] = {0.6, 0.4, 0.2},    -- Brown
    [FILTER_HOUSING] = {0.0, 0.7, 1.0},     -- Blue
    [FILTER_ENCHANTING] = {0.8, 0.4, 1.0},  -- Purple
    [FILTER_COOKING] = {1.0, 0.5, 0.0},     -- Orange
    [FILTER_ELEMENTAL] = {0.0, 1.0, 1.0},   -- Cyan
    [FILTER_GEMS] = {1.0, 0.4, 0.8}         -- Pink
}

local db
local collapsedGroups = {}
local itemRows = {}
local headerRows = {}
-- Session Table to prevent sound spam
local sessionGoalMet = {} 

local UpdateFarmList, UpdateMinimapIcon, UpdateBorderColor

-- ----------------------------------------------------------------------------
-- POPUP DIALOG
-- ----------------------------------------------------------------------------
StaticPopupDialogs["FARMCOUNTER_SET_GOAL"] = {
    text = L["GOAL_POPUP_TEXT"],
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    maxLetters = 5,
    OnShow = function(self, data)
        self.EditBox:SetNumeric(true)
        if data.currentGoal and data.currentGoal > 0 then
            self.EditBox:SetText(data.currentGoal)
        end
        self.EditBox:SetFocus()
    end,
    OnAccept = function(self, data)
        local text = self.EditBox:GetText()
        local value = tonumber(text) or 0
        
        if not db.goals then db.goals = {} end
        
        if value > 0 then
            db.goals[data.itemID] = value
            print("|cFF00FF00FarmCounter:|r " .. string.format(L["GOAL_SET"], data.itemName, value))
        else
            db.goals[data.itemID] = nil
            print("|cFF00FF00FarmCounter:|r " .. string.format(L["GOAL_REMOVED"], data.itemName))
        end
        sessionGoalMet[data.itemID] = false 
        UpdateFarmList()
    end,
    EditBoxOnEnterPressed = function(self)
        local parent = self:GetParent()
        StaticPopupDialogs["FARMCOUNTER_SET_GOAL"].OnAccept(parent, parent.data)
        parent:Hide()
    end,
    EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- ----------------------------------------------------------------------------
-- HAUPTFENSTER
-- ----------------------------------------------------------------------------
local FarmFrame = CreateFrame("Frame", "FarmCounterMainFrame", UIParent)
FarmFrame:SetFrameStrata("HIGH"); FarmFrame:SetMovable(true); FarmFrame:EnableMouse(true)
FarmFrame:SetClampedToScreen(true); FarmFrame:SetResizable(true); FarmFrame:SetResizeBounds(250, 200, 800, 1000)
FarmFrame:Hide()

FarmFrame.bg = FarmFrame:CreateTexture(nil, "BACKGROUND")
FarmFrame.bg:SetAllPoints(); FarmFrame.bg:SetColorTexture(0.05, 0.05, 0.05, 0.85)

FarmFrame.borderLines = {}
local function CreateLine(point, relativePoint, x, y, w, h)
    local l = FarmFrame:CreateTexture(nil, "BORDER")
    l:SetColorTexture(1, 0.85, 0, 1)
    if w then l:SetWidth(w) else l:SetPoint("LEFT"); l:SetPoint("RIGHT") end
    if h then l:SetHeight(h) else l:SetPoint("TOP"); l:SetPoint("BOTTOM") end
    l:SetPoint(point, FarmFrame, relativePoint, x, y)
    table.insert(FarmFrame.borderLines, l)
end
CreateLine("TOPLEFT", "TOPLEFT", 0, 0, nil, 2); CreateLine("BOTTOMLEFT", "BOTTOMLEFT", 0, 0, nil, 2)
CreateLine("TOPLEFT", "TOPLEFT", 0, 0, 2, nil); CreateLine("TOPRIGHT", "TOPRIGHT", 0, 0, 2, nil)

local TitleBar = CreateFrame("Frame", nil, FarmFrame)
TitleBar:SetHeight(30); TitleBar:SetPoint("TOPLEFT", 2, -2); TitleBar:SetPoint("TOPRIGHT", -2, -2)
TitleBar.bg = TitleBar:CreateTexture(nil, "BACKGROUND"); TitleBar.bg:SetAllPoints(); TitleBar.bg:SetColorTexture(0.2, 0.2, 0.2, 1)
TitleBar.text = TitleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
TitleBar.text:SetPoint("CENTER"); TitleBar.text:SetText(L["TITLE"]); TitleBar.text:SetTextColor(1, 0.8, 0.4)

TitleBar:EnableMouse(true); TitleBar:RegisterForDrag("LeftButton")
TitleBar:SetScript("OnDragStart", function() FarmFrame:StartMoving() end)
TitleBar:SetScript("OnDragStop", function() FarmFrame:StopMovingOrSizing()
    local p, _, rp, x, y = FarmFrame:GetPoint(); db.point = p; db.relativePoint = rp; db.x = x; db.y = y end)

local CloseBtn = CreateFrame("Button", nil, TitleBar, "UIPanelCloseButton"); CloseBtn:SetPoint("RIGHT", -2, 0)
CloseBtn:SetScript("OnClick", function() FarmFrame:Hide() end)

local ResizeBtn = CreateFrame("Button", nil, FarmFrame); ResizeBtn:SetSize(16, 16); ResizeBtn:SetPoint("BOTTOMRIGHT", -2, 2)
ResizeBtn:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
ResizeBtn:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
ResizeBtn:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
ResizeBtn:SetScript("OnMouseDown", function() FarmFrame:StartSizing("BOTTOMRIGHT") end)
ResizeBtn:SetScript("OnMouseUp", function() FarmFrame:StopMovingOrSizing() db.width = FarmFrame:GetWidth(); db.height = FarmFrame:GetHeight() end)

local ScrollFrame = CreateFrame("ScrollFrame", nil, FarmFrame, "UIPanelScrollFrameTemplate")
ScrollFrame:SetPoint("TOPLEFT", 10, -40); ScrollFrame:SetPoint("BOTTOMRIGHT", -30, 25)
local Content = CreateFrame("Frame", nil, ScrollFrame); Content:SetSize(1, 1); ScrollFrame:SetScrollChild(Content)
ScrollFrame:SetScript("OnSizeChanged", function(self) Content:SetWidth(self:GetWidth()) end)

FarmFrame:SetScript("OnShow", function() if db then db.isVisible = true end; UpdateFarmList() end)
FarmFrame:SetScript("OnHide", function() if db then db.isVisible = false end end)

UpdateBorderColor = function()
    local color = BORDER_COLORS[db.filterMode] or BORDER_COLORS[FILTER_ALL]
    for _, line in ipairs(FarmFrame.borderLines) do line:SetColorTexture(color[1], color[2], color[3], 1) end
end

local function GetFilterName(mode)
    if mode == FILTER_ALL then return L["FILTER_ALL"]
    elseif mode == FILTER_ORES then return L["FILTER_ORES"]
    elseif mode == FILTER_HERBS then return L["FILTER_HERBS"]
    elseif mode == FILTER_SKINNING then return L["FILTER_SKINNING"]
    elseif mode == FILTER_HOUSING then return L["FILTER_HOUSING"]
    elseif mode == FILTER_ENCHANTING then return L["FILTER_ENCHANTING"]
    elseif mode == FILTER_COOKING then return L["FILTER_COOKING"]
    elseif mode == FILTER_ELEMENTAL then return L["FILTER_ELEMENTAL"]
    elseif mode == FILTER_GEMS then return L["FILTER_GEMS"] end
    return "Unknown"
end

local function ToggleFilter()
    db.filterMode = db.filterMode + 1; if db.filterMode > 9 then db.filterMode = 1 end
    UpdateMinimapIcon(); UpdateBorderColor(); UpdateFarmList()
    print("|cFF00FF00FarmCounter:|r " .. L["FILTER_CHANGE"] .. " " .. GetFilterName(db.filterMode))
end

local minimapBtn, minimapIcon
UpdateMinimapIcon = function()
    if not minimapIcon then return end
    if db.filterMode == FILTER_ORES then minimapIcon:SetTexture("Interface\\Icons\\inv_pick_02")
    elseif db.filterMode == FILTER_HERBS then minimapIcon:SetTexture("Interface\\Icons\\inv_misc_flower_02")
    elseif db.filterMode == FILTER_SKINNING then minimapIcon:SetTexture("Interface\\Icons\\inv_misc_leatherscrap_08")
    elseif db.filterMode == FILTER_HOUSING then minimapIcon:SetTexture("Interface\\Icons\\inv_tradeskillitem_03")
    elseif db.filterMode == FILTER_ENCHANTING then minimapIcon:SetTexture("Interface\\Icons\\inv_enchant_duststrange")
    elseif db.filterMode == FILTER_COOKING then minimapIcon:SetTexture("Interface\\Icons\\inv_misc_food_15")
    elseif db.filterMode == FILTER_ELEMENTAL then minimapIcon:SetTexture("Interface\\Icons\\inv_elemental_primal_fire")
    elseif db.filterMode == FILTER_GEMS then minimapIcon:SetTexture("Interface\\Icons\\inv_misc_gem_diamond_01")
    else minimapIcon:SetTexture("Interface\\Icons\\inv_misc_bag_08") end
end

local function InitMinimapButton()
    minimapBtn = CreateFrame("Button", "FarmCounterMinimapButton", Minimap)
    minimapBtn:SetFrameStrata("MEDIUM"); minimapBtn:SetSize(31, 31); minimapBtn:SetFrameLevel(8)
    minimapIcon = minimapBtn:CreateTexture(nil, "BACKGROUND"); minimapIcon:SetSize(21, 21); minimapIcon:SetPoint("CENTER")
    local border = minimapBtn:CreateTexture(nil, "OVERLAY")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder"); border:SetSize(53, 53); border:SetPoint("TOPLEFT")
    UpdateMinimapIcon()
    
    local function UpdatePos()
        local a = math.rad(db.minimapPos or 45); local r = 80; local x = math.cos(a) * r; local y = math.sin(a) * r
        minimapBtn:SetPoint("CENTER", Minimap, "CENTER", x, y)
    end
    UpdatePos()
    minimapBtn:RegisterForDrag("RightButton"); minimapBtn:SetMovable(true)
    minimapBtn:SetScript("OnDragStart", function() minimapBtn:SetScript("OnUpdate", function()
        local mx, my = Minimap:GetCenter(); local cx, cy = GetCursorPosition(); local s = Minimap:GetEffectiveScale()
        db.minimapPos = math.deg(math.atan2((cy/s)-my, (cx/s)-mx)); UpdatePos()
    end) end)
    minimapBtn:SetScript("OnDragStop", function() minimapBtn:SetScript("OnUpdate", nil) end)
    minimapBtn:SetScript("OnClick", function(self, b) if b == "LeftButton" then if IsShiftKeyDown() then ToggleFilter() else if FarmFrame:IsShown() then FarmFrame:Hide() else FarmFrame:Show() end end end end)
    minimapBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT"); GameTooltip:AddLine(L["TITLE"].." 7.1")
        GameTooltip:AddLine(L["TOOLTIP_HINT_LEFT"], 1, 1, 1); GameTooltip:AddLine(L["TOOLTIP_HINT_SHIFT"], 0, 1, 0)
        GameTooltip:AddLine(L["TOOLTIP_HINT_RIGHT"], 0.7, 0.7, 0.7); GameTooltip:AddLine(" ")
        local c = BORDER_COLORS[db.filterMode or 1]
        GameTooltip:AddDoubleLine(L["FILTER_CHANGE"], GetFilterName(db.filterMode), 1, 1, 1, c[1], c[2], c[3]); GameTooltip:Show()
    end)
    minimapBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local function GetItemRow(i)
    if not itemRows[i] then
        local r = CreateFrame("Button", nil, Content)
        r:SetHeight(20); r:SetPoint("LEFT", 10, 0); r:SetPoint("RIGHT", -5, 0)
        r.icon = r:CreateTexture(nil, "ARTWORK"); r.icon:SetSize(16, 16); r.icon:SetPoint("LEFT", 0, 0)
        r.count = r:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall"); r.count:SetPoint("RIGHT", r, "RIGHT", -5, 0); r.count:SetJustifyH("RIGHT")
        r.name = r:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall"); r.name:SetPoint("LEFT", r.icon, "RIGHT", 5, 0); r.name:SetPoint("RIGHT", r.count, "LEFT", -5, 0); r.name:SetJustifyH("LEFT"); r.name:SetWordWrap(false)
        r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        r:SetScript("OnClick", function(self, button)
            if not self.itemID then return end
            if button == "LeftButton" then
                local currentGoal = 0; if db.goals and db.goals[self.itemID] then currentGoal = db.goals[self.itemID] end
                local data = { itemID = self.itemID, itemName = self.name:GetText(), currentGoal = currentGoal }
                StaticPopup_Show("FARMCOUNTER_SET_GOAL", data.itemName, nil, data)
            elseif button == "RightButton" then
                if db.goals and db.goals[self.itemID] then db.goals[self.itemID] = nil; sessionGoalMet[self.itemID] = false; print("|cFF00FF00FarmCounter:|r " .. string.format(L["GOAL_REMOVED"], self.name:GetText())); UpdateFarmList() end
            end
        end)
        r:SetScript("OnEnter", function(self) GameTooltip:SetOwner(self, "ANCHOR_TOP"); GameTooltip:SetItemByID(self.itemID); GameTooltip:AddLine(" "); GameTooltip:AddLine(L["TOOLTIP_HINT_ITEM_GOAL"]); GameTooltip:Show() end)
        r:SetScript("OnLeave", function() GameTooltip:Hide() end)
        itemRows[i] = r
    end return itemRows[i]
end

local function GetHeaderRow(i)
    if not headerRows[i] then
        local b = CreateFrame("Button", nil, Content); b:SetHeight(24); b:SetPoint("LEFT"); b:SetPoint("RIGHT")
        b.bg = b:CreateTexture(nil, "BACKGROUND"); b.bg:SetAllPoints(); b.bg:SetColorTexture(0.25, 0.25, 0.25, 0.95)
        b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal"); b.text:SetPoint("LEFT", 5, 0)
        b.status = b:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); b.status:SetPoint("RIGHT", -5, 0)
        b:SetScript("OnClick", function(self) collapsedGroups[self.expacID] = not collapsedGroups[self.expacID]; UpdateFarmList() end)
        headerRows[i] = b
    end return headerRows[i]
end

-- ============================================================================
-- CORE LOGIC - Background Alerting & New Filters
-- ============================================================================
UpdateFarmList = function()
    -- 1. IMMER TASCHEN SCANNEN (Egal ob Fenster offen oder zu)
    local items = {}; local found = false; local mode = db.filterMode or FILTER_ALL
    for bag = 0, 5 do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info then
                local _, _, _, _, _, cid, sub = C_Item.GetItemInfoInstant(info.itemID)
                if cid == 7 then
                    local add = false
                    local isOre, isHerb = (sub == 7), (sub == 9)
                    local isSkin = (sub == 5 or sub == 6)
                    local isWood = (sub == 1 or sub == 11 or sub == 13)
                    local isEnch = (sub == 12); local isCook = (sub == 8)
                    local isElem = (sub == 10)
                    local isGem = (sub == 4)

                    if mode == FILTER_ALL then 
                        if isOre or isHerb or isSkin or isWood or isEnch or isCook or isElem or isGem then add = true end
                    elseif mode == FILTER_ORES and isOre then add = true
                    elseif mode == FILTER_HERBS and isHerb then add = true
                    elseif mode == FILTER_SKINNING and isSkin then add = true
                    elseif mode == FILTER_HOUSING and isWood then add = true
                    elseif mode == FILTER_ENCHANTING and isEnch then add = true
                    elseif mode == FILTER_COOKING and isCook then add = true
                    elseif mode == FILTER_ELEMENTAL and isElem then add = true
                    elseif mode == FILTER_GEMS and isGem then add = true
                    end

                    if add then items[info.itemID] = (items[info.itemID] or 0) + info.stackCount; found = true end
                end
            end
        end
    end

    -- 2. ALARM PRÜFUNG (Läuft auch im Hintergrund)
    if db.goals then
        for id, count in pairs(items) do
            local goal = db.goals[id]
            if goal and goal > 0 then
                if count >= goal then
                    if not sessionGoalMet[id] then
                        local n = C_Item.GetItemInfo(id) or "Item"
                        PlaySound(8959, "Master")
                        RaidNotice_AddMessage(RaidBossEmoteFrame, string.format(L["GOAL_COMPLETED"], n), ChatTypeInfo["RAID_WARNING"])
                        print("|cFF00FF00FarmCounter:|r " .. string.format(L["GOAL_COMPLETED"], n))
                        sessionGoalMet[id] = true
                    end
                else
                    sessionGoalMet[id] = false
                end
            end
        end
    end

    -- 3. VISUALS ABBRECHEN, wenn Fenster zu
    if not FarmFrame:IsShown() then return end

    for _, r in pairs(itemRows) do r:Hide() end; for _, h in pairs(headerRows) do h:Hide() end
    if not found then local r = GetItemRow(1); r.icon:SetTexture(nil); r.count:SetText(""); r.name:SetText(L["NOTHING_FOUND"]); r:SetPoint("TOPLEFT", Content, "TOPLEFT", 0, 0); r:Show(); return end
    
    local groups, miss = {}, false
    for id, count in pairs(items) do
        local n, _, q, _, _, _, _, _, _, i, _, _, _, _, eid = C_Item.GetItemInfo(id); local te = eid or 0
        if not n then miss = true; local _,_,_,_,ii = C_Item.GetItemInfoInstant(id); table.insert(groups, {id=-1, items={}}); n=L["LOADING"]; i=ii end
        if not groups[te] then groups[te] = {id = te, items = {}} end
        table.insert(groups[te].items, {id=id, count=count, name=n, quality=q or 1, icon=i})
    end
    
    local sorted = {}; for _, g in pairs(groups) do table.insert(sorted, g) end
    table.sort(sorted, function(a, b) return a.id > b.id end)
    
    local y = 0; local hi, ri = 1, 1
    for _, g in ipairs(sorted) do
        local h = GetHeaderRow(hi); h.expacID = g.id
        h.text:SetText(L["EXP_"..g.id] or ("ID "..g.id))
        h.status:SetText(collapsedGroups[g.id] and "+" or "-"); h:SetPoint("TOPLEFT", Content, "TOPLEFT", 0, y); h:Show(); y = y - 25; hi = hi + 1
        if not collapsedGroups[g.id] then
            table.sort(g.items, function(a, b) return a.name < b.name end)
            for _, item in ipairs(g.items) do
                local r = GetItemRow(ri); r.itemID = item.id
                r.icon:SetTexture(item.icon); r.name:SetText(item.name)
                
                local goal = (db.goals and db.goals[item.id]) or 0
                if goal > 0 then
                    r.count:SetText(item.count .. " / " .. goal)
                    if item.count >= goal then r.count:SetTextColor(0, 1, 0) else r.count:SetTextColor(1, 1, 1) end
                else
                    r.count:SetText(item.count); r.count:SetTextColor(1, 1, 1)
                end
                
                local rc, gc, bc = C_Item.GetItemQualityColor(item.quality); r.name:SetTextColor(rc, gc, bc)
                r:SetPoint("TOPLEFT", Content, "TOPLEFT", 0, y); r:Show(); y = y - 20; ri = ri + 1
            end y = y - 5
        end
    end
    Content:SetHeight(math.abs(y) + 20)
    if miss then FarmFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED") else FarmFrame:UnregisterEvent("GET_ITEM_INFO_RECEIVED") end
end

FarmFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        if not FarmCounterDB then FarmCounterDB = {} end; db = FarmCounterDB
        if not db.minimapPos then db.minimapPos = 45 end
        if not db.filterMode then db.filterMode = 1 end
        if not db.width then db.width = 340 end; if not db.height then db.height = 520 end
        if db.isVisible == nil then db.isVisible = false end
        if not db.goals then db.goals = {} end
        
        FarmFrame:SetSize(db.width, db.height)
        if db.point then FarmFrame:ClearAllPoints(); FarmFrame:SetPoint(db.point, UIParent, db.relativePoint, db.x, db.y) else FarmFrame:SetPoint("CENTER") end
        InitMinimapButton(); UpdateBorderColor()
        if db.isVisible then FarmFrame:Show() else FarmFrame:Hide() end
        print("|cFF00FF00FarmCounter 7.1|r " .. L["LOADED"])
    
    elseif event == "BAG_UPDATE" then 
        UpdateFarmList()
        
    elseif event == "GET_ITEM_INFO_RECEIVED" then UpdateFarmList() end
end)
FarmFrame:RegisterEvent("ADDON_LOADED"); FarmFrame:RegisterEvent("BAG_UPDATE")

SLASH_FARMCOUNTER1 = "/fc"
SlashCmdList["FARMCOUNTER"] = function(msg)
    if msg == "debug" then 
        local _, link = GameTooltip:GetItem()
        if link then
            local itemID, _, _, _, _, classID, subClassID = C_Item.GetItemInfoInstant(link)
            print("|cFF00FF00FarmCounter Debug:|r")
            print("Item: " .. link)
            print("ItemID: " .. (itemID or "Unknown"))
            print("ClassID: " .. (classID or "Unknown") .. " (Must be 7)")
            print("SubClassID: " .. (subClassID or "Unknown"))
        else
            print("|cFF00FF00FarmCounter:|r Mouseover an item to debug.")
        end
    else 
        if FarmFrame:IsShown() then FarmFrame:Hide() else FarmFrame:Show() end 
    end
end