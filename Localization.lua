local addonName, addonTable = ...
local L = {}

-- ============================================================================
-- 1. ENGLISH (Default) - Enthält alle Standards
-- ============================================================================
L["TITLE"] = "FarmCounter"
L["LOADED"] = "loaded. Left-Click item to set goal."
L["NOTHING_FOUND"] = "No items found for this filter."
L["LOADING"] = "Loading..."
L["FILTER_CHANGE"] = "Filter:"

L["GOAL_POPUP_TEXT"] = "Enter target amount for:\n%s"
L["GOAL_SET"] = "Goal set for %s: %s"
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
L["FILTER_ELEMENTAL"] = "Elementals"
L["FILTER_GEMS"] = "Gems"

L["TOOLTIP_HINT_LEFT"] = "Left Click: Open/Close"
L["TOOLTIP_HINT_MENU"] = "Right Click: Select Filter"
L["TOOLTIP_HINT_DRAG"] = "Right Click + Drag: Move Button"

-- Standard Expansions (Fallback für DE, FR, ES, IT, RU, PT)
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
    L["LOADED"] = "geladen. Linksklick auf Item für Ziel-Alarm."
    L["NOTHING_FOUND"] = "Keine Items für diesen Filter."
    L["LOADING"] = "Lade Daten..."
    L["FILTER_CHANGE"] = "Filter:"

    L["GOAL_POPUP_TEXT"] = "Ziel-Menge eingeben für:\n%s"
    L["GOAL_SET"] = "Ziel gesetzt für %s: %s"
    L["GOAL_COMPLETED"] = "Ziel erreicht: %s!"
    L["GOAL_REMOVED"] = "Ziel entfernt für: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Linksklick:|r Ziel setzen\n|cFFFF0000Rechtsklick:|r Ziel löschen"

    L["FILTER_ALL"] = "Alles (Gesamt)"
    L["FILTER_ORES"] = "Erze & Steine"
    L["FILTER_HERBS"] = "Kräuter"
    L["FILTER_SKINNING"] = "Leder & Stoffe"
    L["FILTER_HOUSING"] = "Hölzer & Teile"
    L["FILTER_ENCHANTING"] = "Verzauberkunst"
    L["FILTER_COOKING"] = "Fleisch & Fisch"
    L["FILTER_ELEMENTAL"] = "Elementare"
    L["FILTER_GEMS"] = "Edelsteine"

    L["TOOLTIP_HINT_LEFT"] = "Links: Öffnen/Schließen"
    L["TOOLTIP_HINT_MENU"] = "Rechts: Filter auswählen"
    L["TOOLTIP_HINT_DRAG"] = "Rechts + Ziehen: Verschieben"
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
    L["GOAL_SET"] = "Objectif défini pour %s: %s"
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
    L["FILTER_ELEMENTAL"] = "Élémentaires"
    L["FILTER_GEMS"] = "Gemmes"

    L["TOOLTIP_HINT_LEFT"] = "Clic Gauche: Ouvrir/Fermer"
    L["TOOLTIP_HINT_MENU"] = "Clic Droit: Choisir un filtre"
    L["TOOLTIP_HINT_DRAG"] = "Clic Droit + Glisser: Déplacer"
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
    L["GOAL_SET"] = "Objetivo establecido para %s: %s"
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
    L["FILTER_ELEMENTAL"] = "Elementales"
    L["FILTER_GEMS"] = "Gemas"

    L["TOOLTIP_HINT_LEFT"] = "Clic Izquierdo: Abrir/Cerrar"
    L["TOOLTIP_HINT_MENU"] = "Clic Der: Seleccionar filtro"
    L["TOOLTIP_HINT_DRAG"] = "Clic Der + Arrastrar: Mover"
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
    L["GOAL_SET"] = "Obiettivo impostato per %s: %s"
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
    L["FILTER_ELEMENTAL"] = "Elementali"
    L["FILTER_GEMS"] = "Gemme"

    L["TOOLTIP_HINT_LEFT"] = "Clic Sinistro: Apri/Chiudi"
    L["TOOLTIP_HINT_MENU"] = "Clic Destro: Seleziona filtro"
    L["TOOLTIP_HINT_DRAG"] = "Clic Destro + Trascinare: Sposta"
end

-- ============================================================================
-- 6. RUSSIAN (Русский)(Translator: ZamestoTV)
-- ============================================================================
if GetLocale() == "ruRU" then
    L["LOADED"] = "загружено. ЛКМ по предмету для настройки цели."
    L["NOTHING_FOUND"] = "Предметы для этого фильтра не найдены."
    L["LOADING"] = "Загрузка..."
    L["FILTER_CHANGE"] = "Фильтр:"

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
    L["FILTER_ELEMENTAL"] = "Элементы"
    L["FILTER_GEMS"] = "Самоцветы"

    L["TOOLTIP_HINT_LEFT"] = "ЛКМ: Открыть/Закрыть"
    L["TOOLTIP_HINT_MENU"] = "ПКМ: Выбрать фильтр"
    L["TOOLTIP_HINT_DRAG"] = "ПКМ + Тащить: Переместить"
end

-- ============================================================================
-- 7. PORTUGUESE (Português Brasil)
-- ============================================================================
if GetLocale() == "ptBR" then
    L["LOADED"] = "carregado."
    L["NOTHING_FOUND"] = "Nenhum item encontrado."
    L["LOADING"] = "Carregando..."
    L["FILTER_CHANGE"] = "Filtro:"
    L["GOAL_POPUP_TEXT"] = "Definir meta para:\n%s"
    L["GOAL_SET"] = "Meta definida para %s: %s"
    L["GOAL_COMPLETED"] = "Meta alcançada: %s!"
    L["GOAL_REMOVED"] = "Meta removida para: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00Clique Esq.:|r Definir Meta\n|cFFFF0000Clique Dir.:|r Remover Meta"

    L["FILTER_ALL"] = "Tudo (Resumo)"
    L["FILTER_ORES"] = "Minérios e Pedras"
    L["FILTER_HERBS"] = "Ervas"
    L["FILTER_SKINNING"] = "Couro e Tecido"
    L["FILTER_HOUSING"] = "Madeira e Partes"
    L["FILTER_ENCHANTING"] = "Encantamento"
    L["FILTER_COOKING"] = "Carne e Peixe"
    L["FILTER_ELEMENTAL"] = "Elementais"
    L["FILTER_GEMS"] = "Gemas"

    L["TOOLTIP_HINT_LEFT"] = "Clique Esq.: Abrir/Fechar"
    L["TOOLTIP_HINT_MENU"] = "Clique Dir.: Selecionar Filtro"
    L["TOOLTIP_HINT_DRAG"] = "Clique Dir. + Arrastar: Mover"
end

-- ============================================================================
-- 8. KOREAN (한국어) - Benötigt Übersetzung der Expansions!
-- ============================================================================
if GetLocale() == "koKR" then
    L["LOADED"] = "로드됨."
    L["NOTHING_FOUND"] = "아이템을 찾을 수 없습니다."
    L["LOADING"] = "로딩 중..."
    L["FILTER_CHANGE"] = "필터:"
    L["GOAL_POPUP_TEXT"] = "목표 수량 입력:\n%s"
    L["GOAL_SET"] = "%s 목표 설정: %s"
    L["GOAL_COMPLETED"] = "목표 달성: %s!"
    L["GOAL_REMOVED"] = "%s 목표 삭제됨"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00좌클릭:|r 목표 설정\n|cFFFF0000우클릭:|r 목표 삭제"

    L["FILTER_ALL"] = "전체 (요약)"
    L["FILTER_ORES"] = "광석 및 암석"
    L["FILTER_HERBS"] = "약초"
    L["FILTER_SKINNING"] = "가죽 및 천"
    L["FILTER_HOUSING"] = "목재 및 부품"
    L["FILTER_ENCHANTING"] = "마법부여"
    L["FILTER_COOKING"] = "요리 재료"
    L["FILTER_ELEMENTAL"] = "원소"
    L["FILTER_GEMS"] = "보석"

    L["TOOLTIP_HINT_LEFT"] = "좌클릭: 열기/닫기"
    L["TOOLTIP_HINT_MENU"] = "우클릭: 필터 선택"
    L["TOOLTIP_HINT_DRAG"] = "우클릭 + 드래그: 이동"

    L["EXP_0"] = "오리지널"
    L["EXP_1"] = "불타는 성전"
    L["EXP_2"] = "리치 왕의 분노"
    L["EXP_3"] = "대격변"
    L["EXP_4"] = "판다리아의 안개"
    L["EXP_5"] = "드레노어의 전쟁군주"
    L["EXP_6"] = "군단"
    L["EXP_7"] = "격전의 아제로스"
    L["EXP_8"] = "어둠땅"
    L["EXP_9"] = "용군단"
    L["EXP_10"] = "내부 전쟁"
    L["EXP_11"] = "미드나이트"
end

-- ============================================================================
-- 9. CHINESE SIMPLIFIED (简体中文) - Benötigt Übersetzung der Expansions!
-- ============================================================================
if GetLocale() == "zhCN" then
    L["LOADED"] = "已加载。"
    L["NOTHING_FOUND"] = "未找到物品。"
    L["LOADING"] = "加载中..."
    L["FILTER_CHANGE"] = "过滤器:"
    L["GOAL_POPUP_TEXT"] = "输入目标数量:\n%s"
    L["GOAL_SET"] = "已设定目标 %s: %s"
    L["GOAL_COMPLETED"] = "目标达成: %s!"
    L["GOAL_REMOVED"] = "已移除目标: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00左键:|r 设定目标\n|cFFFF0000右键:|r 移除目标"

    L["FILTER_ALL"] = "全部 (汇总)"
    L["FILTER_ORES"] = "矿石与石头"
    L["FILTER_HERBS"] = "草药"
    L["FILTER_SKINNING"] = "皮革与布料"
    L["FILTER_HOUSING"] = "木材与零件"
    L["FILTER_ENCHANTING"] = "附魔"
    L["FILTER_COOKING"] = "烹饪材料"
    L["FILTER_ELEMENTAL"] = "元素"
    L["FILTER_GEMS"] = "宝石"

    L["TOOLTIP_HINT_LEFT"] = "左键: 打开/关闭"
    L["TOOLTIP_HINT_MENU"] = "右键: 选择过滤器"
    L["TOOLTIP_HINT_DRAG"] = "右键+拖动: 移动"

    L["EXP_0"] = "经典旧世"
    L["EXP_1"] = "燃烧的远征"
    L["EXP_2"] = "巫妖王之怒"
    L["EXP_3"] = "大地的裂变"
    L["EXP_4"] = "熊猫人之谜"
    L["EXP_5"] = "德拉诺之王"
    L["EXP_6"] = "军团再临"
    L["EXP_7"] = "争霸艾泽拉斯"
    L["EXP_8"] = "暗影国度"
    L["EXP_9"] = "巨龙时代"
    L["EXP_10"] = "地心之战"
    L["EXP_11"] = "午夜"
end

-- ============================================================================
-- 10. CHINESE TRADITIONAL (繁體中文) - Benötigt Übersetzung der Expansions!
-- ============================================================================
if GetLocale() == "zhTW" then
    L["LOADED"] = "已載入。"
    L["NOTHING_FOUND"] = "未找到物品。"
    L["LOADING"] = "載入中..."
    L["FILTER_CHANGE"] = "過濾器:"
    L["GOAL_POPUP_TEXT"] = "輸入目標數量:\n%s"
    L["GOAL_SET"] = "已設定目標 %s: %s"
    L["GOAL_COMPLETED"] = "目標達成: %s!"
    L["GOAL_REMOVED"] = "已移除目標: %s"
    L["TOOLTIP_HINT_ITEM_GOAL"] = "|cFF00FF00左鍵:|r 設定目標\n|cFFFF0000右鍵:|r 移除目標"

    L["FILTER_ALL"] = "全部 (匯總)"
    L["FILTER_ORES"] = "礦石與石頭"
    L["FILTER_HERBS"] = "草藥"
    L["FILTER_SKINNING"] = "皮革與布料"
    L["FILTER_HOUSING"] = "木材與零件"
    L["FILTER_ENCHANTING"] = "附魔"
    L["FILTER_COOKING"] = "烹飪材料"
    L["FILTER_ELEMENTAL"] = "元素"
    L["FILTER_GEMS"] = "寶石"

    L["TOOLTIP_HINT_LEFT"] = "左鍵: 打開/關閉"
    L["TOOLTIP_HINT_MENU"] = "右鍵: 選擇過濾器"
    L["TOOLTIP_HINT_DRAG"] = "右鍵+拖曳: 移動"

    L["EXP_0"] = "經典版"
    L["EXP_1"] = "燃燒的遠征"
    L["EXP_2"] = "巫妖王之怒"
    L["EXP_3"] = "浩劫與重生"
    L["EXP_4"] = "潘達利亞之謎"
    L["EXP_5"] = "德拉諾之霸"
    L["EXP_6"] = "軍團再臨"
    L["EXP_7"] = "爭霸艾澤拉斯"
    L["EXP_8"] = "暗影國度"
    L["EXP_9"] = "巨龍崛起"
    L["EXP_10"] = "地心之戰"
    L["EXP_11"] = "午夜"
end

addonTable.L = L