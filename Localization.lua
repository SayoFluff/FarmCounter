local addonName, addonTable = ...

-- Tabelle erstellen
local L = {}

-- ============================================================================
-- 1. ENGLISH (Default / Fallback)
-- ============================================================================
L["TITLE"] = "FarmCounter"
L["LOADED"] = "loaded. /fc debug to check ItemID."
L["NOTHING_FOUND"] = "No items found for this filter."
L["LOADING"] = "Loading..."
L["FILTER_CHANGE"] = "Filter:"

L["FILTER_ALL"] = "All (Summary)"
L["FILTER_ORES"] = "Ores & Stone"
L["FILTER_HERBS"] = "Herbs"
L["FILTER_SKINNING"] = "Leather & Cloth"
L["FILTER_HOUSING"] = "Wood & Parts"
L["FILTER_ENCHANTING"] = "Enchanting"
L["FILTER_COOKING"] = "Meat & Fish"

L["TOOLTIP_HINT_LEFT"] = "Left Click: Open/Close"
L["TOOLTIP_HINT_SHIFT"] = "Shift + Click: Change Filter"
L["TOOLTIP_HINT_RIGHT"] = "Right Click: Move Button"

L["EXP_0"] = "Classic"
L["EXP_1"] = "The Burning Crusade"
L["EXP_2"] = "Wrath of the Lich King"
L["EXP_3"] = "Cataclysm"
L["EXP_4"] = "Mists of Pandaria"
L["EXP_5"] = "Warlords of Draenor"
L["EXP_6"] = "Legion"
L["EXP_7"] = "Battle for Azeroth"
L["EXP_8"] = "Shadowlands"
L["EXP_9"] = "Dragonflight"
L["EXP_10"] = "The War Within"
L["EXP_11"] = "Midnight"

-- ============================================================================
-- 2. GERMAN (Deutsch)
-- ============================================================================
if GetLocale() == "deDE" then
    L["TITLE"] = "FarmCounter"
    L["LOADED"] = "geladen. /fc debug für Item-Infos."
    L["NOTHING_FOUND"] = "Keine Items für diesen Filter."
    L["LOADING"] = "Lade Daten..."
    L["FILTER_CHANGE"] = "Filter:"

    L["FILTER_ALL"] = "Alles (Gesamt)"
    L["FILTER_ORES"] = "Nur Erze & Steine"
    L["FILTER_HERBS"] = "Nur Kräuter"
    L["FILTER_SKINNING"] = "Leder & Stoffe"
    L["FILTER_HOUSING"] = "Hölzer & Mat."
    L["FILTER_ENCHANTING"] = "Verzauberkunst"
    L["FILTER_COOKING"] = "Fleisch & Fisch"

    L["TOOLTIP_HINT_LEFT"] = "Links: Öffnen/Schließen"
    L["TOOLTIP_HINT_SHIFT"] = "Shift + Klick: Filter ändern"
    L["TOOLTIP_HINT_RIGHT"] = "Rechts: Button verschieben"
end

-- ============================================================================
-- 3. FRENCH (Français)
-- ============================================================================
if GetLocale() == "frFR" then
    L["LOADED"] = "chargé. /fc debug pour info Item."
    L["NOTHING_FOUND"] = "Aucun objet trouvé."
    L["LOADING"] = "Chargement..."
    L["FILTER_CHANGE"] = "Filtre:"

    L["FILTER_ALL"] = "Tout (Résumé)"
    L["FILTER_ORES"] = "Minerais & Pierres"
    L["FILTER_HERBS"] = "Herbes"
    L["FILTER_SKINNING"] = "Cuir & Tissu"
    L["FILTER_HOUSING"] = "Bois & Matériaux"
    L["FILTER_ENCHANTING"] = "Enchantement"
    L["FILTER_COOKING"] = "Viande & Poisson"

    L["TOOLTIP_HINT_LEFT"] = "Clic Gauche: Ouvrir/Fermer"
    L["TOOLTIP_HINT_SHIFT"] = "Shift + Clic: Changer Filtre"
    L["TOOLTIP_HINT_RIGHT"] = "Clic Droit: Déplacer"
end

-- ============================================================================
-- 4. SPANISH (Español)
-- ============================================================================
if GetLocale() == "esES" or GetLocale() == "esMX" then
    L["LOADED"] = "cargado. /fc debug para info."
    L["NOTHING_FOUND"] = "No se encontraron objetos."
    L["LOADING"] = "Cargando..."
    L["FILTER_CHANGE"] = "Filtro:"

    L["FILTER_ALL"] = "Todo (Resumen)"
    L["FILTER_ORES"] = "Minerales & Piedras"
    L["FILTER_HERBS"] = "Hierbas"
    L["FILTER_SKINNING"] = "Cuero & Tela"
    L["FILTER_HOUSING"] = "Madera & Materiales"
    L["FILTER_ENCHANTING"] = "Encantamiento"
    L["FILTER_COOKING"] = "Carne & Pescado"

    L["TOOLTIP_HINT_LEFT"] = "Clic Izquierdo: Abrir/Cerrar"
    L["TOOLTIP_HINT_SHIFT"] = "Mayús + Clic: Cambiar Filtro"
    L["TOOLTIP_HINT_RIGHT"] = "Clic Derecho: Mover"
end

-- ============================================================================
-- 5. ITALIAN (Italiano)
-- ============================================================================
if GetLocale() == "itIT" then
    L["LOADED"] = "caricato. /fc debug per info oggetto."
    L["NOTHING_FOUND"] = "Nessun oggetto trovato."
    L["LOADING"] = "Caricamento..."
    L["FILTER_CHANGE"] = "Filtro:"

    L["FILTER_ALL"] = "Tutto (Riepilogo)"
    L["FILTER_ORES"] = "Minerali & Pietre"
    L["FILTER_HERBS"] = "Erbe"
    L["FILTER_SKINNING"] = "Cuoio & Stoffa"
    L["FILTER_HOUSING"] = "Legname & Materiali"
    L["FILTER_ENCHANTING"] = "Incantamento"
    L["FILTER_COOKING"] = "Carne & Pesce"

    L["TOOLTIP_HINT_LEFT"] = "Clic Sinistro: Apri/Chiudi"
    L["TOOLTIP_HINT_SHIFT"] = "Maiusc + Clic: Cambia Filtro"
    L["TOOLTIP_HINT_RIGHT"] = "Clic Destro: Sposta"
end

-- ============================================================================
-- 6. RUSSIAN (Translator ZamestoTV)
-- ============================================================================
if GetLocale() == "ruRU" then
   L["LOADED"] = "загружено. /fc debug для проверки ID предмета."
   L["NOTHING_FOUND"] = "Предметы для этого фильтра не найдены."
   L["LOADING"] = "Загрузка..."
   L["FILTER_CHANGE"] = "Фильтр:"

   L["FILTER_ALL"] = "Все (Итог)"
   L["FILTER_ORES"] = "Руды и камень"
   L["FILTER_HERBS"] = "Травы"
   L["FILTER_SKINNING"] = "Кожа и ткань"
   L["FILTER_HOUSING"] = "Древесина и детали"
   L["FILTER_ENCHANTING"] = "Зачарование"
   L["FILTER_COOKING"] = "Мясо и рыба"

   L["TOOLTIP_HINT_LEFT"] = "ЛКМ: Открыть/Закрыть"
   L["TOOLTIP_HINT_SHIFT"] = "Shift + Клик: Сменить фильтр"
   L["TOOLTIP_HINT_RIGHT"] = "ПКМ: Переместить кнопку"
end

-- Tabelle bereitstellen
addonTable.L = L
