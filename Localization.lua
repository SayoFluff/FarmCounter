local addonName, addonTable = ...
local L = {}

-- ============================================================================
-- 1. ENGLISH (Default)
-- ============================================================================
L["TITLE"] = "FarmCounter"
L["LOADED"] = "loaded. Left-Click item to set goal."
L["NOTHING_FOUND"] = "No items found for this filter."
L["LOADING"] = "Loading..."
L["FILTER_CHANGE"] = "Filter:"

L["GOAL_POPUP_TEXT"] = "Enter target amount for:\n%s"
L["GOAL_SET"] = "Goal set for %s: %s"       -- NEU
L["GOAL_COMPLETED"] = "Goal Reached: %s!"
L["GOAL_REMOVED"] = "Goal removed for: %s"
L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Left Click:|r Set Goal\n|cFFFF0000Right Click:|r Remove Goal"

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

L["EXP_0"] = "Classic"; L["EXP_1"] = "The Burning Crusade"; L["EXP_2"] = "Wrath of the Lich King"
L["EXP_3"] = "Cataclysm"; L["EXP_4"] = "Mists of Pandaria"; L["EXP_5"] = "Warlords of Draenor"
L["EXP_6"] = "Legion"; L["EXP_7"] = "Battle for Azeroth"; L["EXP_8"] = "Shadowlands"
L["EXP_9"] = "Dragonflight"; L["EXP_10"] = "The War Within"; L["EXP_11"] = "Midnight"

-- ============================================================================
-- 2. GERMAN (Deutsch)
-- ============================================================================
if GetLocale() == "deDE" then
    L["TITLE"] = "FarmCounter"
    L["LOADED"] = "geladen. Linksklick auf Item für Ziel-Alarm."
    L["NOTHING_FOUND"] = "Keine Items für diesen Filter."
    L["LOADING"] = "Lade Daten..."
    L["FILTER_CHANGE"] = "Filter:"

    L["GOAL_POPUP_TEXT"] = "Ziel-Menge eingeben für:\n%s"
    L["GOAL_SET"] = "Ziel gesetzt für %s: %s"   -- NEU
    L["GOAL_COMPLETED"] = "Ziel erreicht: %s!"
    L["GOAL_REMOVED"] = "Ziel entfernt für: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Linksklick:|r Ziel setzen\n|cFFFF0000Rechtsklick:|r Ziel löschen"

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
    L["LOADED"] = "chargé."
    L["NOTHING_FOUND"] = "Aucun objet trouvé."
    L["LOADING"] = "Chargement..."
    L["FILTER_CHANGE"] = "Filtre:"
    L["GOAL_POPUP_TEXT"] = "Objectif pour:\n%s"
    L["GOAL_SET"] = "Objectif défini pour %s: %s" -- NEU
    L["GOAL_COMPLETED"] = "Objectif atteint: %s!"
    L["GOAL_REMOVED"] = "Objectif supprimé: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Clic Gauche:|r Définir\n|cFFFF0000Clic Droit:|r Supprimer"

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
    L["LOADED"] = "cargado."
    L["NOTHING_FOUND"] = "No se encontraron objetos."
    L["LOADING"] = "Cargando..."
    L["FILTER_CHANGE"] = "Filtro:"
    L["GOAL_POPUP_TEXT"] = "Objetivo para:\n%s"
    L["GOAL_SET"] = "Objetivo establecido para %s: %s" -- NEU
    L["GOAL_COMPLETED"] = "Objetivo completado: %s!"
    L["GOAL_REMOVED"] = "Objetivo eliminado: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Clic Izq:|r Fijar\n|cFFFF0000Clic Der:|r Borrar"

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
    L["LOADED"] = "caricato."
    L["NOTHING_FOUND"] = "Nessun oggetto trovato."
    L["LOADING"] = "Caricamento..."
    L["FILTER_CHANGE"] = "Filtro:"
    L["GOAL_POPUP_TEXT"] = "Obiettivo per:\n%s"
    L["GOAL_SET"] = "Obiettivo impostato per %s: %s" -- NEU
    L["GOAL_COMPLETED"] = "Obiettivo raggiunto: %s!"
    L["GOAL_REMOVED"] = "Obiettivo rimosso: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Clic Sinistro:|r Imposta\n|cFFFF0000Clic Destro:|r Rimuovi"

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
-- 6. RUSSIAN (Translator: ZamestoTV)
-- ============================================================================
if GetLocale() == "ruRU" then
    L["LOADED"] = "загружено. ЛКМ по предмету для настройки цели."
    L["NOTHING_FOUND"] = "Предметы для этого фильтра не найдены."
    L["LOADING"] = "Загрузка..."
    L["FILTER_CHANGE"] = "Фильтр:"

    -- New Goal System
    L["GOAL_POPUP_TEXT"] = "Введите количество для:\n%s"
    L["GOAL_SET"] = "Цель установлена для %s: %s"
    L["GOAL_COMPLETED"] = "Цель достигнута: %s!"
    L["GOAL_REMOVED"] = "Цель удалена для: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00ЛКМ:|r Задать цель\n|cFFFF0000ПКМ:|r Удалить цель"

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
addonTable.L = L