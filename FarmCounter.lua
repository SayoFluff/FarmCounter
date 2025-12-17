-- ============================================================================
-- FARMCOUNTER 4.0 - Persistence Update (Save State & Position)
-- ============================================================================

local addonName, addonTable = ...

-- ----------------------------------------------------------------------------
-- 1. Variablen & Konfiguration
-- ----------------------------------------------------------------------------
local EXPANSION_NAMES = {
    [0] = "Classic", [1] = "The Burning Crusade", [2] = "Wrath of the Lich King",
    [3] = "Cataclysm", [4] = "Mists of Pandaria", [5] = "Warlords of Draenor",
    [6] = "Legion", [7] = "Battle for Azeroth", [8] = "Shadowlands",
    [9] = "Dragonflight", [10] = "The War Within", [-1] = "Lade Daten..."
}

-- Filter Konstanten
local FILTER_ALL = 1
local FILTER_ORES = 2
local FILTER_HERBS = 3
local FILTER_SKINNING = 4
local FILTER_HOUSING = 5

-- Farben für die Rahmen
local BORDER_COLORS = {
    [FILTER_ALL]      = {1.0, 0.85, 0.0}, -- Gold
    [FILTER_ORES]     = {1.0, 0.3, 0.2},  -- Rot
    [FILTER_HERBS]    = {0.2, 1.0, 0.2},  -- Grün
    [FILTER_SKINNING] = {0.6, 0.4, 0.2},  -- Braun
    [FILTER_HOUSING]  = {0.0, 0.7, 1.0}   -- Blau
}

local db -- Datenbank Referenz
local collapsedGroups = {}
local itemRows = {}
local headerRows = {}
local UpdateFarmList, UpdateMinimapIcon, UpdateBorderColor

-- ----------------------------------------------------------------------------
-- 2. Hauptfenster Design
-- ----------------------------------------------------------------------------
local FarmFrame = CreateFrame("Frame", "FarmCounterMainFrame", UIParent)
FarmFrame:SetFrameStrata("HIGH")
FarmFrame:SetMovable(true)
FarmFrame:EnableMouse(true)
FarmFrame:SetClampedToScreen(true)
FarmFrame:SetResizable(true)
FarmFrame:SetResizeBounds(250, 200, 800, 1000)
FarmFrame:Hide() -- Standardmäßig versteckt, wird beim Laden geprüft

-- Hintergrund
FarmFrame.bg = FarmFrame:CreateTexture(nil, "BACKGROUND")
FarmFrame.bg:SetAllPoints()
FarmFrame.bg:SetColorTexture(0.05, 0.05, 0.05, 0.85)

-- Rahmen speichern
FarmFrame.borderLines = {}
local function CreateLine(point, relativePoint, x, y, w, h)
    local l = FarmFrame:CreateTexture(nil, "BORDER")
    l:SetColorTexture(1, 0.85, 0, 1)
    if w then l:SetWidth(w) else l:SetPoint("LEFT"); l:SetPoint("RIGHT") end
    if h then l:SetHeight(h) else l:SetPoint("TOP"); l:SetPoint("BOTTOM") end
    l:SetPoint(point, FarmFrame, relativePoint, x, y)
    table.insert(FarmFrame.borderLines, l)
end
CreateLine("TOPLEFT", "TOPLEFT", 0, 0, nil, 2)
CreateLine("BOTTOMLEFT", "BOTTOMLEFT", 0, 0, nil, 2)
CreateLine("TOPLEFT", "TOPLEFT", 0, 0, 2, nil)
CreateLine("TOPRIGHT", "TOPRIGHT", 0, 0, 2, nil)

-- Titel
local TitleBar = CreateFrame("Frame", nil, FarmFrame)
TitleBar:SetHeight(30)
TitleBar:SetPoint("TOPLEFT", 2, -2); TitleBar:SetPoint("TOPRIGHT", -2, -2)
TitleBar.bg = TitleBar:CreateTexture(nil, "BACKGROUND")
TitleBar.bg:SetAllPoints(); TitleBar.bg:SetColorTexture(0.2, 0.2, 0.2, 1)
TitleBar.text = TitleBar:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
TitleBar.text:SetPoint("CENTER"); TitleBar.text:SetText("FarmCounter")
TitleBar.text:SetTextColor(1, 0.8, 0.4)

-- Dragging Logik (Speichert Position)
TitleBar:EnableMouse(true)
TitleBar:RegisterForDrag("LeftButton")
TitleBar:SetScript("OnDragStart", function() FarmFrame:StartMoving() end)
TitleBar:SetScript("OnDragStop", function() 
    FarmFrame:StopMovingOrSizing()
    -- Position speichern
    local point, _, relativePoint, x, y = FarmFrame:GetPoint()
    db.point = point
    db.relativePoint = relativePoint
    db.x = x
    db.y = y
end)

-- Schließen
local CloseBtn = CreateFrame("Button", nil, TitleBar, "UIPanelCloseButton")
CloseBtn:SetPoint("RIGHT", -2, 0)
CloseBtn:SetScript("OnClick", function() FarmFrame:Hide() end)

-- Resizing Logik (Speichert Größe)
local ResizeBtn = CreateFrame("Button", nil, FarmFrame)
ResizeBtn:SetSize(16, 16)
ResizeBtn:SetPoint("BOTTOMRIGHT", -2, 2)
ResizeBtn:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
ResizeBtn:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
ResizeBtn:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
ResizeBtn:SetScript("OnMouseDown", function() FarmFrame:StartSizing("BOTTOMRIGHT") end)
ResizeBtn:SetScript("OnMouseUp", function() 
    FarmFrame:StopMovingOrSizing()
    -- Größe speichern
    db.width = FarmFrame:GetWidth()
    db.height = FarmFrame:GetHeight()
end)

-- Scroll Bereich
local ScrollFrame = CreateFrame("ScrollFrame", nil, FarmFrame, "UIPanelScrollFrameTemplate")
ScrollFrame:SetPoint("TOPLEFT", 10, -40)
ScrollFrame:SetPoint("BOTTOMRIGHT", -30, 25)
local Content = CreateFrame("Frame", nil, ScrollFrame)
Content:SetSize(1, 1)
ScrollFrame:SetScrollChild(Content)
ScrollFrame:SetScript("OnSizeChanged", function(self) Content:SetWidth(self:GetWidth()) end)

-- Sichtbarkeit speichern
FarmFrame:SetScript("OnShow", function() 
    if db then db.isVisible = true end
    UpdateFarmList()
end)
FarmFrame:SetScript("OnHide", function() 
    if db then db.isVisible = false end
end)

-- ----------------------------------------------------------------------------
-- 3. Logik: Farben & Filter
-- ----------------------------------------------------------------------------
UpdateBorderColor = function()
    local mode = db.filterMode or FILTER_ALL
    local color = BORDER_COLORS[mode] or BORDER_COLORS[FILTER_ALL]
    for _, line in ipairs(FarmFrame.borderLines) do
        line:SetColorTexture(color[1], color[2], color[3], 1)
    end
end

local function GetFilterName(mode)
    if mode == FILTER_ALL then return "Alles (Gesamt)" end
    if mode == FILTER_ORES then return "Nur Erze" end
    if mode == FILTER_HERBS then return "Nur Kräuter" end
    if mode == FILTER_SKINNING then return "Leder & Stoffe" end
    if mode == FILTER_HOUSING then return "Hölzer & Mat." end
    return "Unbekannt"
end

local function ToggleFilter()
    db.filterMode = db.filterMode + 1
    if db.filterMode > 5 then db.filterMode = 1 end
    UpdateMinimapIcon()
    UpdateBorderColor()
    UpdateFarmList()
    print("|cFF00FF00FarmCounter:|r Filter: " .. GetFilterName(db.filterMode))
end

-- ----------------------------------------------------------------------------
-- 4. Minimap Button
-- ----------------------------------------------------------------------------
local minimapBtn, minimapIcon

UpdateMinimapIcon = function()
    if not minimapIcon then return end
    if db.filterMode == FILTER_ORES then minimapIcon:SetTexture("Interface\\Icons\\inv_ore_copper_01")
    elseif db.filterMode == FILTER_HERBS then minimapIcon:SetTexture("Interface\\Icons\\inv_misc_herb_dreamfoil")
    elseif db.filterMode == FILTER_SKINNING then minimapIcon:SetTexture("Interface\\Icons\\inv_misc_leatherscrap_02")
    elseif db.filterMode == FILTER_HOUSING then minimapIcon:SetTexture("Interface\\Icons\\inv_tradeskillitem_01")
    else minimapIcon:SetTexture("Interface\\Icons\\inv_misc_bag_10") end
end

local function InitMinimapButton()
    minimapBtn = CreateFrame("Button", "FarmCounterMinimapButton", Minimap)
    minimapBtn:SetFrameStrata("MEDIUM"); minimapBtn:SetSize(31, 31); minimapBtn:SetFrameLevel(8)
    minimapIcon = minimapBtn:CreateTexture(nil, "BACKGROUND")
    minimapIcon:SetSize(21, 21); minimapIcon:SetPoint("CENTER")
    local border = minimapBtn:CreateTexture(nil, "OVERLAY")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder"); border:SetSize(53, 53); border:SetPoint("TOPLEFT")
    
    UpdateMinimapIcon()

    local function UpdatePos()
        local angle = math.rad(db.minimapPos or 45)
        local x = 52 - (80 * math.cos(angle))
        local y = (80 * math.sin(angle)) - 52
        minimapBtn:SetPoint("TOPLEFT", Minimap, "TOPLEFT", x, y)
    end
    UpdatePos()

    minimapBtn:RegisterForDrag("RightButton")
    minimapBtn:SetMovable(true)
    minimapBtn:SetScript("OnDragStart", function()
        minimapBtn:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            local angle = math.deg(math.atan2((cy/scale) - my, (cx/scale) - mx))
            db.minimapPos = angle
            UpdatePos()
        end)
    end)
    minimapBtn:SetScript("OnDragStop", function() minimapBtn:SetScript("OnUpdate", nil) end)
    
    minimapBtn:SetScript("OnClick", function(self, button)
        if button == "LeftButton" then
            if IsShiftKeyDown() then ToggleFilter()
            else if FarmFrame:IsShown() then FarmFrame:Hide() else FarmFrame:Show() end end
        end
    end)
    
    minimapBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("FarmCounter 4.0")
        local c = BORDER_COLORS[db.filterMode or 1]
        GameTooltip:AddDoubleLine("Filter:", GetFilterName(db.filterMode), 1, 1, 1, c[1], c[2], c[3])
        GameTooltip:Show()
    end)
    minimapBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-- ----------------------------------------------------------------------------
-- 5. Scan & Listen Logik
-- ----------------------------------------------------------------------------
local function GetItemRow(index)
    if not itemRows[index] then
        local row = CreateFrame("Frame", nil, Content)
        row:SetHeight(20); row:SetPoint("LEFT", 10, 0); row:SetPoint("RIGHT", -5, 0)
        row.icon = row:CreateTexture(nil, "ARTWORK"); row.icon:SetSize(16, 16); row.icon:SetPoint("LEFT", 0, 0)
        row.count = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.count:SetPoint("LEFT", row.icon, "RIGHT", 5, 0); row.count:SetWidth(40); row.count:SetJustifyH("RIGHT")
        row.name = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        row.name:SetPoint("LEFT", row.count, "RIGHT", 10, 0); row.name:SetPoint("RIGHT", row, "RIGHT", 0, 0); row.name:SetJustifyH("LEFT")
        itemRows[index] = row
    end
    return itemRows[index]
end

local function GetHeaderRow(index)
    if not headerRows[index] then
        local btn = CreateFrame("Button", nil, Content)
        btn:SetHeight(24); btn:SetPoint("LEFT"); btn:SetPoint("RIGHT")
        btn.bg = btn:CreateTexture(nil, "BACKGROUND"); btn.bg:SetAllPoints(); btn.bg:SetColorTexture(0.25, 0.25, 0.25, 0.95)
        btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormal"); btn.text:SetPoint("LEFT", 5, 0)
        btn.status = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlight"); btn.status:SetPoint("RIGHT", -5, 0)
        btn:SetScript("OnClick", function(self) collapsedGroups[self.expacID] = not collapsedGroups[self.expacID]; UpdateFarmList() end)
        headerRows[index] = btn
    end
    return headerRows[index]
end

UpdateFarmList = function()
    if not FarmFrame:IsShown() then return end
    local items = {}
    local foundItems = false
    local currentFilter = db.filterMode or FILTER_ALL

    for bag = 0, 5 do
        local slots = C_Container.GetContainerNumSlots(bag)
        for slot = 1, slots do
            local info = C_Container.GetContainerItemInfo(bag, slot)
            if info then
                local _, _, _, _, _, classID, subClassID = C_Item.GetItemInfoInstant(info.itemID)
                if classID == 7 then
                    local isOre = (subClassID == 7)
                    local isHerb = (subClassID == 9)
                    local isCloth = (subClassID == 5)
                    local isLeather = (subClassID == 6)
                    local isWood = (subClassID == 1 or subClassID == 11 or subClassID == 13) 
                    local shouldAdd = false
                    if currentFilter == FILTER_ALL then if isOre or isHerb or isCloth or isLeather or isWood then shouldAdd = true end
                    elseif currentFilter == FILTER_ORES then if isOre then shouldAdd = true end
                    elseif currentFilter == FILTER_HERBS then if isHerb then shouldAdd = true end
                    elseif currentFilter == FILTER_SKINNING then if isCloth or isLeather then shouldAdd = true end
                    elseif currentFilter == FILTER_HOUSING then if isWood then shouldAdd = true end end

                    if shouldAdd then items[info.itemID] = (items[info.itemID] or 0) + info.stackCount; foundItems = true end
                end
            end
        end
    end

    for _, row in pairs(itemRows) do row:Hide() end
    for _, header in pairs(headerRows) do header:Hide() end

    if not foundItems then
        local row = GetItemRow(1)
        row.icon:SetTexture(nil); row.count:SetText(""); row.name:SetText("Nichts gefunden.")
        row:SetPoint("TOPLEFT", Content, "TOPLEFT", 0, 0); row:Show()
        return
    end

    local groups, missingData = {}, false
    for itemID, count in pairs(items) do
        local name, _, quality, _, _, _, _, _, _, icon, _, _, _, _, expID = C_Item.GetItemInfo(itemID)
        local targetExp = expID or 0
        if not name then
            missingData = true
            local _, _, _, _, iconInstant = C_Item.GetItemInfoInstant(itemID)
            table.insert(groups, { id = -1, items = {} })
            name = "Lade..."; icon = iconInstant
        end
        if not groups[targetExp] then groups[targetExp] = { id = targetExp, items = {} } end
        table.insert(groups[targetExp].items, { id = itemID, count = count, name = name, quality = quality or 1, icon = icon })
    end

    local sortedGroups = {}
    for _, g in pairs(groups) do table.insert(sortedGroups, g) end
    table.sort(sortedGroups, function(a, b) return a.id > b.id end)

    local yOffset = 0; local hIdx, iIdx = 1, 1
    for _, group in ipairs(sortedGroups) do
        local header = GetHeaderRow(hIdx)
        header.expacID = group.id
        header.text:SetText(EXPANSION_NAMES[group.id] or ("ID " .. group.id))
        header.status:SetText(collapsedGroups[group.id] and "+" or "-")
        header:SetPoint("TOPLEFT", Content, "TOPLEFT", 0, yOffset); header:Show()
        yOffset = yOffset - 25; hIdx = hIdx + 1

        if not collapsedGroups[group.id] then
            table.sort(group.items, function(a, b) return a.name < b.name end)
            for _, item in ipairs(group.items) do
                local row = GetItemRow(iIdx)
                row.icon:SetTexture(item.icon); row.count:SetText(item.count); row.name:SetText(item.name)
                local r, g, b = C_Item.GetItemQualityColor(item.quality); row.name:SetTextColor(r, g, b)
                row:SetPoint("TOPLEFT", Content, "TOPLEFT", 0, yOffset); row:Show()
                yOffset = yOffset - 20; iIdx = iIdx + 1
            end
            yOffset = yOffset - 5
        end
    end
    Content:SetHeight(math.abs(yOffset) + 20)
    if missingData then FarmFrame:RegisterEvent("GET_ITEM_INFO_RECEIVED") else FarmFrame:UnregisterEvent("GET_ITEM_INFO_RECEIVED") end
end

-- ----------------------------------------------------------------------------
-- 6. Initialisierung (RESTORE STATE)
-- ----------------------------------------------------------------------------
FarmFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        -- 1. Datenbank Defaults setzen
        if not FarmCounterDB then FarmCounterDB = {} end
        db = FarmCounterDB
        
        -- Default Werte falls Schlüssel fehlen
        if not db.minimapPos then db.minimapPos = 45 end
        if not db.filterMode then db.filterMode = 1 end
        if not db.width then db.width = 340 end
        if not db.height then db.height = 520 end
        if db.isVisible == nil then db.isVisible = false end

        -- 2. Layout Wiederherstellen (Position & Größe)
        FarmFrame:SetSize(db.width, db.height)
        if db.point and db.x and db.y then
            FarmFrame:ClearAllPoints()
            -- relativePoint fallback, falls nil
            FarmFrame:SetPoint(db.point, UIParent, db.relativePoint or "CENTER", db.x, db.y)
        else
            FarmFrame:SetPoint("CENTER") -- Erster Start
        end

        -- 3. Komponenten Initialisieren
        InitMinimapButton()
        UpdateBorderColor()

        -- 4. Sichtbarkeit Wiederherstellen
        if db.isVisible then
            FarmFrame:Show()
        else
            FarmFrame:Hide()
        end

        print("|cFF00FF00FarmCounter 4.0|r geladen.")
    elseif event == "BAG_UPDATE" and self:IsShown() then
        UpdateFarmList()
    elseif event == "GET_ITEM_INFO_RECEIVED" then
        UpdateFarmList()
    end
end)
FarmFrame:RegisterEvent("ADDON_LOADED")
FarmFrame:RegisterEvent("BAG_UPDATE")
-- Slash Commands
SLASH_FARMCOUNTER1 = "/fc"
SlashCmdList["FARMCOUNTER"] = function(msg)
    if msg == "debug" then print("Debug: Mouseover Item.")
    else if FarmFrame:IsShown() then FarmFrame:Hide() else FarmFrame:Show() end end
end