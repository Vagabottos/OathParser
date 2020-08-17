--
-- Oath official mod, by permission of Leder Games.
--
-- Created and maintained by AgentElrond.  Latest update:  2020
--


function onLoad(save_state)
  OATH_MAJOR_VERSION                   = 3
  OATH_MINOR_VERSION                   = 1
  OATH_PATCH_VERSION                   = 0
  OATH_MOD_VERSION                     = OATH_MAJOR_VERSION .. "." .. OATH_MINOR_VERSION .. "." .. OATH_PATCH_VERSION

  STATUS_SUCCESS                       = 0
  STATUS_FAILURE                       = 1

  MIN_CHRONICLE_NAME_LENGTH            = 1
  MAX_CHRONICLE_NAME_LENGTH            = 255

  BUTTONS_NONE                         = 0
  BUTTONS_NOT_IN_GAME                  = 1
  BUTTONS_IN_GAME                      = 2

  -- Currently, the 24th and final site is not used.
  NUM_TOTAL_SITES                      = 23

  NUM_TOTAL_DENIZENS                   = 198

  local tokenPosition = nil

  math.randomseed(os.time())
  -- Throw away a few numbers per the Lua documentation.  The first number may not be random.
  math.random()
  math.random()
  math.random()

  RESET_CHRONICLE_STATE_STRING         = "030100000110Empire and Exile1F00000123450403FFFFFFFFFFFF0724FFFFFFFFFFFFFFFFFFFF0B19FFFFFFFFFFFFFFFFFFFF000000"

  dealHeight                           = 4.5

  belowTableDeckGuid                   = "ebc127"
  belowTableFavorGuid                  = "ad4e12"
  belowTableSecretGuid                 = "8314e8"
  mapGuids                             = { "fb146b", "8f599d", "7cf920" }

  -- The game object contains unchanging game data such as card names.
  gameDataObjectGuid                   = "85bbc5"

  siteCardSpawnPositions               = { { -21.40, 1.07,  7.43},
                                           { -21.39, 1.07,  2.76},
                                           {  -4.83, 1.07,  7.39},
                                           {  -4.84, 1.07,  2.70},
                                           {  -4.83, 1.07, -1.97},
                                           {  11.79, 1.07,  7.38},
                                           {  11.78, 1.07,  2.69},
                                           {  11.78, 1.07, -2.01} }
  normalCardBaseSpawnPositions         = { { -16.83, 1.07,  7.43},
                                           { -16.82, 1.07,  2.76},
                                           {  -0.24, 1.07,  7.39},
                                           {  -0.26, 1.07,  2.70},
                                           {  -0.25, 1.07, -1.97},
                                           {  16.35, 1.07,  7.38},
                                           {  16.35, 1.07,  2.69},
                                           {  16.35, 1.07, -2.00} }
  normalCardXSpawnChange               = { 0.00, 3.05, 6.10 }
  supplyMarkerStartPositions           = { ["Purple"] = { -17.58, 1.06,  19.79},
                                           ["Brown"]  = {  12.75, 1.06,  19.72},
                                           ["Yellow"] = {  31.77, 1.06,   3.48},
                                           ["White"]  = {  12.06, 1.06, -13.58},
                                           ["Blue"]   = { -17.29, 1.06, -13.57},
                                           ["Red"]    = { -31.65, 1.06,   5.44} }
  pawnStartPositions                   = { ["Purple"] = { -19.76, 1.06,  18.46},
                                           ["Brown"]  = {   8.17, 1.06,  15.46},
                                           ["Yellow"] = {  27.50, 1.06,   7.11},
                                           ["White"]  = {  14.97, 1.06,  -9.08},
                                           ["Blue"]   = { -14.20, 1.06,  -9.02},
                                           ["Red"]    = { -26.99, 1.06,   2.44} }
  pawnStartYRotations                  = { ["Purple"] = 0.0,
                                           ["Brown"]  = 0.0,
                                           ["Yellow"] = 90.0,
                                           ["White"]  = 180.0,
                                           ["Blue"]   = 180.0,
                                           ["Red"]    = 270.0 }
  handCardSpawnPositions               = { ["Purple"] = { { -13.15, 2.97,  29.83}, { -16.09, 3.07,  29.83}, { -19.03, 3.17,  29.83} },
                                           ["Brown"]  = { {  16.38, 2.97,  29.83}, {  13.44, 3.07,  29.83}, {  10.49, 3.17,  29.83} },
                                           ["Yellow"] = { {  47.29, 2.97,   1.90}, {  47.29, 3.07,   4.84}, {  47.29, 3.17,   7.79} },
                                           ["White"]  = { {   8.97, 2.97, -29.83}, {  11.91, 3.07, -29.83}, {  14.85, 3.17, -29.83} },
                                           ["Blue"]   = { { -20.08, 2.97, -29.83}, { -17.14, 3.07, -29.83}, { -14.20, 3.17, -29.83} },
                                           ["Red"]    = { { -47.40, 2.97,   7.78}, { -47.40, 3.07,   4.84}, { -47.40, 3.17,   1.90} } }
  handCardYRotations                   = { ["Purple"] = 0.0,
                                           ["Brown"]  = 0.0,
                                           ["Yellow"] = 90.0,
                                           ["White"]  = 180.0,
                                           ["Blue"]   = 180.0,
                                           ["Red"]    = 270.0 }
  discardPileSpawnPositions            = { { -13.93, 1.07, 11.31},
                                           {   2.65, 1.07, 11.40},
                                           {  19.22, 1.07, 11.40} }
  playerButtonPositions                = { ["Purple"] = nil,
                                           ["Brown"]  = { -43.3, 4.6,   0.6 },
                                           ["Yellow"] = { -64.0, 4.6, -18.8 },
                                           ["White"]  = { -42.5, 4.6, -38.0 },
                                           ["Blue"]   = { -12.0, 4.6, -38.0 },
                                           ["Red"]    = {   4.3, 4.6, -15.4 } }
  playerButtonColors                   = { ["Purple"] = nil,
                                           ["Brown"]  = { 0.40, 0.40, 0.40, 1.00 },
                                           ["Yellow"] = { 0.94, 0.80, 0.11, 1.00 },
                                           ["White"]  = { 0.63, 0.63, 0.63, 1.00 },
                                           ["Blue"]   = { 0.00, 0.68, 1.00, 1.00 },
                                           ["Red"]    = { 0.80, 0.05, 0.05, 1.00 } }
  favorBagGuid                         = "cfb9e0"
  favorBag                             = nil
  secretBagGuid                        = "dc593a"
  secretBag                            = nil
  numMarkers                           = 3
  markerGuids                          = { "c1f67a", "a7e6d2", "b01eff" }
  markerPositions                      = { { -20.70, 1.38, -1.59 },
                                           { -17.70, 1.38, -0.49 },
                                           { 20.30, 1.38, -4.72 } }
  numDice                              = 15
  diceGuids                            = { "b70c54", "13e33b", "57c9c5", "8ce90c", "297ceb", "863691",   -- defense dice
                                           "1f96ec", "e24bff", "3ad8c2", "3d1a23", "94f013", "ca95ce", "7a1759", "199338",  -- attack dice
                                           "8e1eb3" } -- game end die
  dicePositions                        = { { -42.98, 1.46, 17.26 },  -- defense dice
                                           { -41.35, 1.46, 17.26 },
                                           { -39.62, 1.46, 17.26 },
                                           { -43.03, 1.46, 15.57 },
                                           { -41.34, 1.46, 15.57 },
                                           { -39.64, 1.46, 15.57 },
                                           { -42.75, 1.46, 12.32 },  -- attack dice
                                           { -41.12, 1.46, 12.32 },
                                           { -39.39, 1.46, 12.32 },
                                           { -37.60, 1.46, 12.32 },
                                           { -42.80, 1.46, 10.63 },
                                           { -41.11, 1.46, 10.63 },
                                           { -39.41, 1.46, 10.63 },
                                           { -37.62, 1.46, 10.63 },
                                           { -45.29, 1.46, 16.32 } } -- game end die
  favorSpawnPositions                  = { ["Discord"]   = { -6.53,  1.06, -5.48 },
                                           ["Arcane"]    = { -3.01,  1.06, -5.53 },
                                           ["Order"]     = {  0.48,  1.06, -5.49 },
                                           ["Hearth"]    = {  3.98,  1.06, -5.51 },
                                           ["Beast"]     = {  7.47,  1.06, -5.48 },
                                           ["Nomad"]     = {  10.98, 1.06, -5.51 }}
  oathkeeperTokenGuid                  = "900000"
  oathkeeperStartPosition              = { -41.19,   0.96, 19.28 }
  oathkeeperStartRotation              = {   0.00, 180.00,  0.00 }
  oathkeeperStartScale                 = {   0.69,   1.00,  0.69 }
  worldDeckSpawnPosition               = { -12.16,   1.09, -4.45 }
  relicDeckSpawnPosition               = { -16.60,   1.18, -4.45 }
  siteCardZoneGuids                    = { "9a3e96", "780752", "a0255b", "2eb56f", "a7195e", "5abb66", "0cc29b", "19e212" }
  mapNormalCardZoneGuids               = { { "ecb381", "7d73a1", "2b4a13" },
                                           { "7d25a7", "cb9070", "f43a64" },
                                           { "d42b02", "0341c6", "15ff0b" },
                                           { "480d7c", "517af5", "f7ecbf" },
                                           { "ca1831", "79834c", "bcfa56" },
                                           { "43fad5", "b397d8", "4caada" },
                                           { "242f8e", "aee07a", "f27196" },
                                           { "7052b5", "6311cc", "17b541" } }
  mapSiteCardZones                     = {}
  mapNormalCardZones                   = { {},
                                           {},
                                           {},
                                           {},
                                           {},
                                           {},
                                           {},
                                           {} }

  discardZoneGuids                     = { "1f19b3", "89853a", "817e13" }
  discardZones                         = {}

  oathReminderStartPosition            = { -41.16,   0.96, 23.05 }
  oathReminderStartRotation            = {   0.00, 180.00,  0.00 }
  oathReminderTokenGuids               = { ["Supremacy"]    = "56a763",
                                           ["People"]       = "ddc761",
                                           ["Devotion"]     = "375ead",
                                           ["Protection"]   = "03f51a",
                                           ["Conspiracy"]   = nil }
  oathReminderTokens                   = { ["Supremacy"]    = nil,
                                           ["People"]       = nil,
                                           ["Devotion"]     = nil,
                                           ["Protection"]   = nil,
                                           ["Conspiracy"]   = nil }
  oathReminderTokenHidePositions       = { ["Supremacy"]    = { -39.18, (-2.0), 24.68 },
                                           ["People"]       = { -39.18, (-2.5), 24.68 },
                                           ["Devotion"]     = { -39.18, (-3.0), 24.68 },
                                           ["Protection"]   = { -39.18, (-3.5), 24.68 },
                                           ["Conspiracy"]   = nil }

  reliquaryGuid                        = "8c433b"
  reliquary                            = nil
  reliquaryCardPositions               = { { -13.76, 1.07, 22.96 },
                                           { -16.86, 1.07, 22.96 },
                                           { -19.95, 1.07, 22.96 },
                                           { -23.06, 1.07, 22.96 } }
  peoplesFavorGuid                     = "e34fed"
  peoplesFavor                         = nil
  peoplesFavorShowPosition             = { -42.20,   0.97, 35.14 }
  peoplesFavorHidePosition             = {   0.22, (-3.5), 22.37 }
  darkestSecretGuid                    = "651030"
  darkestSecret                        = nil
  darkestSecretShowPosition            = { -50.60,   0.97, 35.14 }
  darkestSecretHidePosition            = {  -6.27, (-3.5), 22.38 }
  chancellorSpecialStartPosition       = { -32.98,   0.96, 28.22 }
  grandScepterGuid                     = "200daf"
  grandScepter                         = nil
  grandScepterStartPosition            = { -32.81,   0.96, 23.04 }
  grandScepterHidePosition             = { -32.81, (-3.5), 23.04 }
  oathkeeperTokenStartPosition         = { -41.19,   0.96, 19.28 }
  oathkeeperTokenHidePosition          = { -41.19, (-3.5), 19.28 }

  playerBoardGuids                     = { ["Purple"] = "4fe3a3",
                                           ["Brown"]  = "1687d6",
                                           ["Yellow"] = "a7269d",
                                           ["White"]  = "39f190",
                                           ["Blue"]   = "6ca4ee",
                                           ["Red"]    = "26f71b" }
  playerBoards                         = {}
  playerWarbandBagGuids                = { ["Purple"] = "53fa24",
                                           ["Brown"]  = "b2e760",
                                           ["Yellow"] = "ebda8c",
                                           ["White"]  = "e89fd4",
                                           ["Blue"]   = "0d3f34",
                                           ["Red"]    = "692ddd" }
  playerWarbandBags                    = {}
  playerPawnGuids                      = { ["Purple"] = "ba8594",
                                           ["Brown"]  = "31f795",
                                           ["Yellow"] = "b0735a",
                                           ["White"]  = "a8255b",
                                           ["Blue"]   = "9f1db5",
                                           ["Red"]    = "95b3e4" }
  playerPawns                          = {}
  playerSupplyMarkerGuids              = { ["Purple"] = "c91a5e",
                                           ["Brown"]  = "061daa",
                                           ["Yellow"] = "41259d",
                                           ["White"]  = "15d787",
                                           ["Blue"]   = "97cad2",
                                           ["Red"]    = "c4e76a" }
  playerSupplyMarkers                  = {}
  playerAdviserZoneGuids               = { ["Purple"] = { "903e80", "ecb04a", "a2a8b3" },
                                           ["Brown"]  = { "1cb9fa", "c2693c", "63d89d" },
                                           ["Yellow"] = { "cf9d4a", "490541", "88d8ef" },
                                           ["White"]  = { "542195", "9aa3a6", "aa57ba" },
                                           ["Blue"]   = { "4a8056", "a641b8", "14b48e" },
                                           ["Red"]    = { "91f5a7", "6b0631", "bd1c43" } }
  playerAdviserZones                   = { ["Purple"] = {},
                                           ["Brown"]  = {},
                                           ["Yellow"] = {},
                                           ["White"]  = {},
                                           ["Blue"]   = {},
                                           ["Red"]    = {} }
  suitFavorZoneGuids                   = { ["Discord"]   = "0bbd07",
                                           ["Hearth"]    = "1fc5f8",
                                           ["Nomad"]     = "2430d4",
                                           ["Arcane"]    = "2fe4a0",
                                           ["Order"]     = "04cf1c",
                                           ["Beast"]     = "2422e1" }
  suitFavorZones                       = { ["Discord"]   = nil,
                                           ["Hearth"]    = nil,
                                           ["Nomad"]     = nil,
                                           ["Arcane"]    = nil,
                                           ["Order"]     = nil,
                                           ["Beast"]     = nil }

  -- Since Tabletop Simulator reserves the black color, "Brown" represents the black player mat and pieces.
  playerColors                         = { "Purple", "Brown", "Yellow", "White", "Blue", "Red" }

  -- Codes corresponding to various oaths and the conspiracy card.
  oathCodes                            = { ["Supremacy"]    = 0,
                                           ["People"]       = 1,
                                           ["Devotion"]     = 2,
                                           ["Protection"]   = 3,
                                           ["Conspiracy"]   = 4 }
  oathNamesFromCode                    = { [0] = "Supremacy",
                                           [1] = "People",
                                           [2] = "Devotion",
                                           [3] = "Protection",
                                           [4] = "Conspiracy" }
  fullOathNames                        = { ["Supremacy"]    = "Oath of Supremacy",
                                           ["People"]       = "Oath of the People",
                                           ["Devotion"]     = "Oath of Devotion",
                                           ["Protection"]   = "Oath of Protection",
                                           ["Conspiracy"]   = "Conspiracy" }
  oathDescriptions                     = { ["Supremacy"]    = "Rules the most sites",
                                           ["People"]       = "Holds the People's Favor",
                                           ["Devotion"]     = "Holds the Darkest Secret",
                                           ["Protection"]   = "Holds the most relics",
                                           ["Conspiracy"]   = "Conspiracy" }
  -- Used for oath selection GUI panels.
  selectOathOffsets                    = { ["Supremacy"]    = "-332 -57",
                                           ["People"]       = "-110 -57",
                                           ["Devotion"]     = "110 -57",
                                           ["Protection"]   = "330 -57" }

  -- Codes corresponding to various suits.
  suitCodes                            = { ["Discord"] = 0, ["Hearth"] = 1, ["Nomad"] = 2, ["Arcane"] = 3, ["Order"] = 4, ["Beast"] = 5 }
  -- Suit names are in order of the chronicle rotation.
  suitNames                            = { "Discord", "Arcane", "Order", "Hearth", "Beast", "Nomad" }
  -- Next suit for each suit in the chronicle rotation.
  chronicleNextSuits                   = { ["Discord"]      = "Arcane",
                                           ["Arcane"]       = "Order",
                                           ["Order"]        = "Hearth",
                                           ["Hearth"]       = "Beast",
                                           ["Beast"]        = "Nomad",
                                           ["Nomad"]        = "Discord" }

  --
  -- Game state variables.
  --

  if ((nil != save_state) and ("" != save_state)) then
    initState = JSON.decode(save_state)
    --
    -- Since a save state is being loaded that had data, use it to initialize state variables.
    --

    -- This indicates whether a game is in progress.
    isGameInProgress                   = initState.isGameInProgress
    -- This string represents the encoded chronicle state.
    chronicleStateString               = initState.chronicleStateString
    -- This string represents encoded ingame state, used for midgame saves.
    ingameStateString                  = initState.ingameStateString
    -- This value increases as more games are played in a chronicle.
    curGameCount                       = initState.curGameCount
    -- Name of the current chronicle.
    curChronicleName                   = initState.curChronicleName
    -- Number of players in the current game.  Only valid if the game is in progress.
    curGameNumPlayers                  = initState.curGameNumPlayers
    -- Player status can be { "Chancellor", true } for Purple and { "Citizen" / "Exile", true / false }  for all other colors.
    -- The boolean indicates whether the player is active, and only matters if a game is in progress.
    curPlayerStatus                    = { ["Purple"] = { initState.curPlayerStatus["Purple"][1], initState.curPlayerStatus["Purple"][2] },
                                           ["Brown"]  = { initState.curPlayerStatus["Brown"][1], initState.curPlayerStatus["Brown"][2] },
                                           ["Yellow"] = { initState.curPlayerStatus["Yellow"][1], initState.curPlayerStatus["Yellow"][2] },
                                           ["White"]  = { initState.curPlayerStatus["White"][1], initState.curPlayerStatus["White"][2] },
                                           ["Blue"]   = { initState.curPlayerStatus["Blue"][1], initState.curPlayerStatus["Blue"][2] },
                                           ["Red"]    = { initState.curPlayerStatus["Red"][1], initState.curPlayerStatus["Red"][2] } }

    curFavorValues = {}
    for curSuitName,curSuitCode in pairs(suitCodes) do
      if (nil != initState.curFavorValues) then
        curFavorValues[curSuitName] = initState.curFavorValues[curSuitName]
      else
        curFavorValues[curSuitName] = 0
      end
    end

    curOath                            = initState.curOath

    curSuitOrder                       = { initState.curSuitOrder[1],
                                           initState.curSuitOrder[2],
                                           initState.curSuitOrder[3],
                                           initState.curSuitOrder[4],
                                           initState.curSuitOrder[5],
                                           initState.curSuitOrder[6] }

    curMapSites = {}
    curMapNormalCards = {}
    for siteIndex = 1,8 do
      -- To avoid any potential performance impact, map / world deck / dispossessed variables are not updated midgame.
      curMapSites[siteIndex]           = { initState.curMapSites[siteIndex][1], initState.curMapSites[siteIndex][2] }
      curMapNormalCards[siteIndex]     = {}

      -- This structure contains the name of each card and whether that card is flipped.
      for normalCardIndex = 1,3 do
        curMapNormalCards[siteIndex][normalCardIndex] = { initState.curMapNormalCards[siteIndex][normalCardIndex][1],
                                                          initState.curMapNormalCards[siteIndex][normalCardIndex][2] }
      end
    end

    curWorldDeckCardCount              = initState.curWorldDeckCardCount
    curWorldDeckCards                  = {}
    for cardIndex = 1,curWorldDeckCardCount do
      curWorldDeckCards[cardIndex]     = initState.curWorldDeckCards[cardIndex]
    end

    curDispossessedDeckCardCount       = initState.curDispossessedDeckCardCount
    curDispossessedDeckCards           = {}
    for cardIndex = 1,curDispossessedDeckCardCount do
      curDispossessedDeckCards[cardIndex] = initState.curDispossessedDeckCards[cardIndex]
    end

    curRelicDeckCardCount              = initState.curRelicDeckCardCount
    curRelicDeckCards                  = {}

    if ((nil != curRelicDeckCardCount) and
        (0 != curRelicDeckCardCount)   and
        (nil != initState.curRelicDeckCards))      then
      for cardIndex = 1,curRelicDeckCardCount do
        curRelicDeckCards[cardIndex]     = initState.curRelicDeckCards[cardIndex]
      end
    else
      curRelicDeckCardCount = 0
    end

    favorBag = getObjectFromGUID(favorBagGuid)
    if (nil == favorBag) then
      printToAll("Error finding favor bag.", {1,0,0})
    end

    secretBag = getObjectFromGUID(secretBagGuid)
    if (nil == secretBag) then
      printToAll("Error finding secret bag.", {1,0,0})
    end

    --
    -- Variables used while saving.  None of these need loaded from a TTS save state.
    --

    saveStatus                         = STATUS_SUCCESS

    --
    -- Variables used while loading a save string.  None of these need loaded from a TTS save state since they will be overwritten.
    --

    loadStatus                         = STATUS_SUCCESS
    loadGameCount                      = 1
    loadChronicleName                  = "Empire and Exile"
    loadPlayerStatus                   = { ["Purple"] = { "Chancellor", true },
                                           ["Brown"]  = { "Exile", true },
                                           ["Yellow"] = { "Exile", true },
                                           ["White"]  = { "Exile", true },
                                           ["Blue"]   = { "Exile", true },
                                           ["Red"]    = { "Exile", true } }
    loadCurOath                        = "Supremacy"
    loadSuitOrder                      = { "Discord", "Hearth", "Nomad", "Arcane", "Order", "Beast" }
    loadMapSites                       = { { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false } }
    -- This structure contains the name of each card and whether that card is flipped.
    loadMapNormalCards                 = { { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } } }
    loadWorldDeckInitCardCount         = 0
    loadWorldDeckInitCards             = {}
    loadDispossessedDeckInitCardCount  = 0
    loadDispossessedDeckInitCards      = {}
    loadRelicDeckInitCardCount         = 0
    loadRelicDeckInitCards             = {}

    loadExpectedSpawnCount             = 0
    loadActualSpawnCount               = 0
    loadWaitID                         = nil
  else -- end if ((nil != save_state) and ("" != save_state))
    --
    -- No save state is available.  Use default variable values.
    --

    Wait.condition(initDefaultGameState, function() return (true == dataIsAvailable) end)
  end

  --
  -- Variables used during setup or utility operations.  None of these need loaded from a TTS save state.
  --

  -- Used to randomize setup.
  randomEnabled                        = false
  -- Used for player buttons.
  playerButtonIndices                  = {}
  -- Used to confirm certain destructive commands.
  pendingEraseType                     = nil
  pendingDataString                    = ""
  renamingChronicle                    = false
  lastHostChatMessage                  = ""
  isCommandConfirmed                   = false
  -- Used during cleanup.
  isChronicleInProgress                = false
  pendingWinningColor                  = nil
  winningColor                         = nil
  pendingOath                          = nil
  usedVision                           = false
  wonBySuccession                      = false
  numBuildRepairOptions                = 0
  selectedBuildRepairIndex             = nil
  selectedBuildRepairCardIndex         = nil
  buildRepairOptions                   = { {},
                                           {},
                                           {},
                                           {},
                                           {},
                                           {},
                                           {},
                                           {} }
  selectedEdificeIndex                 = 1
  edificeOffsets                       = { "0 0",
                                           "-327 0",
                                           "-654 0",
                                           "0 512",
                                           "-327 512",
                                           "-654 512" }
  edificeCardCodes                     = { 198, 200, 202, 204, 206, 208 }
  numEdificesInArchive                 = 6
  edificesInArchive                    = { true, true, true, true, true, true }
  numPlayerAdvisers                    = { ["Purple"] = 0,
                                           ["Brown"]  = 0,
                                           ["Yellow"] = 0,
                                           ["White"]  = 0,
                                           ["Blue"]   = 0,
                                           ["Red"]    = 0 }
  playerAdvisers                       = { ["Purple"] = {},
                                           ["Brown"]  = {},
                                           ["Yellow"] = {},
                                           ["White"]  = {},
                                           ["Blue"]   = {},
                                           ["Red"]    = {} }
  -- In sequence, elements refer to Cradle, Provinces, and Hinterland.
  discardContents                      = { {}, {}, {} }
  adviserSuitOptions                   = nil
  selectedSuit                         = nil
  mostDispossessedSuit                 = nil
  wasArchiveHealed                     = false
  grantPlayerCitizenship               = {}
  grantCitizenshipLocked               = false
  archiveContentsBySuit                = { ["Discord"] = {},
                                           ["Arcane"]  = {},
                                           ["Order"]   = {},
                                           ["Hearth"]  = {},
                                           ["Beast"]   = {},
                                           ["Nomad"]   = {} }
  dispossessedContentsBySuit           = { ["Discord"] = {},
                                           ["Arcane"]  = {},
                                           ["Order"]   = {},
                                           ["Hearth"]  = {},
                                           ["Beast"]   = {},
                                           ["Nomad"]   = {} }

  curOathkeeperToken = getObjectFromGUID(oathkeeperTokenGuid)
  -- Lock if hidden.
  if (nil != curOathkeeperToken) then
    tokenPosition = curOathkeeperToken.getPosition()
    if (tokenPosition[2] < 0) then
      curOathkeeperToken.locked = true
      curOathkeeperToken.interactable = false
      curOathkeeperToken.tooltip = false
    end
  else
    printToAll("Error, could not find oathkeeper token.", {1,0,0})
  end

  --
  -- Make certain elements uninteractable.
  --

  belowTableDeck = getObjectFromGUID(belowTableDeckGuid)
  if (belowTableDeck != nil) then
    belowTableDeck.locked = true
    belowTableDeck.interactable = false
    belowTableDeck.tooltip = false
  end

  belowTableFavor = getObjectFromGUID(belowTableFavorGuid)
  if (belowTableFavor != nil) then
    belowTableFavor.locked = true
    belowTableFavor.interactable = false
    belowTableFavor.tooltip = false
  end

  belowTableSecret = getObjectFromGUID(belowTableSecretGuid)
  if (belowTableSecret != nil) then
    belowTableSecret.locked = true
    belowTableSecret.interactable = false
    belowTableSecret.tooltip = false
  end

  mapPart = getObjectFromGUID(mapGuids[1])
  if (mapPart != nil) then
    mapPart.locked = true
    mapPart.interactable = false
    mapPart.tooltip = false
  end

  mapPart = getObjectFromGUID(mapGuids[2])
  if (mapPart != nil) then
    mapPart.locked = true
    mapPart.interactable = false
    mapPart.tooltip = false
  end

  mapPart = getObjectFromGUID(mapGuids[3])
  if (mapPart != nil) then
    mapPart.locked = true
    mapPart.interactable = false
    mapPart.tooltip = false
  end

  gameDataObject = getObjectFromGUID(gameDataObjectGuid)
  if (gameDataObject != nil) then
    gameDataObject.locked = true
    gameDataObject.interactable = false
    gameDataObject.tooltip = false
    --local tempPosition = gameDataObject.getPosition()
    --printToAll("Previous Y position " .. tempPosition.y, {1,1,1})
    --tempPosition.y = 3.05
    --gameDataObject.setPosition(tempPosition)
  end


  -- Get scripting zones.

  for siteIndex = 1,8 do
    mapSiteCardZones[siteIndex] = getObjectFromGUID(siteCardZoneGuids[siteIndex])
    if (nil == mapSiteCardZones[siteIndex]) then
      printToAll("Error loading zone.", {1,0,0})
    end

    for subIndex = 1,3 do
      mapNormalCardZones[siteIndex][subIndex] = getObjectFromGUID(mapNormalCardZoneGuids[siteIndex][subIndex])
      if (nil == mapNormalCardZones[siteIndex][subIndex]) then
        printToAll("Error loading zone.", {1,0,0})
      end
    end
  end

  for discardPileIndex = 1,3 do
    discardZones[discardPileIndex] = getObjectFromGUID(discardZoneGuids[discardPileIndex])
    if (nil == discardZones[discardPileIndex]) then
      printToAll("Error loading zone.", {1,0,0})
    end
  end

  for loopOathName,loopOathCode in pairs(oathCodes) do
    if (nil != oathReminderTokenGuids[loopOathName]) then
      oathReminderTokens[loopOathName] = getObjectFromGUID(oathReminderTokenGuids[loopOathName])

      -- Lock if hidden.
      if (nil != oathReminderTokens[loopOathName]) then
        tokenPosition = oathReminderTokens[loopOathName].getPosition()
        if (tokenPosition[2] < 0) then
          oathReminderTokens[loopOathName].locked = true
          oathReminderTokens[loopOathName].interactable = false
          oathReminderTokens[loopOathName].tooltip = false
        end
      else
        printToAll("Error finding oath reminder token.", {1,0,0})
      end
    end
  end

  reliquary = getObjectFromGUID(reliquaryGuid)
  -- Lock if hidden.
  if (nil != reliquary) then
    tokenPosition = reliquary.getPosition()
    if (tokenPosition[2] < 0) then
      reliquary.locked = true
      reliquary.interactable = false
      reliquary.tooltip = false
    end
  else
    printToAll("Error finding reliquary.", {1,0,0})
  end

  peoplesFavor = getObjectFromGUID(peoplesFavorGuid)
  -- Lock if hidden.
  if (nil != peoplesFavor) then
    tokenPosition = peoplesFavor.getPosition()
    if (tokenPosition[2] < 0) then
      peoplesFavor.locked = true
      peoplesFavor.interactable = false
      peoplesFavor.tooltip = false
    end
  else
    printToAll("Error finding People's Favor.", {1,0,0})
  end

  darkestSecret = getObjectFromGUID(darkestSecretGuid)
  -- Lock if hidden.
  if (nil != darkestSecret) then
    tokenPosition = darkestSecret.getPosition()
    if (tokenPosition[2] < 0) then
      darkestSecret.locked = true
      darkestSecret.interactable = false
      darkestSecret.tooltip = false
    end
  else
    printToAll("Error finding Darkest Secret.", {1,0,0})
  end

  grandScepter = getObjectFromGUID(grandScepterGuid)
  -- Lock if hidden.
  if (nil != grandScepter) then
    tokenPosition = grandScepter.getPosition()
    if (tokenPosition[2] < 0) then
      grandScepter.locked = true
      grandScepter.interactable = false
      grandScepter.tooltip = false
    end
  else
    printToAll("Error finding Grand Scepter.", {1,0,0})
  end

  for i,curColor in ipairs(playerColors) do
    playerBoards[curColor] = getObjectFromGUID(playerBoardGuids[curColor])
    if (nil == playerBoards[curColor]) then
      printToAll("Error finding player board.", {1,0,0})
    end

    playerWarbandBags[curColor] = getObjectFromGUID(playerWarbandBagGuids[curColor])
    if (nil == playerWarbandBags[curColor]) then
      printToAll("Error finding player warband bag.", {1,0,0})
    end

    playerPawns[curColor] = getObjectFromGUID(playerPawnGuids[curColor])
    if (nil == playerPawns[curColor]) then
      printToAll("Error finding player pawn.", {1,0,0})
    end

    playerSupplyMarkers[curColor] = getObjectFromGUID(playerSupplyMarkerGuids[curColor])
    if (nil == playerSupplyMarkers[curColor]) then
      printToAll("Error finding player pawn.", {1,0,0})
    end

    for subIndex = 1,3 do
      playerAdviserZones[curColor][subIndex] = getObjectFromGUID(playerAdviserZoneGuids[curColor][subIndex])
      if (nil == playerAdviserZones[curColor][subIndex]) then
        printToAll("Error loading zone.", {1,0,0})
      end
    end
  end

  for curSuitName,curSuitCode in pairs(suitCodes) do
    suitFavorZones[curSuitName] = getObjectFromGUID(suitFavorZoneGuids[curSuitName])
    if (nil == suitFavorZones[curSuitName]) then
      printToAll("Error loading zone.", {1,0,0})
    end
  end


  -- Force hand zones to the correct height, since a TTS bug means that hand zones will keep lowering with load/save cycles.

  for i,curColor in ipairs(playerColors) do
    local handTransform = Player[curColor].getHandTransform()
    handTransform.position.y = 1.05
    Player[curColor].setHandTransform(handTransform)
  end

  -- Mute bags so cleanup is not loud.

  setWarbandBagsMuted(true)

  Wait.condition(finishOnLoad, function() return (true == dataIsAvailable) end)
end

-- This function is called once data is available from data.ttslua.
function finishOnLoad()
  -- Print welcome message.
  printToAll("", {1,1,1})
  printToAll("===========================================", {1,1,1})
  printToAll("Welcome to the official Oath mod.", {1,1,1})
  printToAll("", {1,1,1})
  printToAll("Mod version " .. OATH_MOD_VERSION, {1,1,1})
  printToAll("",{1,1,1})
  printToAll("Type \"!help\" in chat for a command list.",{1,1,1})
  printToAll("===========================================", {1,1,1})
  printToAll("", {1,1,1})

  -- Display a message and create general buttons.
  if (true == isGameInProgress) then
    printToAll("This save contains the in-progress game #" .. curGameCount .. " of the chronicle \"" .. curChronicleName .. "\".", {0,0.8,0})

    configGeneralButtons(BUTTONS_IN_GAME)
  else
    printToAll("This save is ready for game #" .. curGameCount .. " of the chronicle \"" .. curChronicleName .. "\".", {0,0.8,0})

    configGeneralButtons(BUTTONS_NOT_IN_GAME)
  end
  printToAll("", {1,1,1})
end

function onSave()
  local saveDataTable = {}

  saveDataTable.isGameInProgress       = isGameInProgress
  saveDataTable.chronicleStateString   = chronicleStateString
  if (true == isGameInProgress) then
    scanTable(false)
    saveDataTable.ingameStateString    = generateSaveString()
    if (nil == saveDataTable.ingameStateString) then
      saveDataTable.ingameStateString  = ""
    end
  else
    saveDataTable.ingameStateString  = ""
  end
  saveDataTable.curGameCount           = curGameCount
  saveDataTable.curChronicleName       = curChronicleName
  saveDataTable.curGameNumPlayers      = curGameNumPlayers
  saveDataTable.curPlayerStatus        = { ["Purple"] = { curPlayerStatus["Purple"][1], curPlayerStatus["Purple"][2] },
                                           ["Brown"]  = { curPlayerStatus["Brown"][1], curPlayerStatus["Brown"][2] },
                                           ["Yellow"] = { curPlayerStatus["Yellow"][1], curPlayerStatus["Yellow"][2] },
                                           ["White"]  = { curPlayerStatus["White"][1], curPlayerStatus["White"][2] },
                                           ["Blue"]   = { curPlayerStatus["Blue"][1], curPlayerStatus["Blue"][2] },
                                           ["Red"]    = { curPlayerStatus["Red"][1], curPlayerStatus["Red"][2] } }

  saveDataTable.curFavorValues = {}
  for curSuitName,curSuitCode in pairs(suitCodes) do
    saveDataTable.curFavorValues[curSuitName] = curFavorValues[curSuitName]
  end

  saveDataTable.curOath                = curOath

  saveDataTable.curSuitOrder           = { curSuitOrder[1],
                                           curSuitOrder[2],
                                           curSuitOrder[3],
                                           curSuitOrder[4],
                                           curSuitOrder[5],
                                           curSuitOrder[6] }

  saveDataTable.curMapSites = {}
  saveDataTable.curMapNormalCards = {}
  for siteIndex = 1,8 do
    -- To avoid any potential performance impact, map / world deck / dispossessed variables are not updated midgame.
    saveDataTable.curMapSites[siteIndex] = { curMapSites[siteIndex][1], curMapSites[siteIndex][2] }
    saveDataTable.curMapNormalCards[siteIndex]  = {}

    -- This structure contains the name of each card and whether that card is flipped.
    for normalCardIndex = 1,3 do
      saveDataTable.curMapNormalCards[siteIndex][normalCardIndex] = { curMapNormalCards[siteIndex][normalCardIndex][1],
                                                                      curMapNormalCards[siteIndex][normalCardIndex][2] }
    end
  end

  saveDataTable.curWorldDeckCardCount              = curWorldDeckCardCount
  saveDataTable.curWorldDeckCards                  = {}
  for cardIndex = 1,curWorldDeckCardCount do
    saveDataTable.curWorldDeckCards[cardIndex]     = curWorldDeckCards[cardIndex]
  end

  saveDataTable.curDispossessedDeckCardCount       = curDispossessedDeckCardCount
  saveDataTable.curDispossessedDeckCards           = {}
  for cardIndex = 1,curDispossessedDeckCardCount do
    saveDataTable.curDispossessedDeckCards[cardIndex] = curDispossessedDeckCards[cardIndex]
  end

  saveDataTable.curRelicDeckCardCount              = curRelicDeckCardCount
  saveDataTable.curRelicDeckCards                  = {}
  for cardIndex = 1,curRelicDeckCardCount do
    saveDataTable.curRelicDeckCards[cardIndex]     = curRelicDeckCards[cardIndex]
  end

  return JSON.encode(saveDataTable)
end

function onObjectDrop(playerColor, droppedObject)
  -- For performance reasons, only scan if a favor token is dropped.
  if ("Favor" == string.sub(droppedObject.getName(), 1, 5)) then
    -- Reset the name in case it is not in a suit favor zone.  If it is in a zone, this will be overwritten.
    droppedObject.setName("Favor")

    for suitName,curZone in pairs(suitFavorZones) do
      rescanFavorZone(curZone, suitName)
    end
  end
end

function rescanFavorZone(scanZone, suitName)
  local scriptZoneObjects = scanZone.getObjects()
  local newFavorValue = 0

  -- Count favor in the zone.
  for i,curObject in ipairs(scriptZoneObjects) do
    if ("Favor" == string.sub(curObject.getName(), 1, 5)) then
      newFavorValue = (newFavorValue + 1)
    end
  end

  -- Update names for favor in the zone.
  for i,curObject in ipairs(scriptZoneObjects) do
    if ("Favor" == string.sub(curObject.getName(), 1, 5)) then
      curObject.setName("Favor (" .. newFavorValue .. " " .. suitName .. ")")
    end
  end

  curFavorValues[suitName] = newFavorValue
end

function initDefaultGameState()
  -- This indicates whether a game is in progress.
  isGameInProgress                     = false
  -- This string represents the encoded chronicle state.
  chronicleStateString                 = RESET_CHRONICLE_STATE_STRING
  -- This string represents encoded ingame state, used for midgame saves.
  ingameStateString                    = ""
  -- This value increases as more games are played in a chronicle.
  curGameCount                         = 1
  -- Name of the current chronicle.
  curChronicleName                     = "Empire and Exile"
  -- Number of players in the current game.  Only valid if the game is in progress.
  curGameNumPlayers                    = 1
  -- Player status can be { "Chancellor", true } for Purple and { "Citizen" / "Exile", true / false }  for all other colors.
  -- The boolean indicates whether the player is active, and only matters if a game is in progress.
  curPlayerStatus                      = { ["Purple"] = { "Chancellor", true },
                                           ["Brown"]  = { "Exile", true },
                                           ["Yellow"] = { "Exile", true },
                                           ["White"]  = { "Exile", true },
                                           ["Blue"]   = { "Exile", true },
                                           ["Red"]    = { "Exile", true } }

  curFavorValues = {}
  for curSuitName,curSuitCode in pairs(suitCodes) do
    curFavorValues[curSuitName] = 0
  end

  curOath                              = "Supremacy"

  curSuitOrder                         = { "Discord", "Hearth", "Nomad", "Arcane", "Order", "Beast" }

  -- To avoid any potential performance impact, map / world deck / dispossessed variables are not updated midgame.
  -- The boolean value indicates whether that card is facedown.
  curMapSites                          = { { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false } }
  -- This structure contains the name of each card and whether that card is facedown.
  curMapNormalCards                    = { { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } } }
  curDispossessedDeckCardCount         = 0
  curDispossessedDeckCards             = {}

  curWorldDeckCardCount = 0
  curWorldDeckCards = {}
  generateRandomWorldDeck({}, 0, 0)

  curRelicDeckCardCount = 0
  curRelicDeckCards = {}
  generateRandomRelicDeck({}, 0, 0)

  --
  -- Variables used while saving.  None of these need loaded from a TTS save state.
  --

  saveStatus                           = STATUS_SUCCESS

  --
  -- Variables used while loading a save string.
  --

  loadStatus                           = STATUS_SUCCESS
  loadGameCount                        = 1
  loadChronicleName                    = "Empire and Exile"
  loadPlayerStatus                     = { ["Purple"] = { "Chancellor", true },
                                           ["Brown"]  = { "Exile", true },
                                           ["Yellow"] = { "Exile", true },
                                           ["White"]  = { "Exile", true },
                                           ["Blue"]   = { "Exile", true },
                                           ["Red"]    = { "Exile", true } }
  loadCurOath                          = "Supremacy"
  loadSuitOrder                        = { "Discord", "Hearth", "Nomad", "Arcane", "Order", "Beast" }
  loadMapSites                         = { { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false },
                                           { "NONE", false } }
  -- This structure contains the name of each card and whether that card is flipped.
  loadMapNormalCards                   = { { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } },
                                           { { "NONE", false }, { "NONE", false }, { "NONE", false } } }
  loadWorldDeckInitCardCount           = 0
  loadWorldDeckInitCards               = {}
  loadDispossessedDeckInitCardCount    = 0
  loadDispossessedDeckInitCards        = {}
  loadRelicDeckInitCardCount           = 0
  loadRelicDeckInitCards               = {}

  loadExpectedSpawnCount               = 0
  loadActualSpawnCount                 = 0

  if (nil != loadWaitID) then
    stop(loadWaitID)
    loadWaitID = nil
  end

  loadWaitID                           = nil
end

function onChat(message, chatPlayer)
  local saveString = nil
  local oathCode = nil
  local spawnCardName = nil
  local displayString = nil

  if ("!help" == string.sub(message, 1, 5)) then
    -- Note that the chat font is not necessarily fixed-width, so alignment is done manually.
    printToColor("", chatPlayer.color, {1,1,1})
    printToColor("Chat commands for all players:", chatPlayer.color, {1,1,1})
    printToColor("!help                                                Print this message.", chatPlayer.color, {1,1,1})
    printToColor("!pilgrimage                                     Spawn 3 random site cards in hand.", chatPlayer.color, {1,1,1})
    printToColor("", chatPlayer.color, {1,1,1})
    printToColor("Chat commands only usable by the host:", chatPlayer.color, {1,1,1})
    printToColor("===========================================", chatPlayer.color, {1,1,1})
    printToColor("!card <Card Name>                        Spawn card in hand.", chatPlayer.color, {1,1,1})
    printToColor("!name                                              Display or change chronicle name.", chatPlayer.color, {1,1,1})
    printToColor("!reset_chronicle                             Fully resets the chronicle.", chatPlayer.color, {1,1,1})
    printToColor("!stats                                               Show chronicle stats.", chatPlayer.color, {1,1,1})

    printToColor("", chatPlayer.color, {1,1,1})
    printToColor("", chatPlayer.color, {1,1,1})
  elseif ("!pilgrimage" == string.sub(message, 1, 11)) then
    runPilgrimageCommand(chatPlayer)
  else
    --
    -- Begin processing other commands.
    --

    -- Only process these commands for the host.
    if (true == chatPlayer.host) then
      -- If the host repeats a command, treat it as confirmation.
      if (message == lastHostChatMessage) then
        isCommandConfirmed = true
        -- Reset the last message so that typing a command 3 times does not count as 2 confirmations.
        lastHostChatMessage = ""
      else
        isCommandConfirmed = false
        -- Save the host chat message for possible future command confirmation.
        lastHostChatMessage = message
      end

      if ("!card" == string.sub(message, 1, 5)) then
        spawnCardName = string.sub(message, 7)
        if (nil != cardsTable[spawnCardName]) then
          -- Spawn into the middle of the player's hand zone.
          spawnSingleCard(spawnCardName, false, handCardSpawnPositions[chatPlayer.color][2], handCardYRotations[chatPlayer.color], true)
        else
          printToAll("Unknown card.  Capitalization and spacing matter. ", {1,0,0})
        end
      elseif ("!stats" == string.sub(message, 1, 16)) then
        showStats()
      elseif ("!show_world_deck" == string.sub(message, 1, 16)) then
        displayString = "World deck:\n"
        for i,curCard in ipairs(curWorldDeckCards) do
          displayString = displayString .. "\n" .. curCard
        end
        showDataString(displayString)
      elseif ("!show_relic_deck" == string.sub(message, 1, 16)) then
        displayString = "Relic deck:\n"
        for i,curCard in ipairs(curRelicDeckCards) do
          displayString = displayString .. "\n" .. curCard
        end
        showDataString(displayString)
      elseif ("!show_dispossessed" == string.sub(message, 1, 18)) then
        displayString = "Dispossessed cards:\n"
        for i,curCard in ipairs(curDispossessedDeckCards) do
          displayString = displayString .. "\n" .. curCard
        end
        showDataString(displayString)
      elseif ("!show_pieces" == string.sub(message, 1, 12)) then
        -- Undocumented command that shows game pieces.

        for i,curColor in ipairs(playerColors) do
          showPieces(curColor)
        end

        showGeneralPieces()
      elseif ("!hide_pieces" == string.sub(message, 1, 12)) then
        -- Undocumented command that hides game pieces.

        for i,curColor in ipairs(playerColors) do
          hidePieces(curColor)
        end

        hideGeneralPieces()
      elseif ("!name" == string.sub(message, 1, 5)) then
        showChronicleNameDialog()
      elseif ("!reset_chronicle" == string.sub(message, 1, 16)) then
        if (false == isGameInProgress) then
          if (false == isChronicleInProgress) then
            pendingEraseType = "reset"
            Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
          else
            printToAll("Error, please wait until the Chronicle phase is finished.", {1,0,0})
          end
        else
          printToAll("Error, please wait until the game is finished.", {1,0,0})
        end
      elseif ("!" == string.sub(message, 1, 1)) then
        printToAll("Error, unknown command.", {1,0,0})
      else
        -- Not a command.  Nothing needs done.
      end
    end -- end if (true == chatPlayer.host)
  end -- end processing other commands
end

function importChronicleButtonClicked(buttonObject, playerColor, altClick)
  pendingDataString = ""
  renamingChronicle = false

  Global.UI.setAttribute("panel_text_description", "text", "Paste from to the clipboard to\nimport a Chronicle state:\n(click, then press Ctrl-V)")
  Global.UI.setAttribute("panel_text_data", "text", displayString)
  Global.UI.setAttribute("ok_panel_text", "active", false)
  Global.UI.setAttribute("cancel_panel_text", "active", true)
  Global.UI.setAttribute("cancel_panel_text", "textColor", "#FFFFFFFF")
  Global.UI.setAttribute("confirm_panel_text", "active", true)
  Global.UI.setAttribute("confirm_panel_text", "textColor", "#FFFFFFFF")
  Global.UI.setAttribute("panel_text", "active", true)
end

function exportChronicleButtonClicked(buttonObject, playerColor, altClick)
  scanTable(false)
  saveString = generateSaveString()

  if (nil != saveString) then
    showExportString(saveString)
    printToAll("Export successful.", {0,0.8,0})
  else
    printToAll("Export failed.", {1,0,0})
  end

  printToAll("", {1,1,1})
end

function showStats()
  local displayString = nil
  local cardSuit = nil
  local worldDeckSuitCounts = { ["Discord"] = 0,
                                ["Arcane"]  = 0,
                                ["Order"]   = 0,
                                ["Hearth"]  = 0,
                                ["Beast"]   = 0,
                                ["Nomad"]   = 0 }

  -- Note that the current game count represents the game in progress or about to start, and NOT the number of completed games.
  displayString = "Games played on this Chronicle:  " .. (curGameCount - 1) .. "\n\n"
  displayString = displayString .. "Suit counts in the world deck:"

  for i,curCard in ipairs(curWorldDeckCards) do
    cardSuit = cardsTable[curCard].suit
    -- Note that vision cards do not have suits.
    if (nil != cardSuit) then
      worldDeckSuitCounts[cardSuit] = (worldDeckSuitCounts[cardSuit] + 1)
    end
  end

  for i,suitCount in pairs(worldDeckSuitCounts) do
    displayString = displayString .. "\n  " .. i .. ":  " .. suitCount
  end

  showDataString(displayString)
end

function showExportString(displayString)
  pendingDataString = ""
  renamingChronicle = false

  Global.UI.setAttribute("panel_text_description", "text", "Copy to the clipboard to\nshare your Chronicle state:\n(click, then press Ctrl-C)")
  Global.UI.setAttribute("panel_text_data", "text", displayString)
  Global.UI.setAttribute("ok_panel_text", "active", true)
  Global.UI.setAttribute("ok_panel_text", "textColor", "#FFFFFFFF")
  Global.UI.setAttribute("cancel_panel_text", "active", false)
  Global.UI.setAttribute("confirm_panel_text", "active", false)
  Global.UI.setAttribute("panel_text", "active", true)
end

function showDataString(displayString)
  pendingDataString = ""
  renamingChronicle = false

  Global.UI.setAttribute("panel_text_description", "text", "Data:")
  Global.UI.setAttribute("panel_text_data", "text", displayString)
  Global.UI.setAttribute("ok_panel_text", "active", true)
  Global.UI.setAttribute("ok_panel_text", "textColor", "#FFFFFFFF")
  Global.UI.setAttribute("cancel_panel_text", "active", false)
  Global.UI.setAttribute("confirm_panel_text", "active", false)
  Global.UI.setAttribute("panel_text", "active", true)
end

function showChronicleNameDialog()
  pendingDataString = curChronicleName
  renamingChronicle = true

  Global.UI.setAttribute("panel_text_description", "text", "Chronicle Name:\n(can be edited)")
  Global.UI.setAttribute("panel_text_data", "text", curChronicleName)
  Global.UI.setAttribute("ok_panel_text", "active", true)
  Global.UI.setAttribute("ok_panel_text", "textColor", "#FFFFFFFF")
  Global.UI.setAttribute("cancel_panel_text", "active", false)
  Global.UI.setAttribute("confirm_panel_text", "active", false)
  Global.UI.setAttribute("panel_text", "active", true)
end

function runPilgrimageCommand(player)
  local availableSites = {}
  local chosenSites = {}
  local removeSiteIndex = 0
  local numAvailableSites = 0
  local siteUsed = false
  local siteName = nil

  -- Make a list of unused sites.
  for siteCode = 0, (NUM_TOTAL_SITES - 1) do
    siteName = siteCardCodes[siteCode]
    siteUsed = false

    for siteIndex = 1,8 do
      if (siteName == curMapSites[siteIndex][1]) then
        siteUsed = true
        break
      end
    end

    if (false == siteUsed) then
      table.insert(availableSites, siteName)
      numAvailableSites = (numAvailableSites + 1)
    end
  end

  -- Choose 3 random available sites.
  chosenSites = {}
  for spawnCount = 1,3 do
    removeSiteIndex = math.random(1, numAvailableSites)
    table.insert(chosenSites, availableSites[removeSiteIndex])
    table.remove(availableSites, removeSiteIndex)
    numAvailableSites = (numAvailableSites - 1)
  end

  -- Spawn 3 random available sites to the player's hand with a slight delay to allow them to adjust and not stack.
  Wait.time(function() spawnPilgrimageSite(player, chosenSites[1]) end, 0.05)
  Wait.time(function() spawnPilgrimageSite(player, chosenSites[2]) end, 0.25)
  Wait.time(function() spawnPilgrimageSite(player, chosenSites[3]) end, 0.45)
end

function spawnPilgrimageSite(player, siteName)
  spawnSingleCard(siteName,
                  false,
                  handCardSpawnPositions[player.color][2],
                  handCardYRotations[player.color],
                  true)
end

function selectWinner(player, value, id)
  local adjustedColor = value

  if ("Brown" == adjustedColor) then
    adjustedColor = "Black"
  end

  if (true == player.host) then
    -- Make sure the selected winner was active in the game.
    if (true == curPlayerStatus[value][2]) then
      pendingWinningColor = value

      Global.UI.setAttribute("panel_select_winner", "active", false)
      Global.UI.setAttribute("winner_selection", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
      Global.UI.setAttribute("panel_confirm_winner", "active", true)
    else
      printToAll("Error, " .. adjustedColor .. " was not playing.", {1,0,0})
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function cancelSelectWinner(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_select_winner", "active", false)

    configGeneralButtons(BUTTONS_IN_GAME)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function cancelConfirmWinner(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_confirm_winner", "active", false)
    Global.UI.setAttribute("panel_select_winner", "active", true)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function confirmSelectWinner(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_confirm_winner", "active", false)

    printToAll("", {1,1,1})
    -- Check the Steam name in case the player disconnected.
    if ((nil != Player[pendingWinningColor]) and (nil != Player[pendingWinningColor].steam_name)) then
      printToAll(Player[pendingWinningColor].steam_name .. " is the winning player!", {1,1,1})
    else
      if ("Brown" == pendingWinningColor) then
        printToAll("Black is the winning color!", {1,1,1})
      else
        printToAll(pendingWinningColor .. " is the winning color!", {1,1,1})
      end
    end

    -- Scan the table while the game is still in progress.  Than, mark the game over.
    scanTable(false)

    printToAll("", {1,1,1})
    isChronicleInProgress = true
    isGameInProgress = false
    curGameCount = (curGameCount + 1)

    -- Resync all player boards with game state.
    for i,curColor in ipairs(playerColors) do
      updateRotationFromPlayerBoard(curColor)
    end

    -- If an Exile won, check if they used a vision.  If a Citizen won, check if they won by Succession.  Otherwise, move on to the next step.
    if ("Exile" == curPlayerStatus[pendingWinningColor][1]) then
      Global.UI.setAttribute("panel_use_vision_check", "active", true)
    elseif ("Citizen" == curPlayerStatus[pendingWinningColor][1]) then
      Global.UI.setAttribute("panel_succession_check", "active", true)
    else
      -- This simulates clicking no from the vision check dialog.
      visionCheckResult(player, "no", "use_vision_check_no")
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function toggleCitizenshipColor(player, value, id)
  if (false == grantCitizenshipLocked) then
    if ((true == player.host) or (player.color == winningColor)) then
      if (winningColor == value) then
        printToAll("That player won the game and will already become Chancellor.", {1,0,0})
      elseif ("Exile" != curPlayerStatus[value][1]) then
        printToAll("That player was a Citizen.", {1,0,0})
      elseif (false == curPlayerStatus[value][2]) then
        printToAll("That player was not playing.", {1,0,0})
      else
        if (false == grantPlayerCitizenship[value]) then
          grantPlayerCitizenship[value] = true
        else
          grantPlayerCitizenship[value] = false
        end

        Global.UI.setAttribute("mark_color_grant_" .. value, "active", grantPlayerCitizenship[value])
      end
    else
      printToAll("Error, only the host or winning player can click that.", {1,0,0})
    end
  else
    printToAll("Click \"Back\" if you want to change the selection.", {1,0,0})
  end -- end if (false == grantCitizenshipLocked)
end

function panelSelectWinnerDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_select_winner", "active", false)
  Global.UI.setAttribute("panel_select_winner", "active", true)
end

function panelConfirmWinnerDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_confirm_winner", "active", false)
  Global.UI.setAttribute("panel_confirm_winner", "active", true)
end

function panelUseVisionCheckDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_use_vision_check", "active", false)
  Global.UI.setAttribute("panel_use_vision_check", "active", true)
end

function panelSuccessionCheckDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_succession_check", "active", false)
  Global.UI.setAttribute("panel_succession_check", "active", true)
end

function panelChooseOathExceptDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_choose_oath_except", "active", false)
  Global.UI.setAttribute("panel_choose_oath_except", "active", true)
end

function configGeneralButtons(buttonConfig)
  gameDataObject.clearButtons()

  for i,curColor in ipairs(playerColors) do
    playerButtonIndices[curColor] = nil
  end

  if (BUTTONS_NONE == buttonConfig) then
    -- Nothing needs done.
  elseif (BUTTONS_NOT_IN_GAME == buttonConfig) then
    gameDataObject.createButton({
      label="Setup",
      click_function="setupButtonClicked",
      function_owner=self,
      position={ -10.0,   5.0, -33.0 },
      scale=   {   4.0,   4.0,   4.0 },
      rotation={   0.0, 180.0,   0.0 },
      width=700,
      height=500,
      font_size=144,
      color={ 1, 1, 1, 1 }
    })

    gameDataObject.createButton({
      label="Random\nSetup",
      click_function="randomSetupButtonClicked",
      function_owner=self,
      position={ -23.0,   5.0, -33.0 },
      scale=   {   4.0,   4.0,   4.0 },
      rotation={   0.0, 180.0,   0.0 },
      width=700,
      height=500,
      font_size=144,
      color={ 1, 1, 1, 1 }
    })

    gameDataObject.createButton({
      label="Import\nChronicle",
      click_function="importChronicleButtonClicked",
      function_owner=self,
      position={ -36.0,   5.0, -33.0 },
      scale=   {   4.0,   4.0,   4.0 },
      rotation={   0.0, 180.0,   0.0 },
      width=700,
      height=500,
      font_size=144,
      color={ 1, 1, 1, 1 }
    })

    gameDataObject.createButton({
      label="Export\nChronicle",
      click_function="exportChronicleButtonClicked",
      function_owner=self,
      position={ -50.0,   5.0, -33.0 },
      scale=   {   4.0,   4.0,   4.0 },
      rotation={   0.0, 180.0,   0.0 },
      width=700,
      height=500,
      font_size=144,
      color={ 1, 1, 1, 1 }
    })
  elseif (BUTTONS_IN_GAME == buttonConfig) then
    gameDataObject.createButton({
      label="Declare\nWinner",
      click_function="declareWinnerButtonClicked",
      function_owner=self,
      position={ 20.0,   5.0,  0.0 },
      scale=   {  4.0,   4.0,  4.0 },
      rotation={  0.0, 180.0,  0.0 },
      width=700,
      height=500,
      font_size=144,
      color={ 1, 1, 1, 1 }
    })

    createPlayerButtons()
  else
    -- This should never happen.
    printToAll("Error, invalid button config " .. buttonConfig, {1,0,0})
  end
end

-- Creates player buttons.
function createPlayerButtons()
  local buttonTable = nil
  local numButtonsCreated = 0
  local nextTableIndex = 1

  for i,curColor in ipairs(playerColors) do
    -- If this color is active in this game, and they are not Purple, create a citizen/exile button for them.
    if (true == curPlayerStatus[curColor][2]) then
      if ("Purple" != curColor) then
        if ("Exile" == curPlayerStatus[curColor][1]) then
          gameDataObject.createButton({
            label="Citizen",
            click_function="flipButtonClicked" .. curColor,
            function_owner=self,
            position=playerButtonPositions[curColor],
            scale=   { 2.0, 2.0, 2.0 },
            rotation={ 0.0, handCardYRotations[curColor], 0.0 },
            width=700,
            height=500,
            font_size=180,
            color=playerButtonColors[curColor]
          })

          numButtonsCreated = (numButtonsCreated + 1)
        else
          gameDataObject.createButton({
            label="Exile",
            click_function="flipButtonClicked" .. curColor,
            function_owner=self,
            position=playerButtonPositions[curColor],
            scale=   { 2.0, 2.0, 2.0 },
            rotation={ 0.0, handCardYRotations[curColor],  0.0 },
            width=700,
            height=500,
            font_size=180,
            color=playerButtonColors[curColor]
          })

          numButtonsCreated = (numButtonsCreated + 1)
        end
      end
    end
  end

  -- Get indices of all player buttons.
  buttonTable = gameDataObject.getButtons()

  nextTableIndex = ((#buttonTable - numButtonsCreated) + 1)
  for i,curColor in ipairs(playerColors) do
    if (true == curPlayerStatus[curColor][2]) then
      if ("Purple" != curColor) then
        playerButtonIndices[curColor] = buttonTable[nextTableIndex].index
        nextTableIndex = (nextTableIndex + 1)
      end
    end
  end
end

-- The below functions are for a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.

function panelSelectPlayersDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_select_players", "active", false)
  Global.UI.setAttribute("panel_select_players", "active", true)
end

function panelOfferCitizenshipDrag()
  Global.UI.setAttribute("panel_offer_citizenship", "active", false)
  Global.UI.setAttribute("panel_offer_citizenship", "active", true)
end

function panelChooseVisionDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_choose_vision", "active", false)
  Global.UI.setAttribute("panel_choose_vision", "active", true)
end

function panelSelectOathDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_select_oath", "active", false)
  Global.UI.setAttribute("panel_select_oath", "active", true)
end

function panelBuildRepairDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_build_repair", "active", false)
  Global.UI.setAttribute("panel_build_repair", "active", true)
end

function panelBuildRepairCardsDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_build_repair_cards", "active", false)
  Global.UI.setAttribute("panel_build_repair_cards", "active", true)
end

function panelChooseEdificeDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_choose_edifice", "active", false)
  Global.UI.setAttribute("panel_choose_edifice", "active", true)
end

function panelSelectSuitDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_select_suit", "active", false)
  Global.UI.setAttribute("panel_select_suit", "active", true)
end

function panelTextDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_text", "active", false)
  Global.UI.setAttribute("panel_text", "active", true)
end

function panelEraseChronicleCheckDrag()
  -- This is a TTS bug workaround since otherwise, a button highlight stops working if the user clicks a button and then drags it.
  Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)
  Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
end

function closePanelText(player, value, id)
  local newChronicleNameLength = nil
  local cleanedStringV1 = nil
  local cleanedStringV2 = nil

  if (true == player.host) then
    Global.UI.setAttribute("panel_text", "active", false)

    if ("ok" == value) then
      if (true == renamingChronicle) then
        newChronicleNameLength = string.len(pendingDataString)

        if ((newChronicleNameLength >= MIN_CHRONICLE_NAME_LENGTH) and
            (newChronicleNameLength <= MAX_CHRONICLE_NAME_LENGTH)) then
          -- Clean up the string by remove any starting and trailing newlines, linefeeds, and/or whitespace.
          cleanedStringV1 = string.gsub(pendingDataString, "^[%s\n\r]+", "");
          cleanedStringV2 = string.gsub(cleanedStringV1, "[%s\n\r]+$", "");

          if (curChronicleName != cleanedStringV2) then
            curChronicleName = cleanedStringV2
            printToAll("", {1,1,1})
            printToAll("The course of history has changed.", {1,1,1})
            printToAll("The chronicle is now titled \"" .. curChronicleName .. "\".", {0,0.8,0})
            printToAll("", {1,1,1})
          end
        else
          printToAll("Error, chronicle name must be at least 1 character and no more than 255 characters.", {1,0,0})
        end
      end
    elseif ("cancel" == value) then
      -- Nothing needs done.
    elseif ("confirm" == value) then
      -- This is only used for the import case.  Since this erases the chronicle, double check first.
      pendingEraseType = "import"
      Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
    else
      -- This should never happen.
      printToAll("Error, invalid state.", {1,0,0})
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function panelTextEndEdit(player, value, id)
  pendingDataString = value
end

function eraseChronicleCheckResult(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)

    if ("yes" == value) then
      if ("import" == pendingEraseType) then
        loadFromSaveString(pendingDataString, false)
        cleanTable()

        pendingEraseType = nil
      elseif ("reset" == pendingEraseType) then
        initDefaultGameState()
        loadFromSaveString(chronicleStateString, false)
        cleanTable()

        printToAll("", {1,1,1})
        printToAll("The wheel of time turns again.", {1,1,1})
        printToAll("", {1,1,1})

        pendingEraseType = nil
      elseif ("randomSetup" == pendingEraseType) then
        Global.UI.setAttribute("panel_erase_chronicle_check", "active", false)
        randomEnabled = true
        commonSetup()
      else
        -- This should never happen.
        printToAll("Error, invalid erase type.", {1,0,0})
      end
    else -- end if ("yes" == value)
      printToAll("Operation cancelled.", {1,1,1})
    end
  else -- end if (true == player.host)
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function setupButtonClicked(buttonObject, playerColor, altClick)
  if (true == Player[playerColor].host) then
    randomEnabled = false
    commonSetup()
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function randomSetupButtonClicked(buttonObject, playerColor, altClick)
  if (true == Player[playerColor].host) then
    pendingEraseType = "randomSetup"
    Global.UI.setAttribute("panel_erase_chronicle_check", "active", true)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function declareWinnerButtonClicked(buttonObject, playerColor, altClick)
  if (true == Player[playerColor].host) then
    configGeneralButtons(BUTTONS_NONE)

    Global.UI.setAttribute("panel_select_winner", "active", true)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function flipButtonClickedBrown(buttonObject, playerColor, altClick)
  local buttonPlayerColor = "Brown"

  if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
    curPlayerStatus[buttonPlayerColor][1] = "Citizen"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

    -- Note special case:  TTS "Brown" is Oath "Black".
    printToAll("Black is now a Citizen.", {1,1,1})
  else
    curPlayerStatus[buttonPlayerColor][1] = "Exile"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

    -- Note special case:  TTS "Brown" is Oath "Black".
    printToAll("Black is now an Exile.", {1,1,1})
  end
end

function flipButtonClickedYellow(buttonObject, playerColor, altClick)
  local buttonPlayerColor = "Yellow"

  if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
    curPlayerStatus[buttonPlayerColor][1] = "Citizen"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

    printToAll(buttonPlayerColor .. " is now a Citizen.", {1,1,1})
  else
    curPlayerStatus[buttonPlayerColor][1] = "Exile"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

    printToAll(buttonPlayerColor .. " is now an Exile.", {1,1,1})
  end
end

function flipButtonClickedWhite(buttonObject, playerColor, altClick)
  local buttonPlayerColor = "White"

  if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
    curPlayerStatus[buttonPlayerColor][1] = "Citizen"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

    printToAll(buttonPlayerColor .. " is now a Citizen.", {1,1,1})
  else
    curPlayerStatus[buttonPlayerColor][1] = "Exile"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

    printToAll(buttonPlayerColor .. " is now an Exile.", {1,1,1})
  end
end

function flipButtonClickedBlue(buttonObject, playerColor, altClick)
  local buttonPlayerColor = "Blue"

  if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
    curPlayerStatus[buttonPlayerColor][1] = "Citizen"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

    printToAll(buttonPlayerColor .. " is now a Citizen.", {1,1,1})
  else
    curPlayerStatus[buttonPlayerColor][1] = "Exile"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

    printToAll(buttonPlayerColor .. " is now an Exile.", {1,1,1})
  end
end

function flipButtonClickedRed(buttonObject, playerColor, altClick)
  local buttonPlayerColor = "Red"

  if ("Exile" == curPlayerStatus[buttonPlayerColor][1]) then
    curPlayerStatus[buttonPlayerColor][1] = "Citizen"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Exile"})

    printToAll(buttonPlayerColor .. " is now a Citizen.", {1,1,1})
  else
    curPlayerStatus[buttonPlayerColor][1] = "Exile"
    updatePlayerBoardRotation(buttonPlayerColor)

    gameDataObject.editButton({ index = playerButtonIndices[buttonPlayerColor], label = "Citizen"})

    printToAll(buttonPlayerColor .. " is now an Exile.", {1,1,1})
  end
end

function commonSetup()
  configGeneralButtons(BUTTONS_NONE)

  for i,curColor in ipairs(playerColors) do
    if ("Purple" == curColor) then
      -- The Chancellor is always active.
      curPlayerStatus[curColor][2] = true
      Global.UI.setAttribute("mark_color_purple", "active", true)
    else
      curPlayerStatus[curColor][2] = Player[curColor].seated
      Global.UI.setAttribute("mark_color_" .. curColor, "active", Player[curColor].seated)
    end
  end

  Global.UI.setAttribute("panel_select_players", "active", true)
end

function toggleColor(player, value, id)
  if (true == player.host) then
    if ("Purple" == value) then
      printToAll("The Chancellor demands your respect and is in every game.", {1,0,0})
    else
      if (false == curPlayerStatus[value][2]) then
        curPlayerStatus[value][2] = true
      else
        curPlayerStatus[value][2] = false
      end

      Global.UI.setAttribute("mark_color_" .. value, "active", curPlayerStatus[value][2])
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function cancelSelectPlayers(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_select_players", "active", false)

    configGeneralButtons(BUTTONS_NOT_IN_GAME)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function selectOath(player, value, id)
  if (true == player.host) then
    curGameNumPlayers = 0
    for i,curColor in ipairs(playerColors) do
      if (true == curPlayerStatus[curColor][2]) then
        curGameNumPlayers = (curGameNumPlayers + 1)
      end
    end

    if (curGameNumPlayers > 1) then
      Global.UI.setAttribute("panel_select_players", "active", false)

      if (true == randomEnabled) then
        curOath = oathNamesFromCode[math.random(0, 3)]
      end

      Global.UI.setAttribute("mark_oath", "offsetXY", selectOathOffsets[curOath])
      Global.UI.setAttribute("panel_select_oath", "active", true)
    else -- end if (curGameNumPlayers > 1)
      printToAll("Error, at least one non-Chancellor player must also be selected.", {1,0,0})
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function changeOath(player, value, id)
  if (true == player.host) then
    curOath = oathNamesFromCode[tonumber(value)]
    Global.UI.setAttribute("mark_oath", "offsetXY", selectOathOffsets[curOath])
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function confirmSelectOath(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_select_oath", "active", false)

    if (true == randomEnabled) then
      randomizeChronicle()
      cleanTable()
      loadFromSaveString(chronicleStateString, true)
    else
      cleanTable()
      setupGame()
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function cancelSelectOath(player, value, id)
  if (true == player.host) then
    Global.UI.setAttribute("panel_select_oath", "active", false)
    Global.UI.setAttribute("panel_select_players", "active", true)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function randomizeChronicle()
  local availableSites = nil
  local numAvailableSites = 0
  local removeSiteIndex = 0
  local availableDenizens = nil
  local availableDenizenIndex = nil
  local numAvailableDenizens = 0
  local removeDenizenIndex = 0

  printToAll("Randomizing chronicle.", {1,1,1})

  --
  -- Randomize sites.
  --

  -- First, make a list of all site names.
  availableSites = {}
  numAvailableSites = 0
  for siteCode = 0, (NUM_TOTAL_SITES - 1) do
    -- Copy into 1-based array.
    availableSites[siteCode + 1] = siteCardCodes[siteCode]
    numAvailableSites = (numAvailableSites + 1)
  end
  -- Next, assign random available sites.
  for siteIndex = 1,8 do
    removeSiteIndex = math.random(1, numAvailableSites)
    curMapSites[siteIndex][1] = availableSites[removeSiteIndex]
    table.remove(availableSites, removeSiteIndex)
    numAvailableSites = (numAvailableSites - 1)
  end
  -- Next, reset the facedown status of all sites to default.
  curMapSites[1][2] = false
  curMapSites[2][2] = true
  curMapSites[3][2] = false
  curMapSites[4][2] = true
  curMapSites[5][2] = true
  curMapSites[6][2] = false
  curMapSites[7][2] = true
  curMapSites[8][2] = true

  -- Reset denizen state.
  for siteIndex = 1,8 do
    for normalCardIndex = 1,3 do
      curMapNormalCards[siteIndex][normalCardIndex][1] = "NONE"   -- No card.
      curMapNormalCards[siteIndex][normalCardIndex][2] = false    -- NOT flipped.
    end
  end

  --
  -- Randomize world deck.
  --

  -- First, make a list of all denizen card names.
  availableDenizens = {}
  numAvailableDenizens = 0
  availableDenizenIndex = 1
  for denizenCode = 0, (NUM_TOTAL_DENIZENS - 1) do
    -- Copy into 1-based array.
    availableDenizens[availableDenizenIndex] = normalCardCodes[denizenCode]
    availableDenizenIndex = (availableDenizenIndex + 1)
    numAvailableDenizens = (numAvailableDenizens + 1)
  end
  -- Now, generate a randomized world deck using the denizens as card options, and 54 denizens as the number to choose.
  generateRandomWorldDeck(availableDenizens, numAvailableDenizens, 54)
  -- Generate randomized relic deck.
  generateRandomRelicDeck({}, 0, 0)

  --
  -- Reset dispossessed deck.
  --

  curDispossessedDeckCardCount = 0
  curDispossessedDeckCards = {}

  -- Finally, generate the chronicle state string.
  chronicleStateString = generateSaveString()
end

-- If a game is in progress, scans the table and updates state variables.
function scanTable(alwaysScan)
  local scriptZoneObjects = nil
  local cardName = nil
  local cardInfo = nil
  local siteInfo = nil
  local cardRotation = 0

  -- Only scan the table if a game is in progress, or if the caller requested a scan always be performed.  Otherwise assume the table is up to date.
  if ((true == isGameInProgress) or (true == alwaysScan)) then
    -- Assume all edifice/ruin cards are in the archive until proven otherwise.
    for edificeIndex = 1,6 do
      edificesInArchive[edificeIndex] = true
    end

    -- Scan player advisers.
    for i,curColor in ipairs(playerColors) do
      numPlayerAdvisers[curColor] = 0
      playerAdvisers[curColor] = {}

      --
      -- Even though there are 3 adviser slots, scan stacked cards in case Family Wagon was used
      -- and cards were stacked before the Chronicle phase.
      --

      for adviserSlotIndex = 1,3 do
        scriptZoneObjects = playerAdviserZones[curColor][adviserSlotIndex].getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
          if ("Deck" == curObject.tag) then
            -- Since a deck was encountered, scan it for Denizen cards.
            for i,curCardInDeck in ipairs(curObject.getObjects()) do
              cardName = curCardInDeck.nickname
              cardInfo = cardsTable[cardName]

              if (nil != cardInfo) then
                if ("Denizen" == cardInfo.cardtype) then
                  numPlayerAdvisers[curColor] = (numPlayerAdvisers[curColor] + 1)
                  playerAdvisers[curColor][numPlayerAdvisers[curColor]] = cardName
                end
              end -- end if (nil != cardInfo)
            end
          elseif ("Card" == curObject.tag) then
            cardName = curObject.getName()
            cardInfo = cardsTable[cardName]

            if (nil != cardInfo) then
              if ("Denizen" == cardInfo.cardtype) then
                numPlayerAdvisers[curColor] = (numPlayerAdvisers[curColor] + 1)
                playerAdvisers[curColor][numPlayerAdvisers[curColor]] = cardName
              end
            end -- end if (nil != cardInfo)
          end -- end if ("Card" == curObject.tag)
        end -- end for i,curObject in ipairs(scriptZoneObjects)
      end -- end for adviserSlotIndex = 1,3
    end -- end for i,curColor in ipairs(playerColors)

    -- Scan discard piles.
    for discardZoneIndex = 1,3 do
      discardContents[discardZoneIndex] = {}

      scriptZoneObjects = discardZones[discardZoneIndex].getObjects()
      for i,curObject in ipairs(scriptZoneObjects) do
        if ("Deck" == curObject.tag) then
          -- Since a deck was encountered, scan it for Denizen or Vision cards.
          for i,curCardInDeck in ipairs(curObject.getObjects()) do
            cardName = curCardInDeck.nickname
            cardInfo = cardsTable[cardName]

            if (("Denizen" == cardInfo.cardtype) or ("Vision" == cardInfo.cardtype)) then
              table.insert(discardContents[discardZoneIndex], cardName)
            end
          end
        elseif ("Card" == curObject.tag) then
          cardName = curObject.getName()
          cardInfo = cardsTable[cardName]

          if (("Denizen" == cardInfo.cardtype) or ("Vision" == cardInfo.cardtype)) then
            table.insert(discardContents[discardZoneIndex], cardName)
          end
        else
          -- Nothing needs done.
        end -- end if ("Deck" == curObject.tag)
      end -- end for i,curObject in ipairs(scriptZoneObjects)
    end -- end for discardZoneIndex = 1,3

    -- Scan map sites.
    for siteIndex = 1,8 do
      -- Reset the variables for this site before scanning.
      curMapNormalCards[siteIndex][1][1] = "NONE"     -- No card.
      curMapNormalCards[siteIndex][1][2] = false      -- NOT flipped.
      curMapNormalCards[siteIndex][2][1] = "NONE"     -- No card.
      curMapNormalCards[siteIndex][2][2] = false      -- NOT flipped.
      curMapNormalCards[siteIndex][3][1] = "NONE"     -- No card.
      curMapNormalCards[siteIndex][3][2] = false      -- NOT flipped.

      -- Find site card name.

      scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
      for i,curObject in ipairs(scriptZoneObjects) do
        if ("Card" == curObject.tag) then
          siteInfo = cardsTable[curObject.getName()]

          if (nil != siteInfo) then
            curMapSites[siteIndex][1] = curObject.getName()

            -- Detect whether the card is flipped.
            cardRotation = curObject.getRotation()
            if ((cardRotation[3] >= 150) and (cardRotation[3] <= 210)) then
              curMapSites[siteIndex][2] = true
            else
              curMapSites[siteIndex][2] = false
            end
          else
            printToAll("Error, invalid site card with name \"" .. curObject.getName() .. "\".", {1,0,0})
            saveStatus = STATUS_FAILURE
          end

          break
        end
      end

      -- Find denizen card names.

      for normalCardIndex = 1,3 do
        scriptZoneObjects = mapNormalCardZones[siteIndex][normalCardIndex].getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
          if ("Card" == curObject.tag) then
            cardName = curObject.getName()
            cardInfo = cardsTable[cardName]

            if (nil != cardInfo) then
              curMapNormalCards[siteIndex][normalCardIndex][1] = curObject.getName()

              -- Detect whether the card is flipped.
              cardRotation = curObject.getRotation()
              if ((cardRotation[3] >= 150) and (cardRotation[3] <= 210)) then
                curMapNormalCards[siteIndex][normalCardIndex][2] = true
              else
                curMapNormalCards[siteIndex][normalCardIndex][2] = false
              end

              -- Detect whether the site is an edifice/ruin, and if so, remove it from the archive list.
              if ("EdificeRuin" == cardInfo.cardtype) then
                edificesInArchive[((cardInfo.saveid - 198) / 2) + 1] = false
              end
            else
              printToAll("Error, invalid denizen/edifice/ruin/relic card with name \"" .. curObject.getName() .. "\".", {1,0,0})
              saveStatus = STATUS_FAILURE
            end

            break
          end -- end if ("Card" == curObject.tag)
        end -- end for i,curObject in ipairs(scriptZoneObjects)
      end -- end for normalCardIndex = 1,3
    end -- for siteIndex = 1,8

    -- Determine the number of edifices in the archive.  This is done after the loop in case of duplicate cards above.
    numEdificesInArchive = 0
    for edificeIndex = 1,6 do
      if (true == edificesInArchive[edificeIndex]) then
        numEdificesInArchive = (numEdificesInArchive + 1)
      end
    end
  end -- if ((true == isGameInProgress) or (true == alwaysScan))
end

-- IMPORTANT:  The game end process (winner, suit choice and reordering, exile/citizen status update, new oath)
--             must be finished BEFORE this function is called.
function generateSaveString()
  local basicDataString = nil
  local mapDataString = nil
  local basicDataString = nil
  local worldDeckDataString = nil
  local dispossessedDataString = nil
  local relicDeckDataString = nil
  local saveString = nil
  local scriptZoneObjects = nil
  local siteInfo = nil
  local cardInfo = nil
  local cardRotation = 0
  -- Site, normal, normal, normal card save IDs respectively.
  local curSiteSaveIDs = { nil, nil, nil, nil }
  local deckCardID = nil

  -- Set the global save status.
  saveStatus = STATUS_SUCCESS

  --
  -- Generate basic data string.
  --
  if (STATUS_SUCCESS == saveStatus) then
    basicDataString = string.format(
      "%02X%02X%02X%04X%02X%s%02X%02X%02X%01X%01X%01X%01X%01X%01X",
      OATH_MAJOR_VERSION,
      OATH_MINOR_VERSION,
      OATH_PATCH_VERSION,
      curGameCount,
      string.len(curChronicleName),
      curChronicleName,
      0x00, -- unused
      generateExileCitizenStatusByte(),
      oathCodes[curOath],
      suitCodes[curSuitOrder[1]],
      suitCodes[curSuitOrder[2]],
      suitCodes[curSuitOrder[3]],
      suitCodes[curSuitOrder[4]],
      suitCodes[curSuitOrder[5]],
      suitCodes[curSuitOrder[6]])
  end -- end if (STATUS_SUCCESS == saveStatus)

  --
  -- Generate map data string.
  --
  if (STATUS_SUCCESS == saveStatus) then
    mapDataString = ""
    for siteIndex = 1,8 do
      -- Add 24 to represent a facedown site if needed.
      if (("NONE" != curMapSites[siteIndex][1]) and
          (true == curMapSites[siteIndex][2])) then
        curSiteSaveIDs[1] = (cardsTable[curMapSites[siteIndex][1]].saveid + 24)
      else
        curSiteSaveIDs[1] = cardsTable[curMapSites[siteIndex][1]].saveid
      end

      -- Set save IDs, adjusting if needed for ruins.
      for normalCardIndex = 1,3 do
        cardInfo = cardsTable[curMapNormalCards[siteIndex][normalCardIndex][1]]

        if (nil != cardInfo) then
          -- If the card is an edifice/ruin and it is flipped, increment the save ID.
          if (("EdificeRuin" == cardInfo.cardtype) and
              (true == curMapNormalCards[siteIndex][normalCardIndex][2])) then
            curSiteSaveIDs[1 + normalCardIndex] = (cardInfo.saveid + 1)
          else
            curSiteSaveIDs[1 + normalCardIndex] = cardInfo.saveid
          end
        else
          printToAll("Error, invalid normal card with name \"" .. curMapNormalCards[siteIndex][normalCardIndex][1] .. "\".", {1,0,0})
          saveStatus = STATUS_FAILURE
        end
      end

      mapDataString = (mapDataString .. string.format(
        "%02X%02X%02X%02X",
        curSiteSaveIDs[1],
        curSiteSaveIDs[2],
        curSiteSaveIDs[3],
        curSiteSaveIDs[4]))
    end -- end for siteIndex = 1,8
  end -- end if (STATUS_SUCCESS == saveStatus)

  --
  -- Generate world deck data string.
  --
  if (STATUS_SUCCESS == saveStatus) then
    worldDeckDataString = string.format("%02X", curWorldDeckCardCount)
    for cardIndex = 1,curWorldDeckCardCount do
      deckCardID = cardsTable[curWorldDeckCards[cardIndex]].saveid
      worldDeckDataString = (worldDeckDataString .. string.format("%02X", deckCardID))   -- Card ID for denizen card or vision
    end
  end -- end if (STATUS_SUCCESS == saveStatus)

  --
  -- Generate dispossessed data string.
  --
  if (STATUS_SUCCESS == saveStatus) then
    dispossessedDataString = string.format("%02X", curDispossessedDeckCardCount)
    for cardIndex = 1,curDispossessedDeckCardCount do
      deckCardID = cardsTable[curDispossessedDeckCards[cardIndex]].saveid
      dispossessedDataString = (dispossessedDataString .. string.format("%02X", deckCardID))    -- Card ID for denizen card or vision
    end
  end -- end if (STATUS_SUCCESS == saveStatus)

  --
  -- Generate relic deck data string.
  --
  if (STATUS_SUCCESS == saveStatus) then
    relicDeckDataString = string.format("%02X", curRelicDeckCardCount)
    for cardIndex = 1,curRelicDeckCardCount do
      deckCardID = cardsTable[curRelicDeckCards[cardIndex]].saveid
      relicDeckDataString = (relicDeckDataString .. string.format("%02X", deckCardID))   -- Card ID for relic card
    end
  end -- end if (STATUS_SUCCESS == saveStatus)

  --
  -- Generate save string.
  --
  if (STATUS_SUCCESS == saveStatus) then
    saveString = (basicDataString .. mapDataString .. worldDeckDataString .. dispossessedDataString .. relicDeckDataString)
  end -- end if (STATUS_SUCCESS == saveStatus)

  return saveString
end

function generateExileCitizenStatusByte()
   local generatedByte = 0x00

   -- The exile/citizen status byte is generated from most to least significant bits:
   --   0 (unused)
   --   0 (unused)
   --   0 (unused)
   --   1 == Brown player (black pieces) is Citizen, 0 == Exile
   --   1 == Yellow player is Citizen, 0 == Exile
   --   1 == White player is Citizen, 0 == Exile
   --   1 == Blue player is Citizen, 0 == Exile
   --   1 == Red player is Citizen, 0 == Exile

   -- Since the Tabletop Simulator version of Lua does not include normal bitwise operators,
   -- bit32.bor() is used for binary OR operations.

   if ("Citizen" == (curPlayerStatus.Brown[1])) then
      generatedByte = bit32.bor(generatedByte, 0x10)
   end

   if ("Citizen" == (curPlayerStatus.Yellow[1])) then
      generatedByte = bit32.bor(generatedByte, 0x08)
   end

   if ("Citizen" == (curPlayerStatus.White[1])) then
      generatedByte = bit32.bor(generatedByte, 0x04)
   end

   if ("Citizen" == (curPlayerStatus.Blue[1])) then
      generatedByte = bit32.bor(generatedByte, 0x02)
   end

   if ("Citizen" == (curPlayerStatus.Red[1])) then
      generatedByte = bit32.bor(generatedByte, 0x01)
   end

   return generatedByte
end

-- This function is used to clean up the table by deleting object(s), moving object(s) to default locations if needed, etc.
function cleanTable()
  local allObjects = nil
  local curObjectName = nil
  local curObjectDescription = nil
  local curObjectColor = nil
  local curObjectPosition = nil
  local curMarker = nil

  --
  -- Delete all decks and cards.  Move all pawns and warbands back to their starting locations and supply bags, respectively.
  --
  -- Also delete all favor and secret tokens other than the hidden unlabeled ones.
  --

  Objects = getAllObjects()

  for i,curObject in ipairs(Objects) do
    curObjectName = curObject.getName()

    if (("Deck" == curObject.tag) or ("Card" == curObject.tag)) then
      destroyObject(curObject)
    elseif ("Figurine" == curObject.tag) then
      curObjectDescription = curObject.getDescription()
      if ("Warband" == curObjectName) then
        if ("Black" == curObjectDescription) then
          curObjectColor = "Brown"
        else
          curObjectColor = curObjectDescription
        end

        -- Move the warband below the table so the warbands do not flicker as they cleanup.
        curObjectPosition = curObject.getPosition()
        -- Set the warband's rotation to match the starting pawn rotation, and put the warband back in the matching bag.
        curObject.setRotation({ 0.0, pawnStartYRotations[curObjectColor], 0.0 })
        curObject.setPosition({ curObjectPosition[1], (-3.5), curObjectPosition[3] })
        playerWarbandBags[curObjectColor].putObject(curObject)
      elseif ("Pawn" == curObjectName) then
        if ("Black" == curObjectDescription) then
          curObjectColor = "Brown"
        else
          curObjectColor = curObjectDescription
        end

        -- Move the pawn back to its starting position.
        curObject.setRotation({ 0.0, pawnStartYRotations[curObjectColor], 0.0 })
        curObject.setPosition(pawnStartPositions[curObjectColor])
      else
        -- Nothing needs done.
      end
    elseif ("Generic" == curObject.tag) then
      if (("Favor" == curObjectName) or
          ("Favor (" == string.sub(curObject.getName(), 1, 7))) then
        destroyObject(curObject)
      elseif ("Secret" == curObjectName) then
        destroyObject(curObject)
      end
    else
      -- Nothing needs done.
    end
  end

  -- Empty favor bag.
  if (nil != favorBag) then
    favorBag.reset()
  end

  -- Empty secret bag.
  if (nil != secretBag) then
    secretBag.reset()
  end

  -- Reset markers to default locations.
  for markerIndex = 1,numMarkers do
    curMarker = getObjectFromGUID(markerGuids[markerIndex])
    if (nil != curMarker) then
      curMarker.setPosition({ markerPositions[markerIndex][1], markerPositions[markerIndex][2], markerPositions[markerIndex][3] })
      curMarker.setRotation({ 0, 0, 0 })
    else
      printToAll("Error finding object.", {1,0,0})
    end
  end

  -- Hide pieces for all players.
  for i,curColor in ipairs(playerColors) do
    hidePieces(curColor)
  end

  -- Hide dice.
  hideDice()
end

function showDice()
  local curDie = nil

  for dieIndex = 1,numDice do
    curDie = getObjectFromGUID(diceGuids[dieIndex])
    if (nil != curDie) then
      curDie.setPosition({ dicePositions[dieIndex][1], dicePositions[dieIndex][2], dicePositions[dieIndex][3] })
      if (7 == dieIndex) then
        curDie.setRotation({ 270, 0, 0 })
      else
        curDie.setRotation({ 90, 0, 0 })
      end

      curDie.locked = false
      curDie.interactable = true
    else
      printToAll("Error finding die.", {1,0,0})
    end
  end
end

function hideDice()
  local curDie = nil

  for dieIndex = 1,numDice do
    curDie = getObjectFromGUID(diceGuids[dieIndex])
    if (nil != curDie) then
      curDie.setPosition({ dicePositions[dieIndex][1], (-3.5), dicePositions[dieIndex][3] })
      if (15 == dieIndex) then
        curDie.setRotation({ 270, 0, 0 })
      else
        curDie.setRotation({ 90, 0, 0 })
      end

      curDie.locked = true
      curDie.interactable = false
    else
      printToAll("Error finding die.", {1,0,0})
    end
  end
end

function setWarbandBagsMuted(muteBags)
  for i,curColor in ipairs(playerColors) do
    playerWarbandBags[curColor].getComponent("AudioSource").set("mute", muteBags)
  end
end

function setupLoadedState(setupGameAfter)
  -- Reset expected and actual spawn count.
  loadExpectedSpawnCount = 0
  loadActualSpawnCount = 0

  --
  -- Copy the load variables into the corresponding game variables.
  --

  curGameCount = loadGameCount
  curChronicleName = loadChronicleName

  -- The chancellor is always playing.  More players will be added as they are detected in the loop below.
  curGameNumPlayers = 1

  for loopKey,loopValue in pairs(loadPlayerStatus) do
    curPlayerStatus[loopKey][1] = loopValue[1]

    --
    -- Only update active player status if the game is NOT being setup after this.
    --
    -- If setup will run after this, then the current active player status is already correct,
    -- and the loaded status might be incorrect, e.g. the default state.
    --
    if (false == setupGameAfter) then
      curPlayerStatus[loopKey][2] = loopValue[2]
    end

    -- If the player is active, increment the number of players.
    if (true == curPlayerStatus[loopKey][2]) then
      curGameNumPlayers = (curGameNumPlayers + 1)
    end
  end

  curOath = loadCurOath

  for loopIndex,loopValue in ipairs(loadSuitOrder) do
    curSuitOrder[loopIndex] = loopValue
  end

  for loopIndex,loopValue in ipairs(loadMapSites) do
    curMapSites[loopIndex][1] = loopValue[1]
    curMapSites[loopIndex][2] = loopValue[2]
  end

  for loopIndex,loopValue in ipairs(loadMapNormalCards) do
    curMapNormalCards[loopIndex][1][1] = loopValue[1][1]
    curMapNormalCards[loopIndex][1][2] = loopValue[1][2]
    curMapNormalCards[loopIndex][2][1] = loopValue[2][1]
    curMapNormalCards[loopIndex][2][2] = loopValue[2][2]
    curMapNormalCards[loopIndex][3][1] = loopValue[3][1]
    curMapNormalCards[loopIndex][3][2] = loopValue[3][2]
  end

  curWorldDeckCardCount = loadWorldDeckInitCardCount
  for cardIndex = 1,curWorldDeckCardCount do
    curWorldDeckCards[cardIndex] = loadWorldDeckInitCards[cardIndex]
  end

  curDispossessedDeckCardCount = loadDispossessedDeckInitCardCount
  for cardIndex = 1,curDispossessedDeckCardCount do
    curDispossessedDeckCards[cardIndex] = loadDispossessedDeckInitCards[cardIndex]
  end

  curRelicDeckCardCount = loadRelicDeckInitCardCount
  for cardIndex = 1,curRelicDeckCardCount do
    curRelicDeckCards[cardIndex] = loadRelicDeckInitCards[cardIndex]
  end

  -- Update player board exile/citizen flipping status.
  for i,curColor in ipairs(playerColors) do
    updatePlayerBoardRotation(curColor)
  end

  if (true == isGameInProgress) then
    -- If a game is in progress, do not spawn anything.  Go directly to the end of the load process.
    finishSetupLoadedState(setupGameAfter)
  else
    -- Briefly wait before spawning the new cards.
    Wait.time(function() continueSetupLoadedState(setupGameAfter) end, 0.05)
  end
end

function continueSetupLoadedState(setupGameAfter)
  finishSetupLoadedState(setupGameAfter)
end

function finishSetupLoadedState(setupGameAfter)
  loadWaitID = nil

  if (STATUS_SUCCESS == loadStatus) then
    printToAll("Load successful.", {0,0.8,0})
    printToAll("", {1,1,1})
    printToAll("Ready for game #" .. loadGameCount .. " of the chronicle \"" .. loadChronicleName .. "\".", {1,1,1})
    printToAll("The current oath is \"" .. fullOathNames[curOath] .. "\".", {1,1,1})

    if (true == isGameInProgress) then
      configGeneralButtons(BUTTONS_IN_GAME)

      printToAll("Game already in progress.  Active players:", {1,1,1})
      for i,curColor in ipairs(playerColors) do
        if (true == loadPlayerStatus[curColor][2]) then
          if ("Brown" == curColor) then
            printToAll("   Black:  " .. loadPlayerStatus[curColor][1], {1,1,1})
          else
            printToAll("   " .. curColor .. ":  " .. loadPlayerStatus[curColor][1], {1,1,1})
          end
        end
      end
    else -- end if (true == isGameInProgress)
      configGeneralButtons(BUTTONS_NOT_IN_GAME)
    end

    -- The following can be used for load timing.
    --printToAll("Time:  " .. Time.time, {1,1,1})

    if (true == setupGameAfter) then
      setupGame()
    end
  end -- end if (STATUS_SUCCESS == loadStatus)

  printToAll("", {1,1,1})
end

function resetOathkeeperToken()
  if (nil != curOathkeeperToken) then
    curOathkeeperToken.setPosition({ oathkeeperStartPosition[1], oathkeeperStartPosition[2], oathkeeperStartPosition[3] })
    curOathkeeperToken.setRotation({ oathkeeperStartRotation[1], oathkeeperStartRotation[2], oathkeeperStartRotation[3] })
    curOathkeeperToken.setScale({ oathkeeperStartScale[1], oathkeeperStartScale[2], oathkeeperStartScale[3] })

    curOathkeeperToken.setName(fullOathNames[curOath] .. ":  Oathkeeper / Usurper")
    curOathkeeperToken.setDescription(oathDescriptions[curOath])
  else
    printToAll("Error, oathkeeper token not found.", {1,0,0})
  end
end

function spawnSingleCard(cardName, spawnFacedown, spawnPosition, cardRotY, spawnInHand)
  local spawnStatus = STATUS_SUCCESS
  -- Create a copy of the spawn position to avoid problems with the data changing elsewhere.
  local spawnPositionLocal = { spawnPosition[1], spawnPosition[2], spawnPosition[3] }
  local spawnParams = {}
  local cardJSON = nil
  local cardDeckID = 0
  local cardInfo = cardsTable[cardName]
  local ttsCardID = 0
  local cardType = nil
  local cardTTSDeckInfo = nil
  local hasUniqueBack = false
  local cardScaleX = 0
  local cardScaleZ = 0
  local internalCardRotZ = 0.0
  local shouldUnlock = false
  local shouldHideWhenFaceDown = true

  if (nil != cardInfo) then
    ttsCardID = cardInfo.ttscardid
    cardType = cardInfo.cardtype

    if ("Site" == cardType) then
      cardScaleX = 1.46
      cardScaleZ = 1.46
      shouldUnlock = false
    elseif ("Relic" == cardType) then
      cardScaleX = 0.96
      cardScaleZ = 0.96
      shouldUnlock = true
    else
      -- Use default scaling for other cards.
      cardScaleX = 1.50
      cardScaleZ = 1.50
      shouldUnlock = true
    end

    -- If spawning a card in the player's hand, always unlock it.
    if (true == spawnInHand) then
      shouldUnlock = true
    end

    -- All cards spawn facedown and will unflip if needed after loading.
    internalCardRotZ = 180.0

    -- Edifice / ruin cards should not hide the tooltip even when facedown.
    if ("EdificeRuin" == cardType) then
      shouldHideWhenFaceDown = false
    end

    cardDeckID = string.sub(ttsCardID, 1, -3)

    cardJSON = {
      Name = "Card",
      Transform = {
        posX = 0.0,
        posY = 0.0,
        posZ = 0.0,
        rotX = 0.0,
        rotY = cardRotY,
        rotZ = internalCardRotZ,
        scaleX = cardScaleX,
        scaleY = 1.00,
        scaleZ = cardScaleZ
      },
      Nickname = cardName,
      Description = "",
      ColorDiffuse = {
        r = 0.713235259,
        g = 0.713235259,
        b = 0.713235259
      },
      -- Spawn locked so the card does not fall underneath the table.
      Locked = true,
      Grid = false,
      Snap = true,
      Autoraise = true,
      Sticky = true,
      Tooltip = true,
      CardID = ttsCardID,
      SidewaysCard = false,
      HideWhenFaceDown = shouldHideWhenFaceDown,
      CustomDeck = {},
      LuaScript = "",
      LuaScriptState = "",
      -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
      GUID = "700000"
    }

    cardTTSDeckInfo = ttsDeckInfo[tonumber(cardDeckID)]
    if (nil != cardTTSDeckInfo) then
      cardJSON.CustomDeck[cardDeckID] = {
        FaceURL = cardTTSDeckInfo.deckimage,
        BackURL = cardTTSDeckInfo.backimage,
        NumWidth = cardTTSDeckInfo.deckwidth,
        NumHeight = cardTTSDeckInfo.deckheight,
        BackIsHidden = true,
        UniqueBack = cardTTSDeckInfo.hasuniqueback
      }
    else
      printToAll("Failed to find deck with ID \"" .. cardDeckID .. "\".", {1,0,0})
      spawnStatus = STATUS_FAILURE
    end

    -- Spawn the card underneath the table so it can be mvoed up instead of flashing white.
    spawnParams.json = JSON.encode(cardJSON)
    spawnParams.position = { spawnPositionLocal[1], (-3.5), spawnPositionLocal[3] }
    spawnParams.rotation = { 0, cardRotY, internalCardRotZ }
    spawnParams.callback_function = function(spawnedObject)
      handleSpawnedObject(spawnedObject,
                          { spawnPositionLocal[1], spawnPositionLocal[2], spawnPositionLocal[3] },
                          shouldUnlock,
                          spawnFacedown) end

    -- Update expected spawn count and spawn the object.
    loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
    spawnObjectJSON(spawnParams)
  else
    printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
    spawnStatus = STATUS_FAILURE
  end
end

function handleSpawnedObject(spawnedObject, finalPosition, shouldUnlock, spawnFacedown)
  local curRotation = spawnedObject.getRotation()
  local internalRotationZ = 0.0

  -- Unlock the object if needed.
  if (true == shouldUnlock) then
    spawnedObject.locked = false
  end

  -- Move the object fast without collision.
  spawnedObject.setPositionSmooth(finalPosition, false, true)

  -- Update the rotation in case the object needs to turn faceup.
  if (true == spawnFacedown) then
    internalRotationZ = 180.0
  else
    internalRotationZ = 0.0
  end

  spawnedObject.setRotation({ curRotation[1], curRotation[2], internalRotationZ })

  -- Update the actual spawn count.
  loadActualSpawnCount = (loadActualSpawnCount + 1)
end

function setupGame()
  local availableSites = nil
  local numAvailableSites = 0
  local curSiteName = nil
  local siteCardName = nil
  local siteCardInfo = nil
  local normalCardName = nil
  local normalCardInfo = nil
  local cardSpawnPosition = {}
  local newSiteIndex = nil
  local deckOffset = 0
  local siteRelicCount = 0
  local emptySpaceFound = false

  printToAll("Dealing to players:", {1,1,1})

  for i,curColor in ipairs(playerColors) do
    if (true == curPlayerStatus[curColor][2]) then
      showPieces(curColor)

      if ("Brown" == curColor) then
        printToAll("  Black", {1,1,1})
      else
        printToAll("  " .. curColor, {1,1,1})
      end
    else
      hidePieces(curColor)
    end
  end

  -- Show general pieces.
  showGeneralPieces()

  -- Update the oathkeeper token in case the oath was changed.
  resetOathkeeperToken()

  if (1 == curGameCount) then
    -- Generate randomized relic deck.  This is done now before relics are dealt.
    generateRandomRelicDeck({}, 0, 0)

    -- This is the first game of a chronicle.  First, make a list of all site names.
    availableSites = {}
    for siteCode = 0, (NUM_TOTAL_SITES - 1) do
      -- Copy into 1-based array.
      availableSites[siteCode + 1] = siteCardCodes[siteCode]
    end
    numAvailableSites = NUM_TOTAL_SITES
    -- Next, determine which sites are being used and remove them from the available list.
    for siteIndex = 1,8 do
      curSiteName = curMapSites[siteIndex][1]
      if ("NONE" != curSiteName) then
        for removeSiteIndex = 1, numAvailableSites do
          if (curSiteName == availableSites[removeSiteIndex]) then
            table.remove(availableSites, removeSiteIndex)
            numAvailableSites = (numAvailableSites - 1)
            break
          end
        end
      end
    end
    -- Now, deal sites to fill the empty slots.
    for siteIndex = 1,8 do
      if ("NONE" == curMapSites[siteIndex][1]) then
        -- Pick a random site from the available list.
        newSiteIndex = math.random(1, numAvailableSites)

        -- Add site card facedown.
        curMapSites[siteIndex][1] = availableSites[newSiteIndex]
        curMapSites[siteIndex][2] = true

        -- Spawn the physical site card facedown.
        spawnSingleCard(curMapSites[siteIndex][1], true, siteCardSpawnPositions[siteIndex], 180, false)

        -- Remove the site from the available list.
        table.remove(availableSites, newSiteIndex)
        numAvailableSites = (numAvailableSites - 1)
      else
        -- Spawn the physical site card faceup or facedown depending on the state.
        spawnSingleCard(curMapSites[siteIndex][1], curMapSites[siteIndex][2], siteCardSpawnPositions[siteIndex], 180, false)

        -- Spawn any denizen, edifice, ruin, or relic cards at the site.
        siteRelicCount = 0
        for normalCardIndex = 1,3 do
          normalCardName = curMapNormalCards[siteIndex][normalCardIndex][1]
          normalCardInfo = cardsTable[normalCardName]

          if (nil != normalCardInfo) then
            if ("None" != normalCardInfo.cardtype) then
              cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[normalCardIndex])
              cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
              cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

              spawnSingleCard(normalCardName, curMapNormalCards[siteIndex][normalCardIndex][2], cardSpawnPosition, 180, false)

              if ("Relic" == normalCardInfo.cardtype) then
                siteRelicCount = (siteRelicCount + 1)
              end
            end -- end if ("None" != normalCardInfo.cardtype)
          else -- end if (nil != normalCardInfo)
            printToAll("Error loading card \"" .. normalCardName .. "\"", {1,0,0})
            loadStatus = STATUS_FAILURE
          end
        end -- end looping through normal cards

        -- Check if the site is faceup.
        if (false == curMapSites[siteIndex][2]) then
          -- Since this is the first game, if a faceup site has relic capacity and not enough relics are included, deal some facedown from the relic deck.
          while (siteRelicCount < cardsTable[curMapSites[siteIndex][1]].relicCount) do
            emptySpaceFound = false

            -- Note this goes from 3 down to 1 to deal from right to left.
            for normalCardIndex = 3,1,-1 do
              normalCardName = curMapNormalCards[siteIndex][normalCardIndex][1]
              normalCardInfo = cardsTable[normalCardName]

              if (nil != normalCardInfo) then
                if ("None" == normalCardInfo.cardtype) then
                  emptySpaceFound = true
                  cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[normalCardIndex])
                  cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
                  cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

                  -- This is an empty slot, so deal a relic facedown.
                  curMapNormalCards[siteIndex][normalCardIndex][1] = curRelicDeckCards[curRelicDeckCardCount]
                  curMapNormalCards[siteIndex][normalCardIndex][2] = true
                  spawnSingleCard(curMapNormalCards[siteIndex][normalCardIndex][1], curMapNormalCards[siteIndex][normalCardIndex][2], cardSpawnPosition, 180, false)

                  table.remove(curRelicDeckCards, curRelicDeckCardCount)
                  curRelicDeckCardCount = (curRelicDeckCardCount - 1)

                  siteRelicCount = (siteRelicCount + 1)

                  break
                end -- end if ("None" == normalCardInfo.cardtype)
              end -- end if (nil != normalCardInfo)
            end -- end for normalCardIndex = 3,1,-1

            if (false == emptySpaceFound) then
              printToAll("Error, no empty space found to deal relic.", {1,0,0})
              break
            end
          end -- end while (siteRelicCount < cardsTable[curMapSites[siteIndex][1]].relicCount)
        end -- end if (false == curMapSites[siteIndex][2])
      end -- end if ("NONE" == curMapSites[siteIndex][1])
    end -- for siteIndex = 1,8

    -- Create randomized default world deck with visions included.
    generateRandomWorldDeck({}, 0, 0)
  else -- end if (1 == curGameCount)
    --
    -- Since this is not the first game of a chronicle, spawn sites, denizens, edifices, ruins, and relics as needed.
    --

    for siteIndex = 1,8 do
      siteCardName = curMapSites[siteIndex][1]
      siteCardInfo = cardsTable[siteCardName]

      if (nil != siteCardInfo) then
        if ("None" != siteCardInfo.cardtype) then
          -- Spawn the physical site card faceup or facedown depending on the state.
          spawnSingleCard(siteCardName, curMapSites[siteIndex][2], siteCardSpawnPositions[siteIndex], 180, false)

          for normalCardIndex = 1,3 do
            normalCardName = curMapNormalCards[siteIndex][normalCardIndex][1]
            normalCardInfo = cardsTable[normalCardName]

            if (nil != normalCardInfo) then
              if ("None" != normalCardInfo.cardtype) then
                cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[normalCardIndex])
                cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
                cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

if ("Relic" == normalCardInfo.cardtype) then print("TRACE loaded relic on map, later game") end -- TODO NEXT confirm this works
                spawnSingleCard(normalCardName, curMapNormalCards[siteIndex][normalCardIndex][2], cardSpawnPosition, 180, false)
              end -- end if ("None" != normalCardInfo.cardtype)
            else -- end if (nil != normalCardInfo)
              printToAll("Error loading card \"" .. normalCardName .. "\"", {1,0,0})
              loadStatus = STATUS_FAILURE
            end
          end -- end looping through normal cards
        end -- end if ("None" != siteCardInfo.cardtype)
      else -- end if (nil != siteCardInfo)
        printToAll("Error loading card \"" .. siteCardName .. "\"", {1,0,0})
        loadStatus = STATUS_FAILURE
      end
    end -- end looping through site cards
  end -- end if (STATUS_SUCCESS == loadStatus)

  -- Deck offset is adjusted instead of the world deck data structure so that the world deck is unmodified for chronicle purposes.
  deckOffset = 0

  if (true == randomEnabled) then
    --
    -- If random cards are being used, deal a denizen card from the bottom of the deck to each site with a capacity of at least one.
    --

    for siteIndex = 1,8 do
      -- Reset denizens and relics.
      curMapNormalCards[siteIndex][1][1] = "NONE"    -- No card.
      curMapNormalCards[siteIndex][1][2] = false     -- NOT flipped.

      if (false == curMapSites[siteIndex][2]) then
        if (curMapSites[siteIndex][1] != "NONE") then
          if (cardsTable[curMapSites[siteIndex][1]].capacity > 0) then
            -- Deal a denizen card in the leftmost slot.
            cardSpawnPosition[1] = (normalCardBaseSpawnPositions[siteIndex][1] + normalCardXSpawnChange[1])
            cardSpawnPosition[2] = normalCardBaseSpawnPositions[siteIndex][2]
            cardSpawnPosition[3] = normalCardBaseSpawnPositions[siteIndex][3]

            curMapNormalCards[siteIndex][1][1] = curWorldDeckCards[curWorldDeckCardCount - deckOffset]
            deckOffset = (deckOffset + 1)

            spawnSingleCard(curMapNormalCards[siteIndex][1][1], curMapNormalCards[siteIndex][1][2], cardSpawnPosition, 180, false)
          end -- end if (cardsTable[curMapSites[siteIndex][1]].capacity > 0)
        end -- end if (curMapSites[siteIndex][1] != "NONE")
      end -- end if (false == curMapSites[siteIndex][2])
    end -- end for siteIndex = 1,8
  end -- end if (true == randomEnabled)

  -- Spawn the bottom 3 world deck cards on the discard piles, facedown.
  for discardIndex = 1,3 do
    spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], true, discardPileSpawnPositions[discardIndex], 90, false)
    deckOffset = (deckOffset + 1)
  end

  -- For each player, deal 3 cards from the bottom of the deck, faceup.
  for i,curColor in ipairs(playerColors) do
    -- Check if the player is active before dealing to them.
    if (true == curPlayerStatus[curColor][2]) then
      for cardIndex = 1,3 do
        spawnSingleCard(curWorldDeckCards[curWorldDeckCardCount - deckOffset], false, handCardSpawnPositions[curColor][cardIndex], handCardYRotations[curColor], true)
        deckOffset = (deckOffset + 1)
      end
    end
  end

  -- Spawn favor and secret tokens.
  spawnFavorAndSecrets()

  -- Spawn world deck with remaining cards.
  spawnWorldDeck(deckOffset)

  -- Deal facedown relics to the reliquary slots.
  for reliquaryIndex = 1,4 do
    spawnSingleCard(curRelicDeckCards[curRelicDeckCardCount], true, reliquaryCardPositions[reliquaryIndex], 0, false)
    table.remove(curRelicDeckCards, curRelicDeckCardCount)
    curRelicDeckCardCount = (curRelicDeckCardCount - 1)
  end

  -- Spawn relic deck with remaining cards.
  spawnRelicDeck()

  -- Mark the game as in progress.
  isGameInProgress = true

  -- Change the buttons configuration.
  configGeneralButtons(BUTTONS_IN_GAME)

  -- Announce that setup is complete.
  printToAll("This game uses the " .. fullOathNames[curOath], {1,1,1})
  printToAll("SETUP COMPLETE.", {0,0.8,0})

  -- If this is the first game for the chronicle, prompt the user to potentially change the name.
  if (1 == curGameCount) then
    showChronicleNameDialog()
  end
end

function resetSupplyCylinder(playerColor)
  playerSupplyMarkers[playerColor].setPosition({ supplyMarkerStartPositions[playerColor][1], supplyMarkerStartPositions[playerColor][2], supplyMarkerStartPositions[playerColor][3] })
end

function showGeneralPieces()
  curOathkeeperToken.setPosition({ oathkeeperStartPosition[1], oathkeeperStartPosition[2], oathkeeperStartPosition[3] })
  curOathkeeperToken.locked = false
  curOathkeeperToken.interactable = true
  curOathkeeperToken.tooltip = true

  for loopOathName,loopOathCode in pairs(oathCodes) do
    if (nil != oathReminderTokens[loopOathName]) then
      if (curOath == loopOathName) then
        oathReminderTokens[loopOathName].setPosition({ oathReminderStartPosition[1], oathReminderStartPosition[2], oathReminderStartPosition[3] })
        oathReminderTokens[loopOathName].setRotation({ oathReminderStartRotation[1], oathReminderStartRotation[2], oathReminderStartRotation[3] })
        oathReminderTokens[loopOathName].locked = false
        oathReminderTokens[loopOathName].interactable = true
        oathReminderTokens[loopOathName].tooltip = true
      else
        oathReminderTokens[loopOathName].setPosition({ oathReminderTokenHidePositions[loopOathName][1],
                                                       oathReminderTokenHidePositions[loopOathName][2],
                                                       oathReminderTokenHidePositions[loopOathName][3] })
        oathReminderTokens[loopOathName].locked = true
        oathReminderTokens[loopOathName].interactable = false
        oathReminderTokens[loopOathName].tooltip = false
      end
    end
  end

  grandScepter.setPosition({ grandScepterStartPosition[1], grandScepterStartPosition[2], grandScepterStartPosition[3] })
  grandScepter.setRotation({ 0, 0, 0 })
  grandScepter.locked = false
  grandScepter.interactable = true
  grandScepter.tooltip = true

  if ("Devotion" == curOath) then
    darkestSecret.setPosition({ chancellorSpecialStartPosition[1], chancellorSpecialStartPosition[2], chancellorSpecialStartPosition[3] })
    darkestSecret.locked = false
    darkestSecret.interactable = true
    darkestSecret.tooltip = true
  else
    darkestSecret.setPosition({ darkestSecretShowPosition[1], darkestSecretShowPosition[2], darkestSecretShowPosition[3] })
    darkestSecret.setRotation({ 0, 180, 0 })
    darkestSecret.locked = false
    darkestSecret.interactable = true
    darkestSecret.tooltip = true
  end

  if ("People" == curOath) then
    peoplesFavor.setPosition({ chancellorSpecialStartPosition[1], chancellorSpecialStartPosition[2], chancellorSpecialStartPosition[3] })
    peoplesFavor.locked = false
    peoplesFavor.interactable = true
    peoplesFavor.tooltip = true
  else
    peoplesFavor.setPosition({ peoplesFavorShowPosition[1], peoplesFavorShowPosition[2], peoplesFavorShowPosition[3] })
    peoplesFavor.setRotation({ 0, 180, 0 })
    peoplesFavor.locked = false
    peoplesFavor.interactable = true
    peoplesFavor.tooltip = true
  end

  showDice()
end

function hideGeneralPieces()
  curOathkeeperToken.setPosition({ oathkeeperTokenHidePosition[1], oathkeeperTokenHidePosition[2], oathkeeperTokenHidePosition[3] })
  curOathkeeperToken.locked = true
  curOathkeeperToken.interactable = false
  curOathkeeperToken.tooltip = false

  for loopOathName,loopOathCode in pairs(oathCodes) do
    if (nil != oathReminderTokens[loopOathName]) then
      oathReminderTokens[loopOathName].setPosition({ oathReminderTokenHidePositions[loopOathName][1],
                                                     oathReminderTokenHidePositions[loopOathName][2],
                                                     oathReminderTokenHidePositions[loopOathName][3] })
      oathReminderTokens[loopOathName].locked = true
      oathReminderTokens[loopOathName].interactable = false
      oathReminderTokens[loopOathName].tooltip = false
    end
  end

  grandScepter.setPosition({ grandScepterHidePosition[1], grandScepterHidePosition[2], grandScepterHidePosition[3] })
  grandScepter.locked = true
  grandScepter.interactable = false
  grandScepter.tooltip = false

  darkestSecret.setPosition({ darkestSecretHidePosition[1], darkestSecretHidePosition[2], darkestSecretHidePosition[3] })
  darkestSecret.locked = true
  darkestSecret.interactable = false
  darkestSecret.tooltip = false

  peoplesFavor.setPosition({ peoplesFavorHidePosition[1], peoplesFavorHidePosition[2], peoplesFavorHidePosition[3] })
  peoplesFavor.locked = true
  peoplesFavor.interactable = false
  peoplesFavor.tooltip = false

  hideDice()
end

function showPieces(playerColor)
  local oldPosition = nil

  if ("Purple" == playerColor) then
    oldPosition = reliquary.getPosition()
    reliquary.setPosition({ oldPosition[1], 0.96, oldPosition[3] })
    reliquary.locked = true
    reliquary.interactable = true
    reliquary.tooltip = true
  end

  oldPosition = playerBoards[playerColor].getPosition()
  playerBoards[playerColor].setPosition({ oldPosition[1], 0.96, oldPosition[3] })
  playerBoards[playerColor].locked = true
  playerBoards[playerColor].interactable = true
  playerBoards[playerColor].tooltip = true

  oldPosition = playerPawns[playerColor].getPosition()
  playerPawns[playerColor].setPosition({ oldPosition[1], 1.06, oldPosition[3] })
  playerPawns[playerColor].locked = false
  playerPawns[playerColor].interactable = true
  playerPawns[playerColor].tooltip = true

  oldPosition = playerSupplyMarkers[playerColor].getPosition()
  playerSupplyMarkers[playerColor].setPosition({ oldPosition[1], 1.06, oldPosition[3] })
  playerSupplyMarkers[playerColor].locked = false
  playerSupplyMarkers[playerColor].interactable = true
  playerSupplyMarkers[playerColor].tooltip = true

  oldPosition = playerWarbandBags[playerColor].getPosition()
  playerWarbandBags[playerColor].setPosition({ oldPosition[1], 0.77, oldPosition[3] })
  playerWarbandBags[playerColor].locked = true
  playerWarbandBags[playerColor].interactable = true
  playerWarbandBags[playerColor].tooltip = true
end

function hidePieces(playerColor)
  local oldPosition = nil

  if ("Purple" == playerColor) then
    oldPosition = reliquary.getPosition()
    reliquary.setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
    reliquary.locked = true
    reliquary.interactable = false
    reliquary.tooltip = false
  end

  oldPosition = playerBoards[playerColor].getPosition()
  playerBoards[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
  playerBoards[playerColor].locked = true
  playerBoards[playerColor].interactable = false
  playerBoards[playerColor].tooltip = false

  oldPosition = playerPawns[playerColor].getPosition()
  playerPawns[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
  playerPawns[playerColor].locked = true
  playerPawns[playerColor].interactable = false
  playerPawns[playerColor].tooltip = false

  oldPosition = playerSupplyMarkers[playerColor].getPosition()
  playerSupplyMarkers[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
  playerSupplyMarkers[playerColor].locked = true
  playerSupplyMarkers[playerColor].interactable = false
  playerSupplyMarkers[playerColor].tooltip = false

  oldPosition = playerWarbandBags[playerColor].getPosition()
  playerWarbandBags[playerColor].setPosition({ oldPosition[1], (-3.5), oldPosition[3] })
  playerWarbandBags[playerColor].locked = true
  playerWarbandBags[playerColor].interactable = false
  playerWarbandBags[playerColor].tooltip = false
end

function generateRandomWorldDeck(cardsForWorldDeck, cardsForWorldDeckCount, numCardsToChoose)
  local visionsAvailable = { normalCardCodes[210],
                             normalCardCodes[211],
                             normalCardCodes[212],
                             normalCardCodes[213],
                             normalCardCodes[214] }
  local numVisionsAvailable = 5
  local copyCardName = nil
  local sourceSubset = {}
  local numSubsetCardsAvailable = 0
  local chosenIndex = nil

  -- If no card options were provided, Determine which cards are options to add to the world deck.
  if (0 == cardsForWorldDeckCount) then
    cardsForWorldDeck = {}

    if (curWorldDeckCardCount > 0) then
      -- This is the normal case.  Use known non-Vision world deck cards as the source.
      for cardSourceIndex = 1,curWorldDeckCardCount do
        if ("Vision" != cardsTable[curWorldDeckCards[cardSourceIndex]].cardtype) then
          table.insert(cardsForWorldDeck, curWorldDeckCards[cardSourceIndex])
          cardsForWorldDeckCount = (cardsForWorldDeckCount + 1)
        end
      end
    else
      -- There are no cards in the world deck.  Select default non-archive cards that are not the 3 starting locations.
      -- Sanity check to make sure there are no dispossessed cards.
      if (curDispossessedDeckCardCount > 0) then
        printToAll("Warning, there are dispossessed card(s) but no world deck.", {1,0,0})
      end

      for cardSaveID = 0,53 do
        copyCardName = normalCardCodes[cardSaveID]

        if (("Longbows" != copyCardName)       and
            ("Taming Charm" != copyCardName)   and
            ("Elders" != copyCardName))              then
          table.insert(cardsForWorldDeck, copyCardName)
          cardsForWorldDeckCount = (cardsForWorldDeckCount + 1)
        end
      end -- end for cardSaveID = 0,53
    end -- end if (curWorldDeckCardCount > 0)

    -- If the number of cards to choose as not provided, use them all.
    if (0 == numCardsToChoose) then
      numCardsToChoose = cardsForWorldDeckCount
    end
  end -- end if (0 == cardsForWorldDeckCount)

  -- Clear world deck.
  curWorldDeckCards = {}
  curWorldDeckCardCount = 0

  -- Form subset of 10 random denizen cards with 2 random visions.
  sourceSubset = {}
  for subsetIndex = 1,10 do
    chosenIndex = math.random(1, cardsForWorldDeckCount)
    sourceSubset[subsetIndex] = cardsForWorldDeck[chosenIndex]
    -- Remove the chosen card from the source cards.
    table.remove(cardsForWorldDeck, chosenIndex)
    cardsForWorldDeckCount = (cardsForWorldDeckCount - 1)
    numCardsToChoose = (numCardsToChoose - 1)
  end
  for subsetIndex = 11,12 do
    chosenIndex = math.random(1, numVisionsAvailable)
    sourceSubset[subsetIndex] = visionsAvailable[chosenIndex]
    -- Remove the chosen vision from the available visions.
    table.remove(visionsAvailable, chosenIndex)
    numVisionsAvailable = (numVisionsAvailable - 1)
  end
  -- Randomly choose from the 12 cards and add them to the overall deck.
  numSubsetCardsAvailable = 12
  for cardDestIndex = 1,12 do
    chosenIndex = math.random(1, numSubsetCardsAvailable)
    curWorldDeckCards[cardDestIndex] = sourceSubset[chosenIndex]
    table.remove(sourceSubset, chosenIndex)
    curWorldDeckCardCount = (curWorldDeckCardCount + 1)
    numSubsetCardsAvailable = (numSubsetCardsAvailable - 1)
  end

  -- Form subset of 15 random denizen cards with 3 random visions.
  sourceSubset = {}
  for subsetIndex = 1,15 do
    chosenIndex = math.random(1, cardsForWorldDeckCount)
    sourceSubset[subsetIndex] = cardsForWorldDeck[chosenIndex]
    -- Remove the chosen card from the source cards.
    table.remove(cardsForWorldDeck, chosenIndex)
    cardsForWorldDeckCount = (cardsForWorldDeckCount - 1)
    numCardsToChoose = (numCardsToChoose - 1)
  end
  for subsetIndex = 16,18 do
    chosenIndex = math.random(1, numVisionsAvailable)
    sourceSubset[subsetIndex] = visionsAvailable[chosenIndex]
    -- Remove the chosen vision from the available visions.
    table.remove(visionsAvailable, chosenIndex)
    numVisionsAvailable = (numVisionsAvailable - 1)
  end
  -- Randomly choose from the 18 cards and add them to the overall deck.
  numSubsetCardsAvailable = 18
  for cardDestIndex = 13,30 do
    chosenIndex = math.random(1, numSubsetCardsAvailable)
    curWorldDeckCards[cardDestIndex] = sourceSubset[chosenIndex]
    table.remove(sourceSubset, chosenIndex)
    curWorldDeckCardCount = (curWorldDeckCardCount + 1)
    numSubsetCardsAvailable = (numSubsetCardsAvailable - 1)
  end

  -- Finally, randomly add all the remaining source cards to the bottom of the world deck, limiting if needed.
  local cardDestIndex = 31
  while (numCardsToChoose > 0) do
    chosenIndex = math.random(1, cardsForWorldDeckCount)
    curWorldDeckCards[cardDestIndex] = cardsForWorldDeck[chosenIndex]
    table.remove(cardsForWorldDeck, chosenIndex)
    curWorldDeckCardCount = (curWorldDeckCardCount + 1)
    cardsForWorldDeckCount = (cardsForWorldDeckCount - 1)
    numCardsToChoose = (numCardsToChoose - 1)
    cardDestIndex = (cardDestIndex + 1)
  end
end

function generateRandomRelicDeck(cardsForRelicDeck, cardsForRelicDeckCount, numCardsToChoose)
  local copyCardName = nil
  local sourceSubset = {}
  local numSubsetCardsAvailable = 0
  local chosenIndex = nil

  -- If no card options were provided, Determine which cards are options to add to the relic deck.
  if (0 == cardsForRelicDeckCount) then
    cardsForRelicDeck = {}

    if (curRelicDeckCardCount > 0) then
      -- This is the normal case.  Use known relic deck cards as the source.
      for cardSourceIndex = 1,curRelicDeckCardCount do
        table.insert(cardsForRelicDeck, curRelicDeckCards[cardSourceIndex])
        cardsForRelicDeckCount = (cardsForRelicDeckCount + 1)
      end
    else
      -- No cards exist in the relic deck structure.  Initialize it.
      for cardSaveID = 218,237 do
        copyCardName = normalCardCodes[cardSaveID]

        table.insert(cardsForRelicDeck, copyCardName)
        cardsForRelicDeckCount = (cardsForRelicDeckCount + 1)
      end -- end for cardSaveID = 0,53
    end -- end if (curRelicDeckCardCount > 0)

    -- If the number of cards to choose as not provided, use them all.
    if (0 == numCardsToChoose) then
      numCardsToChoose = cardsForRelicDeckCount
    end
  end -- end if (0 == cardsForRelicDeckCount)

  -- Clear relic deck.
  curRelicDeckCards = {}
  curRelicDeckCardCount = 0

  -- Randomly add all available relic cards to the relic deck strucutre.
  local cardDestIndex = 1
  while (numCardsToChoose > 0) do
    chosenIndex = math.random(1, cardsForRelicDeckCount)
    curRelicDeckCards[cardDestIndex] = cardsForRelicDeck[chosenIndex]
    table.remove(cardsForRelicDeck, chosenIndex)
    curRelicDeckCardCount = (curRelicDeckCardCount + 1)
    cardsForRelicDeckCount = (cardsForRelicDeckCount - 1)
    numCardsToChoose = (numCardsToChoose - 1)
    cardDestIndex = (cardDestIndex + 1)
  end
end

function spawnFavorAndSecrets()
  local newFavorToken = nil
  local newSecretToken = nil
  local favorYOffset = 0.18
  local supplyFavor = 36
  local supplySecrets = 20
  local curFavorCount = 0

  -- Set up favor stacks.
  for curSuitName,curSuitCode in pairs(suitCodes) do
    -- Large player counts have more starting favor.
    if (curGameNumPlayers >= 5) then
      curFavorCount = 4
    else
      curFavorCount = 3
    end

    curFavorValues[curSuitName] = curFavorCount
    supplyFavor = (supplyFavor - curFavorCount)

    for tokenIndex = 1, curFavorCount do
      -- Clone the below-table favor token.
      newFavorToken = belowTableFavor.clone()
      newFavorToken.setName("Favor (" .. curFavorCount .. " " .. curSuitName .. ")")
      newFavorToken.locked = false
      newFavorToken.interactable = true
      newFavorToken.tooltip = true
      newFavorToken.use_gravity = true
      newFavorToken.setPosition({ favorSpawnPositions[curSuitName][1],
                                  (favorSpawnPositions[curSuitName][2] + ((tokenIndex - 1) * favorYOffset)),
                                  favorSpawnPositions[curSuitName][3] })
      newFavorToken.setRotation({ 0, 180, 0 })
    end
  end -- end looping through suits

  -- Set up favor supply bag.
  if (nil != favorBag) then
    favorBag.getComponent("AudioSource").set("mute", true)

    for tokenIndex = 1, supplyFavor do
      newFavorToken = belowTableFavor.clone()
      newFavorToken.setName("Favor")
      newFavorToken.locked = false
      newFavorToken.interactable = true
      newFavorToken.tooltip = true
      newFavorToken.use_gravity = true
      newFavorToken.setRotation({ 0, 180, 0 })

      favorBag.putObject(newFavorToken)
    end

    favorBag.getComponent("AudioSource").set("mute", false)
  end

  -- Set up secret supply bag.
  if (nil != secretBag) then
    secretBag.getComponent("AudioSource").set("mute", true)

    for tokenIndex = 1, supplySecrets do
      newSecretToken = belowTableSecret.clone()
      newSecretToken.setName("Secret")
      newSecretToken.locked = false
      newSecretToken.interactable = true
      newSecretToken.tooltip = true
      newSecretToken.use_gravity = true
      newSecretToken.setRotation({ 0, 180, 0 })
      secretBag.putObject(newSecretToken)
    end

    secretBag.getComponent("AudioSource").set("mute", true)
  end
end

function spawnWorldDeck(removedFromUnderneathCount)
  local spawnStatus = STATUS_SUCCESS
  local spawnParams = {}
  local deckJSON = nil
  local cardJSON = nil
  local curCardName = nil
  local curCardInfo = nil
  local curCardDeckID = nil
  local curCardTTSDeckInfo = nil
  local isCardSideways = false

  deckJSON = {
    Name = "Deck",
    Transform = {
      posX = 0.0,
      posY = 0.0,
      posZ = 0.0,
      rotX = 0.0,
      rotY = 90.0,
      -- The deck is spawned facedown.
      rotZ = 180.0,
      scaleX = 1.50,
      scaleY = 1.00,
      scaleZ = 1.50
    },
    Nickname = "World Deck",
    Description = "",
    ColorDiffuse = {
      r = 0.713235259,
      g = 0.713235259,
      b = 0.713235259
    },
    Locked = false,
    Grid = false,
    Snap = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    SidewaysCard = false,
    HideWhenFaceDown = false,
    DeckIDs = {},
    CustomDeck = {},
    LuaScript = "",
    LuaScriptState = "",
    ContainedObjects = {},
    -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
    GUID = "800000"
  }

  -- Iterate over all cards except those removed from underneath the world deck.
  for cardIndex = 1, (curWorldDeckCardCount - removedFromUnderneathCount) do
    curCardName = curWorldDeckCards[cardIndex]
    curCardInfo = cardsTable[curCardName]

    if (nil != curCardInfo) then
      if ("Vision" == curCardInfo.cardtype) then
        isCardSideways = true
      else
        isCardSideways = false
      end

      curCardDeckID = string.sub(curCardInfo.ttscardid, 1, -3)
      cardJSON = {
        Name = "Card",
        Transform = {
          posX = 0.0,
          posY = 0.0,
          posZ = 0.0,
          rotX = 0.0,
          rotY = 0.0,
          rotZ = 0.0,
          scaleX = 1.50,
          scaleY = 1.00,
          scaleZ = 1.50
        },
        Nickname = curCardName,
        Description = "",
        ColorDiffuse = {
          r = 0.713235259,
          g = 0.713235259,
          b = 0.713235259
        },
        Locked = false,
        Grid = false,
        Snap = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        HideWhenFaceDown = true,
        CardID = curCardInfo.ttscardid,
        SidewaysCard = isCardSideways,

        -- Note that for cards inside a deck, a nil CustomDeck is used.  For some reason, using {} instead causes a JSON error, so nil is used.
        CustomDeck = nil,
        LuaScript = "",
        LuaScriptState = "",
        -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
        GUID = "700000"
      }

      -- Record the card ID for each card, even though some ID(s) may be repeated.  Note that despite the name, these values represent card IDs.
      table.insert(deckJSON.DeckIDs, curCardInfo.ttscardid)

      -- If needed, record the CustomDeck information in the overall deck JSON.
      if (nil == deckJSON.CustomDeck[curCardDeckID]) then
        curCardTTSDeckInfo = ttsDeckInfo[tonumber(curCardDeckID)]

        if (nil != curCardTTSDeckInfo) then
          deckJSON.CustomDeck[curCardDeckID] = {
            FaceURL = curCardTTSDeckInfo.deckimage,
            BackURL = curCardTTSDeckInfo.backimage,
            NumWidth = curCardTTSDeckInfo.deckwidth,
            NumHeight = curCardTTSDeckInfo.deckheight,
            BackIsHidden = true,
            UniqueBack = curCardTTSDeckInfo.hasuniqueback
          }
        else -- end if (nil != curCardTTSDeckInfo)
          printToAll("Error, did not find deck with ID " .. curCardDeckID, {1,0,0})
          spawnStatus = STATUS_FAILURE
          break
        end
      end

      -- Add the card to the deck JSON.
      table.insert(deckJSON.ContainedObjects, cardJSON)
    else -- end if (nil != curCardInfo)
      printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
      spawnStatus = STATUS_FAILURE
      break
    end
  end -- end looping through world deck cards

  -- Spawn the world deck.
  if (STATUS_SUCCESS == spawnStatus) then
    -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
    spawnParams.json = JSON.encode(deckJSON)
    spawnParams.position = { worldDeckSpawnPosition[1], (-3.5), worldDeckSpawnPosition[3] }
    spawnParams.rotation = { 0, 90, 180 }
    spawnParams.callback_function = function(spawnedObject)
      handleSpawnedObject(spawnedObject,
                          { worldDeckSpawnPosition[1], worldDeckSpawnPosition[2], worldDeckSpawnPosition[3] },
                          true,
                          true) end

    -- Update expected spawn count and spawn the object.
    loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
    spawnObjectJSON(spawnParams)
  end
end

function spawnRelicDeck()
  local spawnStatus = STATUS_SUCCESS
  local spawnParams = {}
  local deckJSON = nil
  local cardJSON = nil
  local curCardName = nil
  local curCardInfo = nil
  local curCardDeckID = nil
  local curCardTTSDeckInfo = nil

  deckJSON = {
    Name = "Deck",
    Transform = {
      posX = 0.0,
      posY = 0.0,
      posZ = 0.0,
      rotX = 0.0,
      rotY = 90.0,
      -- The deck is spawned facedown.
      rotZ = 180.0,
      scaleX = 1.50,
      scaleY = 1.00,
      scaleZ = 1.50
    },
    Nickname = "Relic Deck",
    Description = "",
    ColorDiffuse = {
      r = 0.713235259,
      g = 0.713235259,
      b = 0.713235259
    },
    Locked = false,
    Grid = false,
    Snap = true,
    Autoraise = true,
    Sticky = true,
    Tooltip = true,
    SidewaysCard = false,
    HideWhenFaceDown = false,
    DeckIDs = {},
    CustomDeck = {},
    LuaScript = "",
    LuaScriptState = "",
    ContainedObjects = {},
    -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
    GUID = "810000"
  }

  -- Iterate over all cards in relic deck.
  for cardIndex = 1,curRelicDeckCardCount do
    curCardName = curRelicDeckCards[cardIndex]
    curCardInfo = cardsTable[curCardName]

    if (nil != curCardInfo) then
      curCardDeckID = string.sub(curCardInfo.ttscardid, 1, -3)
      cardJSON = {
        Name = "Card",
        Transform = {
          posX = 0.0,
          posY = 0.0,
          posZ = 0.0,
          rotX = 0.0,
          rotY = 0.0,
          rotZ = 0.0,
          scaleX = 0.96,
          scaleY = 1.00,
          scaleZ = 0.96
        },
        Nickname = curCardName,
        Description = "",
        ColorDiffuse = {
          r = 0.713235259,
          g = 0.713235259,
          b = 0.713235259
        },
        Locked = false,
        Grid = false,
        Snap = true,
        Autoraise = true,
        Sticky = true,
        Tooltip = true,
        HideWhenFaceDown = true,
        CardID = curCardInfo.ttscardid,
        SidewaysCard = false,

        -- Note that for cards inside a deck, a nil CustomDeck is used.  For some reason, using {} instead causes a JSON error, so nil is used.
        CustomDeck = nil,
        LuaScript = "",
        LuaScriptState = "",
        -- Note that if there is a conflict, the GUID will be automatically updated when a card is spawned onto the table.
        GUID = "700000"
      }

      -- Record the card ID for each card, even though some ID(s) may be repeated.  Note that despite the name, these values represent card IDs.
      table.insert(deckJSON.DeckIDs, curCardInfo.ttscardid)

      -- If needed, record the CustomDeck information in the overall deck JSON.
      if (nil == deckJSON.CustomDeck[curCardDeckID]) then
        curCardTTSDeckInfo = ttsDeckInfo[tonumber(curCardDeckID)]

        if (nil != curCardTTSDeckInfo) then
          deckJSON.CustomDeck[curCardDeckID] = {
            FaceURL = curCardTTSDeckInfo.deckimage,
            BackURL = curCardTTSDeckInfo.backimage,
            NumWidth = curCardTTSDeckInfo.deckwidth,
            NumHeight = curCardTTSDeckInfo.deckheight,
            BackIsHidden = true,
            UniqueBack = curCardTTSDeckInfo.hasuniqueback
          }
        else -- end if (nil != curCardTTSDeckInfo)
          printToAll("Error, did not find deck with ID " .. curCardDeckID, {1,0,0})
          spawnStatus = STATUS_FAILURE
          break
        end
      end

      -- Add the card to the deck JSON.
      table.insert(deckJSON.ContainedObjects, cardJSON)
    else -- end if (nil != curCardInfo)
      printToAll("Failed to find card with name \"" .. cardName .. "\".", {1,0,0})
      spawnStatus = STATUS_FAILURE
      break
    end
  end -- end looping through relic deck cards

  -- Spawn the relic deck.
  if (STATUS_SUCCESS == spawnStatus) then
    -- Spawn the deck underneath the table so it can be moved up instead of flashing white.
    spawnParams.json = JSON.encode(deckJSON)
    spawnParams.position = { relicDeckSpawnPosition[1], (-3.5), relicDeckSpawnPosition[3] }
    spawnParams.rotation = { 0, 180, 180 }
    spawnParams.scale = { 0.96, 1.00, 0.96 }
    spawnParams.callback_function = function(spawnedObject)
      handleSpawnedObject(spawnedObject,
                          { relicDeckSpawnPosition[1], relicDeckSpawnPosition[2], relicDeckSpawnPosition[3] },
                          true,
                          true) end

    -- Update expected spawn count and spawn the object.
    loadExpectedSpawnCount = (loadExpectedSpawnCount + 1)
    spawnObjectJSON(spawnParams)
  end
end

function loadFromSaveString(saveDataString, setupGameAfter)
  local oathMajorVersion = nil
  local oathMinorVersion = nil
  local oathPatchVersion = nil

  -- Set the global load status.
  loadStatus = STATUS_SUCCESS

  --
  -- Parse data string.
  --

  if (string.len(saveDataString) > 6) then
    oathMajorVersion = tonumber(string.sub(saveDataString, 1, 2), 16)
    oathMinorVersion = tonumber(string.sub(saveDataString, 3, 4), 16)
    oathPatchVersion = tonumber(string.sub(saveDataString, 5, 6), 16)

    printToAll("", {1,1,1})
    printToAll("Loading data from version " ..  oathMajorVersion .. "." .. oathMinorVersion .. "." .. oathPatchVersion ..  ".  Please wait...", {1,1,1})

    -- No change in save format through the first several versions.
    if (((1 == oathMajorVersion) and (6 == oathMinorVersion) and (0 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (6 == oathMinorVersion) and (1 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (6 == oathMinorVersion) and (2 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (7 == oathMinorVersion) and (0 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (7 == oathMinorVersion) and (1 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (7 == oathMinorVersion) and (2 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (8 == oathMinorVersion) and (0 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (9 == oathMinorVersion) and (0 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (9 == oathMinorVersion) and (1 == oathPatchVersion))          or
        ((1 == oathMajorVersion) and (9 == oathMinorVersion) and (2 == oathPatchVersion))          or
        ((2 == oathMajorVersion) and (0 == oathMinorVersion) and (0 == oathPatchVersion))          or
        ((2 == oathMajorVersion) and (0 == oathMinorVersion) and (3 == oathPatchVersion))) then
      -- No change in save format.
      loadFromSaveString_1_6_0(saveDataString)
    elseif ((3 == oathMajorVersion) and (1 == oathMinorVersion) and (0 == oathPatchVersion)) then
      -- The relic deck is part of the save format from this version onwards.
      loadFromSaveString_3_1_0(saveDataString)
    else
      --printToAll("Save string:  " .. saveDataString, {1,1,1})
      printToAll("Unsupported data version.  Data version must be " .. OATH_MAJOR_VERSION .. "." .. OATH_MINOR_VERSION .. "." .. OATH_PATCH_VERSION .. " or earlier.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  else
    printToAll("Error, invalid data string.", {1,0,0})
    loadStatus = STATUS_FAILURE
  end

  if (STATUS_SUCCESS == loadStatus) then
    -- The following can be used for load timing.
    --printToAll("Time:  " .. Time.time, {1,1,1})

    -- Setup game state using the loaded state.
    setupLoadedState(setupGameAfter)
  end
end

function loadFromSaveString_1_6_0(saveDataString)
  local parseGameCountHex = nil
  local parseChronicleNameLengthHex = nil
  local parseChronicleNameLength = nil
  local statusByteHex = nil
  local statusByte = nil
  local parseOathCodeHex = nil
  local parseOathCode = nil
  local parseSuitCodeHex = nil
  local parseSuitCode = nil
  local parseCodeHex = nil
  local parseCode = nil
  local cardCountHex = nil
  local oathCodeFound = nil
  local suitCodeFound = nil
  local nextParseIndex = nil

  --
  -- Parse the save data string.  Bytes 1-6 contained the version and have already been parsed.
  --

  nextParseIndex = 7

  if (STATUS_SUCCESS == loadStatus) then
    parseGameCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 3))

    if (nil != parseGameCountHex) then
      loadGameCount = tonumber(parseGameCountHex, 16)
      nextParseIndex = (nextParseIndex + 4)
    else
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    parseChronicleNameLengthHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil != parseChronicleNameLengthHex) then
      parseChronicleNameLength = tonumber(parseChronicleNameLengthHex, 16)
      nextParseIndex = (nextParseIndex + 2)
    else
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    if ((parseChronicleNameLength >= MIN_CHRONICLE_NAME_LENGTH) and
        (parseChronicleNameLength <= MAX_CHRONICLE_NAME_LENGTH))     then
      -- There must be multiple bytes after the chronicle name length.  Otherwise, the save string is invalid.
      if ((nextParseIndex + parseChronicleNameLength) < string.len(saveDataString)) then
        loadChronicleName = string.sub(saveDataString, nextParseIndex, (nextParseIndex + (parseChronicleNameLength - 1)))
        nextParseIndex = (nextParseIndex + parseChronicleNameLength)
      else
        printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
      end
    else
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    statusByteHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil != statusByteHex) then
      -- Ignore the player status byte since chronicle codes only matter before and after games,
      -- and starting a new game will always prompt for which player colors are active.
      nextParseIndex = (nextParseIndex + 2)
    else
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    statusByteHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil != statusByteHex) then
      statusByte = tonumber(statusByteHex, 16)
      nextParseIndex = (nextParseIndex + 2)

      parseExileCitizenStatusByte(statusByte)
    else
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    parseOathCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    if (nil != parseOathCodeHex) then
      parseOathCode = tonumber(parseOathCodeHex, 16)
      nextParseIndex = (nextParseIndex + 2)

      oathCodeFound = false
      for testOathName,testOathCode in pairs(oathCodes) do
        if (testOathCode == parseOathCode) then
          loadCurOath = testOathName
          oathCodeFound = true
          break
        end
      end

      if (false == oathCodeFound) then
        printToAll("Error, invalid oath code.", {1,0,0})
        loadStatus = STATUS_FAILURE
      end
    else
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    for parseSuitIndex = 1,6 do
      parseSuitCodeHex = string.sub(saveDataString, nextParseIndex, nextParseIndex)

      if (nil != parseSuitCodeHex) then
        parseSuitCode = tonumber(parseSuitCodeHex, 16)
        nextParseIndex = (nextParseIndex + 1)

        suitCodeFound = false
        for testSuitName,testSuitCode in pairs(suitCodes) do
          if (testSuitCode == parseSuitCode) then
            loadSuitOrder[parseSuitIndex] = testSuitName
            suitCodeFound = true
            break
          end
        end

        if (false == suitCodeFound) then
          printToAll("Error, invalid suit code.", {1,0,0})
          loadStatus = STATUS_FAILURE
          break
        end
      else
        printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        break
      end
    end
  end

  if (STATUS_SUCCESS == loadStatus) then
    for parseMapSiteIndex = 1,8 do
      --
      -- Parse site.
      --

      parseSiteCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))
      if (nil != parseSiteCodeHex) then
        parseCode = tonumber(parseSiteCodeHex, 16)
        nextParseIndex = (nextParseIndex + 2)

        if (nil != siteCardCodes[parseCode]) then
          loadMapSites[parseMapSiteIndex][1] = siteCardCodes[parseCode]
          -- If the parse code is >= 24, it represents a facedown site.
          if (parseCode >= 24) then
            loadMapSites[parseMapSiteIndex][2] = true
          else
            loadMapSites[parseMapSiteIndex][2] = false
          end
        else
          printToAll("Error, invalid site code 0x" .. parseSiteCodeHex .. ".", {1,0,0})
          loadStatus = STATUS_FAILURE
          break
        end

        --
        -- Parse denizen / edifice / ruin card(s) at the site.
        --

        for parseCardIndex = 1,3 do
          parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

          if (nil != parseCodeHex) then
            parseCode = tonumber(parseCodeHex, 16)
            nextParseIndex = (nextParseIndex + 2)

            if (nil != normalCardCodes[parseCode]) then
              loadMapNormalCards[parseMapSiteIndex][parseCardIndex][1] = normalCardCodes[parseCode]

              -- For ruins, mark the card as flipped.
              if (nil != ruinSaveIDs[parseCode]) then
                loadMapNormalCards[parseMapSiteIndex][parseCardIndex][2] = true
              else
                loadMapNormalCards[parseMapSiteIndex][parseCardIndex][2] = false
              end
            else
              printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
              loadStatus = STATUS_FAILURE
              break
            end
          else
            printToAll("Error, invalid save string.", {1,0,0})
            loadStatus = STATUS_FAILURE
            break
          end
        end

        if (STATUS_SUCCESS != loadStatus) then
          break
        end
      else -- end if site code available
        printToAll("Error, invalid save string.", {1,0,0})
        loadStatus = STATUS_FAILURE
        break
      end
    end -- end loop through map sites
  end -- end if success

  --
  -- This code can be uncommented for debug purposes.
  --
  --if (STATUS_SUCCESS == loadStatus) then
  --  printToAll("MAP:", {1,1,1})
  --  printToAll("====", {1,1,1})
  --  for siteIndex = 1,8 do
  --    printToAll(loadMapSites[siteIndex][1], {1,1,1})
  --    printToAll("  " .. loadMapNormalCards[siteIndex][1][1], {1,1,1})
  --    printToAll("  " .. loadMapNormalCards[siteIndex][2][1], {1,1,1})
  --    printToAll("  " .. loadMapNormalCards[siteIndex][3][1], {1,1,1})
  --  end
  --end

  if (STATUS_SUCCESS == loadStatus) then
    cardCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    -- Reset world deck, attempting to release memory.
    loadWorldDeckInitCardCount = 0
    loadWorldDeckInitCards = nil
    loadWorldDeckInitCards = {}

    if (nil != cardCountHex) then
      loadWorldDeckInitCardCount = tonumber(cardCountHex, 16)
      nextParseIndex = (nextParseIndex + 2)

      for cardIndex = 1,loadWorldDeckInitCardCount do
        parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil != parseCodeHex) then
          parseCode = tonumber(parseCodeHex, 16)
          nextParseIndex = (nextParseIndex + 2)

          if (nil != normalCardCodes[parseCode]) then
            loadWorldDeckInitCards[cardIndex] = normalCardCodes[parseCode]
          else
            printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
            loadStatus = STATUS_FAILURE
            break
          end
        else
          printToAll("Error, invalid save string.", {1,0,0})
          loadStatus = STATUS_FAILURE
          break
        end
      end -- end loop through world deck cards
    else -- end if card count available
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end -- end if success

  --
  -- This code can be uncommented for debug purposes.
  --
  --if (STATUS_SUCCESS == loadStatus) then
  --  printToAll("World deck:", {1,1,1})
  --  printToAll("===========", {1,1,1})
  --  printToAll(loadWorldDeckInitCardCount .. " cards", {1,1,1})
  --  printToAll("===========", {1,1,1})
  --  for cardIndex = 1,loadWorldDeckInitCardCount do
  --    printToAll(loadWorldDeckInitCards[cardIndex], {1,1,1})
  --  end
  --end

  if (STATUS_SUCCESS == loadStatus) then
    cardCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    -- Reset deck of dispossessed cards, attempting to release memory.
    loadDispossessedDeckInitCardCount = 0
    loadDispossessedDeckInitCards = nil
    loadDispossessedDeckInitCards = {}

    if (nil != cardCountHex) then
      loadDispossessedDeckInitCardCount = tonumber(cardCountHex, 16)
      nextParseIndex = (nextParseIndex + 2)

      for cardIndex = 1,loadDispossessedDeckInitCardCount do
        parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil != parseCodeHex) then
          parseCode = tonumber(parseCodeHex, 16)
          nextParseIndex = (nextParseIndex + 2)

          if (nil != normalCardCodes[parseCode]) then
            loadDispossessedDeckInitCards[cardIndex] = normalCardCodes[parseCode]
          else
            printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
            loadStatus = STATUS_FAILURE
            break
          end
        else
          printToAll("Error, invalid save string.", {1,0,0})
          loadStatus = STATUS_FAILURE
          break
        end
      end -- end loop through dispossessed deck cards
    else -- end if card count available
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end -- end if success

  --
  -- This code can be uncommented for debug purposes.
  --
  --if (STATUS_SUCCESS == loadStatus) then
  --  printToAll("Dispossessed deck:", {1,1,1})
  --  printToAll("==================", {1,1,1})
  --  printToAll(loadDispossessedDeckInitCardCount .. " cards", {1,1,1})
  --  printToAll("===========", {1,1,1})
  --  for cardIndex = 1,loadDispossessedDeckInitCardCount do
  --    printToAll(loadDispossessedDeckInitCards[cardIndex], {1,1,1})
  --  end
  --end

  return nextParseIndex
end

function loadFromSaveString_3_1_0(saveDataString)
  local parseCodeHex = nil
  local parseCode = nil
  local cardCountHex = nil
  local nextParseIndex = startParseIndex

  -- Parse the first part of the save string, which is the same as the old version but does not include relic deck data.
  nextParseIndex = loadFromSaveString_1_6_0(saveDataString)

  -- Parse relic deck data.

  if (STATUS_SUCCESS == loadStatus) then
    cardCountHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

    -- Reset relic deck, attempting to release memory.
    loadRelicDeckInitCardCount = 0
    loadRelicDeckInitCards = nil
    loadRelicDeckInitCards = {}

    if (nil != cardCountHex) then
      loadRelicDeckInitCardCount = tonumber(cardCountHex, 16)
      nextParseIndex = (nextParseIndex + 2)

      for cardIndex = 1,loadRelicDeckInitCardCount do
        parseCodeHex = string.sub(saveDataString, nextParseIndex, (nextParseIndex + 1))

        if (nil != parseCodeHex) then
          parseCode = tonumber(parseCodeHex, 16)
          nextParseIndex = (nextParseIndex + 2)

          if (nil != normalCardCodes[parseCode]) then
            loadRelicDeckInitCards[cardIndex] = normalCardCodes[parseCode]
          else
            printToAll("Error, invalid normal card code 0x" .. parseCodeHex .. ".", {1,0,0})
            loadStatus = STATUS_FAILURE
            break
          end
        else
          printToAll("Error, invalid save string.", {1,0,0})
          loadStatus = STATUS_FAILURE
          break
        end
      end -- end loop through relic deck cards
    else -- end if card count available
      printToAll("Error, invalid save string.", {1,0,0})
      loadStatus = STATUS_FAILURE
    end
  end -- end if success

  --
  -- This code can be uncommented for debug purposes.
  --
  --if (STATUS_SUCCESS == loadStatus) then
  --  printToAll("Relic deck:", {1,1,1})
  --  printToAll("===========", {1,1,1})
  --  printToAll(loadRelicDeckInitCardCount .. " cards", {1,1,1})
  --  printToAll("===========", {1,1,1})
  --  for cardIndex = 1,loadRelicDeckInitCardCount do
  --    printToAll(loadRelicDeckInitCards[cardIndex], {1,1,1})
  --  end
  --end

  return nextParseIndex
end

function parseExileCitizenStatusByte(statusByte)
  -- Use bitwise AND to read bits from the exile/citizen status byte.

  if (0x10 == bit32.band(statusByte, 0x10)) then
    loadPlayerStatus["Brown"][1] = "Citizen"
  else
    loadPlayerStatus["Brown"][1] = "Exile"
  end

  if (0x08 == bit32.band(statusByte, 0x08)) then
    loadPlayerStatus["Yellow"][1] = "Citizen"
  else
    loadPlayerStatus["Yellow"][1] = "Exile"
  end

  if (0x04 == bit32.band(statusByte, 0x04)) then
    loadPlayerStatus["White"][1] = "Citizen"
  else
    loadPlayerStatus["White"][1] = "Exile"
  end

  if (0x02 == bit32.band(statusByte, 0x02)) then
    loadPlayerStatus["Blue"][1] = "Citizen"
  else
    loadPlayerStatus["Blue"][1] = "Exile"
  end

  if (0x01 == bit32.band(statusByte, 0x01)) then
    loadPlayerStatus["Red"][1] = "Citizen"
  else
    loadPlayerStatus["Red"][1] = "Exile"
  end
end

function updatePlayerBoardRotation(updateColor)
  local boardRotation = nil

  if ("Purple" != updateColor) then
    boardRotation = playerBoards[updateColor].getRotation()
    if ("Exile" == curPlayerStatus[updateColor][1]) then
      playerBoards[updateColor].setRotation({ boardRotation[1], boardRotation[2], 0.0 })
    else
      playerBoards[updateColor].setRotation({ boardRotation[1], boardRotation[2], 180.0 })
    end
  end
end

function updateRotationFromPlayerBoard(playerColor)
  local boardRotation = nil
  local translatedPlayerColor = playerColor

  if ("Brown" == playerColor) then
    translatedPlayerColor = "Black"
  end

  if ("Purple" != playerColor) then
    -- Only check the player color if the player is active.
    if (true == curPlayerStatus[playerColor][2]) then
      boardRotation = playerBoards[playerColor].getRotation()
      if ((boardRotation[3] >= (-20.0)) and (boardRotation[3] <= (20.0))) then
        if (curPlayerStatus[playerColor][1] != "Exile") then
          printToAll("Warning, " .. translatedPlayerColor .. " player board was manually flipped and has been resynced.", {1,1,1})
          curPlayerStatus[playerColor][1] = "Exile"
        end
      else
        if (curPlayerStatus[playerColor][1] != "Citizen") then
          printToAll("Warning, " .. translatedPlayerColor .. " player board was manually flipped and has been resynced.", {1,1,1})
          curPlayerStatus[playerColor][1] = "Citizen"
        end
      end
    end
  end
end

function refillSitesDuringChronicle()
  local availableSites = nil
  local numAvailableSites = 0
  local curSiteName = nil
  local newSiteIndex = nil

  -- First, make a list of all site names.
  availableSites = {}
  for siteCode = 0, (NUM_TOTAL_SITES - 1) do
    -- Copy into 1-based array.
    availableSites[siteCode + 1] = siteCardCodes[siteCode]
  end
  numAvailableSites = NUM_TOTAL_SITES
  -- Next, determine which sites are being used and remove them from the available list.
  for siteIndex = 1,8 do
    curSiteName = curMapSites[siteIndex][1]
    if ("NONE" != curSiteName) then
      for removeSiteIndex = 1, numAvailableSites do
        if (curSiteName == availableSites[removeSiteIndex]) then
          table.remove(availableSites, removeSiteIndex)
          numAvailableSites = (numAvailableSites - 1)
          break
        end
      end
    end
  end
  -- Now, deal sites to fill the empty slots.
  for siteIndex = 1,8 do
    if ("NONE" == curMapSites[siteIndex][1]) then
      -- Pick a random site from the available list.
      newSiteIndex = math.random(1, numAvailableSites)

      -- Add site card facedown.
      curMapSites[siteIndex][1] = availableSites[newSiteIndex]
      curMapSites[siteIndex][2] = true

      -- Remove the site from the available list.
      table.remove(availableSites, newSiteIndex)
      numAvailableSites = (numAvailableSites - 1)
    end
  end
  -- Finally, if a region has all facedown sites, flip the first site.
  if ((true == curMapSites[1][2]) and
      (true == curMapSites[2][2])) then
    printToAll("Revealed " .. curMapSites[1][1] .. " in Cradle.", {1,1,1})
    curMapSites[1][2] = false
  end
  if ((true == curMapSites[3][2]) and
      (true == curMapSites[4][2]) and
      (true == curMapSites[5][2])) then
    printToAll("Revealed " .. curMapSites[3][1] .. " in Provinces.", {1,1,1})
    curMapSites[3][2] = false
  end
  if ((true == curMapSites[6][2]) and
      (true == curMapSites[7][2]) and
      (true == curMapSites[8][2])) then
    printToAll("Revealed " .. curMapSites[6][1] .. " in Hinterland.", {1,1,1})
    curMapSites[6][2] = false
  end
end

function visionCheckResult(player, value, id)
  --
  -- This implements chronicle step 8.1:  Vow an Oath.
  --

  if (true == player.host) then
    if ("yes" == value) then
      -- Make sure the winning player was actually an Exile.
      if ("Exile" == curPlayerStatus[pendingWinningColor][1]) then
        usedVision = true
        wonBySuccession = false

        -- If a player won with a Vision, the Oath for the next game matches it.
        pendingOath = nil
        Global.UI.setAttribute("mark_vision", "active", false)
        Global.UI.setAttribute("panel_use_vision_check", "active", false)
        Global.UI.setAttribute("panel_choose_vision", "active", true)
      else
        printToAll("Impossible.  Only those living in Exile truly see Visions.", {1,0,0})
      end
    else
      usedVision = false
      wonBySuccession = false

      -- If a player won without a Vision, they must choose any Oath except the current one for the next game.
      pendingOath = nil
      Global.UI.setAttribute("mark_chronicle_oath", "active", false)
      Global.UI.setAttribute("panel_use_vision_check", "active", false)
      Global.UI.setAttribute("banned_chronicle_oath", "offsetXY", selectOathOffsets[curOath])
      Global.UI.setAttribute("panel_choose_oath_except", "active", true)
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function successionCheckResult(player, value, id)
  if (true == player.host) then
    if ("yes" == value) then
      usedVision = false
      wonBySuccession = true
    else
      usedVision = false
      wonBySuccession = false
    end

    -- Since the player won without a Vision, they must choose any Oath except the current one for the next game.
    pendingOath = nil
    Global.UI.setAttribute("mark_chronicle_oath", "active", false)
    Global.UI.setAttribute("panel_succession_check", "active", false)
    Global.UI.setAttribute("banned_chronicle_oath", "offsetXY", selectOathOffsets[curOath])
    Global.UI.setAttribute("panel_choose_oath_except", "active", true)
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function changeChronicleVision(player, value, id)
  if (true == player.host) then
    pendingOath = oathNamesFromCode[tonumber(value)]
    Global.UI.setAttribute("mark_vision", "active", true)
    Global.UI.setAttribute("mark_vision", "offsetXY", selectOathOffsets[pendingOath])
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function confirmSelectVision(player, value, id)
  if (true == player.host) then
    if (nil != pendingOath) then
      curOath = pendingOath
      pendingOath = nil

      Global.UI.setAttribute("panel_choose_vision", "active", false)

      handleChronicleAfterVow(player)
    else
      printToAll("Error, you must select a Vision.", {1,0,0})
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function changeChronicleOath(player, value, id)
  local clickedOath = nil

  if (true == player.host) then
    clickedOath = oathNamesFromCode[tonumber(value)]

    if (curOath == clickedOath) then
      printToAll("Error, you may not select the current Oath.", {1,0,0})
    else
      pendingOath = clickedOath
      Global.UI.setAttribute("mark_chronicle_oath", "active", true)
      Global.UI.setAttribute("mark_chronicle_oath", "offsetXY", selectOathOffsets[pendingOath])
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function confirmSelectChronicleOath(player, value, id)
  if (true == player.host) then
    if (nil != pendingOath) then
      curOath = pendingOath
      pendingOath = nil

      Global.UI.setAttribute("panel_choose_oath_except", "active", false)

      handleChronicleAfterVow(player)
    else
      printToAll("Error, you must select an Oath.", {1,0,0})
    end
  else
    printToAll("Error, only the host can click that.", {1,0,0})
  end
end

function handleChronicleAfterVow(player)
  --
  -- This implements chronicle step 8.2:  Offer Citizenship
  --

  winningColor = pendingWinningColor
  pendingWinningColor = nil

  for i,curColor in ipairs(playerColors) do
    if ("Purple" != curColor) then
      grantPlayerCitizenship[curColor] = false
    end
  end

  -- This step is only performed if the winner was an Exile.
  if ("Exile" == curPlayerStatus[winningColor][1]) then
    for i,curColor in ipairs(playerColors) do
      -- Clear selection markers for each non-chancellor color.
      if ("Purple" != curColor) then
        Global.UI.setAttribute("mark_color_grant_" .. curColor, "active", false)

        -- Use the banned graphic for the winner, citizens, and inactive players.
        if ((winningColor == curColor) or
            ("Citizen" == curPlayerStatus[curColor][1]) or
            (false == curPlayerStatus[curColor][2])) then
          Global.UI.setAttribute("banned_citizen_" .. curColor, "active", true)
        else
          Global.UI.setAttribute("banned_citizen_" .. curColor, "active", false)
        end
      end
    end

    grantCitizenshipLocked = false

    -- Show the offer citizenship panel.
    Global.UI.setAttribute("offer_citizenship_done", "active", true)
    Global.UI.setAttribute("offer_citizenship_skip", "active", true)
    Global.UI.setAttribute("offer_citizenship_confirm", "active", false)
    Global.UI.setAttribute("offer_citizenship_back", "active", false)
    Global.UI.setAttribute("panel_offer_citizenship", "active", true)
  else -- if ("Exile" == curPlayerStatus[winningColor][1])
    -- Chancellor / Citizen winners cannot invite anyone.
    handleChronicleAfterOfferCitizenship(player)
  end
end

function grantCitizenship(player, value, id)
  local convertedColor = nil

  if ((true == player.host) or (player.color == winningColor)) then
    if ("Done" == value) then
      grantCitizenshipLocked = true

      -- Change the user interface so the user can click Confirm or Back.
      Global.UI.setAttribute("offer_citizenship_done", "active", false)
      Global.UI.setAttribute("offer_citizenship_skip", "active", false)
      Global.UI.setAttribute("offer_citizenship_confirm", "active", true)
      Global.UI.setAttribute("offer_citizenship_back", "active", true)
    elseif ("Back" == value) then
      grantCitizenshipLocked = false

      -- Go back to exile selection.
      Global.UI.setAttribute("offer_citizenship_done", "active", true)
      Global.UI.setAttribute("offer_citizenship_skip", "active", true)
      Global.UI.setAttribute("offer_citizenship_confirm", "active", false)
      Global.UI.setAttribute("offer_citizenship_back", "active", false)
    elseif ("Confirm" == value) then
      -- Since an Exile won, convert existing Citizens to Exiles, and grant citizenship to any selected Exiles.
      for i,curColor in ipairs(playerColors) do
        if ("Purple" != curColor) then
          if ("Brown" == curColor) then
            convertedColor = "Black"
          else
            convertedColor = curColor
          end

          -- Reset even inactive Citizen boards to the Exile side, but only grant active Exile players citizenship.
          if ("Citizen" == curPlayerStatus[curColor][1]) then
            curPlayerStatus[curColor][1] = "Exile"

            printToAll("The " .. convertedColor .. " player has become an Exile.", {1,1,1})
          elseif (("Exile" == curPlayerStatus[curColor][1]) and
                  (true == curPlayerStatus[curColor][2])    and
                  (true == grantPlayerCitizenship[curColor]))     then
            curPlayerStatus[curColor][1] = "Citizen"

            printToAll("The " .. convertedColor .. " player has joined the new Commonwealth.", {1,1,1})
          else
            -- Nothing needs done.
          end
        end -- end if ("Purple" != curColor)
      end -- end for i,curColor in ipairs(playerColors)

      Global.UI.setAttribute("panel_offer_citizenship", "active", false)

      handleChronicleAfterOfferCitizenship(player)
    else
      -- Otherwise, the value must be "Skip".
      grantCitizenshipLocked = true

      -- Change the user interface so the user can click Confirm or Back.
      Global.UI.setAttribute("offer_citizenship_done", "active", false)
      Global.UI.setAttribute("offer_citizenship_skip", "active", false)
      Global.UI.setAttribute("offer_citizenship_confirm", "active", true)
      Global.UI.setAttribute("offer_citizenship_back", "active", true)
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function handleChronicleAfterOfferCitizenship(player)
  local keepSiteStatus = { false, false, false, false, false, false, false, false }
  local siteHasEdifice = false
  local curObjectName = nil
  local curObjectDescription = nil
  local convertedObjectColor = nil
  local scriptZoneObjects = nil
  local cardName = nil
  local cardInfo = nil
  local isCardFlipped = false

  --
  -- This implements chronicle step 8.3:  Clean Up Map and Build Edifices
  --

  -- Step 8.3.1:  Discard all site cards except the winner's site, sites the winner rules, and sites with an intact edifice.
  for siteIndex = 1,8 do
    -- Check for the winning player's pawn on the site.  Also check for winning warband(s) on the site,
    -- accounting for succession victories and former Exiles who were granted citizenship.
    keepSiteStatus[siteIndex] = false
    scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
    for i,curObject in ipairs(scriptZoneObjects) do
      curObjectName = curObject.getName()
      curObjectDescription = curObject.getDescription()

      if ("Black" == curObjectDescription) then
        convertedObjectColor = "Brown"
      else
        convertedObjectColor = curObjectDescription
      end

      if ("Pawn" == curObjectName) then
        -- Note that pawns of other players do not matter for this purpose.
        if (winningColor == convertedObjectColor) then
          keepSiteStatus[siteIndex] = true
        end
      elseif ("Figurine" == curObject.tag) then
        if (("Warband" == curObjectName) and
            ((winningColor == convertedObjectColor) or
             (true == grantPlayerCitizenship[convertedObjectColor]) or
             (("Purple" == curObjectDescription) and (true == wonBySuccession)))) then
          keepSiteStatus[siteIndex] = true
        end
      end
    end

    -- Check for an intact edifice.
    siteHasEdifice = false
    for normalCardIndex = 1,3 do
      cardInfo = cardsTable[curMapNormalCards[siteIndex][normalCardIndex][1]]
      isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
      if (("EdificeRuin" == cardInfo.cardtype) and (false == isCardFlipped)) then
        siteHasEdifice = true
        break
      end
    end

    -- Discard the site card if there is no reason for it to be kept.
    if ((false == keepSiteStatus[siteIndex]) and (false == siteHasEdifice)) then
      curMapSites[siteIndex][1] = "NONE"
      curMapSites[siteIndex][2] = false

      scriptZoneObjects = mapSiteCardZones[siteIndex].getObjects()
      for i,curObject in ipairs(scriptZoneObjects) do
        curObjectName = curObject.getName()
        if ("Card" == curObject.tag) then
          destroyObject(curObject)
        end
      end

      -- Discard all denizen, relic, and ruin cards along with the site.
      for normalCardIndex = 1,3 do
        scriptZoneObjects = mapNormalCardZones[siteIndex][normalCardIndex].getObjects()
        for i,curObject in ipairs(scriptZoneObjects) do
          if ("Card" == curObject.tag) then
            cardName = curObject.getName()
            cardInfo = cardsTable[cardName]

            if (nil != cardInfo) then
              -- Discard denizen and vision cards to the discard pile structure.  The scanTable() function
              -- will not be called again during the Chronicle phase so this is okay to do.
              if (("Denizen" == cardInfo.cardtype) or ("Vision" == cardInfo.cardtype)) then
                if (siteIndex <= 2) then
                  table.insert(discardContents[2], cardName)
                elseif (siteIndex <= 5) then
                  table.insert(discardContents[3], cardName)
                else
                  table.insert(discardContents[1], cardName)
                end
              end

              -- TODO NEXT update relic deck structure here, possibly randomizing before saving.

-- TODO NEXT update below, adding relic deck structure to save format etc.
              -- Update the normal card data structure.  The scanTable() function
              -- will not be called again during the Chronicle phase so this is okay to do.
              curMapNormalCards[siteIndex][normalCardIndex][1] = "NONE"
              curMapNormalCards[siteIndex][normalCardIndex][2] = false
            else -- end if (nil != cardInfo)
              printToAll("Error, unknown card found in site denizen area.", {1,0,0})
            end

            destroyObject(curObject)
          end -- end if ("Card" == curObject.tag)
        end -- end for i,curObject in ipairs(scriptZoneObjects)
      end -- end for normalCardIndex = 1,3
    end -- end if ((false == keepSiteStatus[siteIndex]) and (false == siteHasEdifice))
  end -- end for siteIndex = 1,8

  -- Step 8.3.2:  Remove pawns, favor, secrets, and warbands from map.
  -- This is done in cleanTable() which is called later on.

  -- TODO NEXT update numbers below, and search for "step"
  -- Step 8.3.3:  Flip any intact edifices NOT ruled by the winner to their ruined sides, taking into account succession victories and promoted Exiles.
  for siteIndex = 1,8 do
    for normalCardIndex = 1,3 do
      cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
      isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
      cardInfo = cardsTable[cardName]
      -- TODO NEXT check logic here
      if (("EdificeRuin" == cardInfo.cardtype) and (false == isCardFlipped) and (false == keepSiteStatus[siteIndex])) then
        printToAll(cardName .. " has fallen into ruin.", {1,1,1})
        curMapNormalCards[siteIndex][normalCardIndex][2] = true
      end
    end
  end -- end for siteIndex = 1,8

  -- 2.3:  If winner is Chancellor or Citizen, they may build or repair one edifice.
  if (("Chancellor" == curPlayerStatus[winningColor][1]) or ("Citizen" == curPlayerStatus[winningColor][1])) then
    -- Find options to build/repair.
    numBuildRepairOptions = 0
    for siteIndex = 1,8 do
      Global.UI.setAttribute("build_repair_" .. siteIndex, "active", false)
      Global.UI.setAttribute("build_repair_" .. siteIndex, "text", "")

      for normalCardIndex = 1,3 do
        cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
        isCardFlipped = curMapNormalCards[siteIndex][normalCardIndex][2]
        cardInfo = cardsTable[cardName]

        if ((true == keepSiteStatus[siteIndex]) and ("Denizen" == cardInfo.cardtype) and (numEdificesInArchive > 0)) then
          -- This is a build option.
          buildRepairOptions[siteIndex][normalCardIndex] = "build"
          numBuildRepairOptions = (numBuildRepairOptions + 1)

          -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
          Global.UI.setAttribute("build_repair_" .. siteIndex, "text", curMapSites[siteIndex][1])
          Global.UI.setAttribute("build_repair_" .. siteIndex, "active", true)
          Global.UI.setAttribute("build_repair_" .. siteIndex, "textColor", "#FFFFFFFF")
        elseif ((true == keepSiteStatus[siteIndex]) and ("EdificeRuin" == cardInfo.cardtype) and (true == isCardFlipped)) then
          -- This is a repair option.
          buildRepairOptions[siteIndex][normalCardIndex] = "repair"
          numBuildRepairOptions = (numBuildRepairOptions + 1)

          -- The text color needs set after making the button active due to an apparent TTS bug that resets the color.
          Global.UI.setAttribute("build_repair_" .. siteIndex, "text", curMapSites[siteIndex][1])
          Global.UI.setAttribute("build_repair_" .. siteIndex, "active", true)
          Global.UI.setAttribute("build_repair_" .. siteIndex, "textColor", "#FFFFFFFF")
        else
          -- This is neither.
          buildRepairOptions[siteIndex][normalCardIndex] = "none"
        end
      end -- end for normalCardIndex = 1,3
    end -- end for siteIndex = 1,8
  end

  if ("Chancellor" == curPlayerStatus[winningColor][1]) then
    selectedBuildRepairIndex = nil
    Global.UI.setAttribute("mark_build_repair", "active", false)

    printToAll("As Chancellor, the winner is allowed to build or repair an edifice.", {1,1,1})
    if (numBuildRepairOptions > 0) then
      Global.UI.setAttribute("panel_build_repair", "active", true)
    else
      printToAll("But, no options are available.", {1,1,1})
      handleChronicleAfterBuildRepair(player)
    end
  elseif ("Citizen" == curPlayerStatus[winningColor][1]) then
    selectedBuildRepairIndex = nil

    printToAll("As a Citizen, the winner is allowed to build or repair an edifice.", {1,1,1})
    if (numBuildRepairOptions > 0) then
      Global.UI.setAttribute("panel_build_repair", "active", true)
    else
      printToAll("But, no options are available.", {1,1,1})
      handleChronicleAfterBuildRepair(player)
    end
  else
    printToAll("As an exile, the winner cannot build or repair an edifice.", {1,1,1})
    handleChronicleAfterBuildRepair(player)
  end
end

function selectBuildRepair(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    -- Sanity check the choice in case an invalid button is ever triggered.
    if (("none" != buildRepairOptions[tonumber(value)][1]) or
        ("none" != buildRepairOptions[tonumber(value)][2]) or
        ("none" != buildRepairOptions[tonumber(value)][3])) then
      selectedBuildRepairIndex = tonumber(value)
      Global.UI.setAttribute("mark_build_repair", "active", true)
      Global.UI.setAttribute("mark_build_repair", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
    else
      -- This should never happen.
      printToAll("Error, invalid site selected.", {1,0,0})
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function confirmBuildRepair(player, value, id)
  local cardName = nil
  local ruinName = nil

  if ((true == player.host) or (player.color == winningColor)) then
    if ("true" == value) then
      if (nil != selectedBuildRepairIndex) then
        -- Display the available denizen / ruin cards that can be chosen.
        for normalCardIndex = 1,3 do
          if ("build" == buildRepairOptions[selectedBuildRepairIndex][normalCardIndex]) then
            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex,
                                   "text",
                                   "(replace) " .. curMapNormalCards[selectedBuildRepairIndex][normalCardIndex][1])
            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "active", true)
            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "textColor", "#FFFFFF")
          elseif ("repair" == buildRepairOptions[selectedBuildRepairIndex][normalCardIndex]) then
            cardName = curMapNormalCards[selectedBuildRepairIndex][normalCardIndex][1]
            ruinName = string.sub(cardName, (string.find(cardName, "/") + 2))

            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex,
                                   "text",
                                   "(repair) " .. ruinName)
            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "active", true)
            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "textColor", "#FFFFFF")
          else
            Global.UI.setAttribute("build_repair_cards_" .. normalCardIndex, "active", false)
          end
        end

        -- Prompt to select a card from the site.
        selectedBuildRepairCardIndex = nil
        Global.UI.setAttribute("panel_build_repair", "active", false)
        Global.UI.setAttribute("mark_build_repair_card", "active", false)
        Global.UI.setAttribute("panel_build_repair_cards", "active", true)
      else -- end if (nil != selectedBuildRepairIndex)
        printToAll("Error, no site selected.", {1,0,0})
      end
    else
      Global.UI.setAttribute("panel_build_repair", "active", false)
      printToAll("The winner chose not to build or repair an edifice.")
      handleChronicleAfterBuildRepair(player)
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function selectBuildRepairCard(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    if ("build" == buildRepairOptions[selectedBuildRepairIndex][tonumber(value)]) then
      selectedBuildRepairCardIndex = tonumber(value)
      Global.UI.setAttribute("mark_build_repair_card", "active", true)
      Global.UI.setAttribute("mark_build_repair_card", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
    elseif ("repair" == buildRepairOptions[selectedBuildRepairIndex][tonumber(value)]) then
      selectedBuildRepairCardIndex = tonumber(value)
      Global.UI.setAttribute("mark_build_repair_card", "active", true)
      Global.UI.setAttribute("mark_build_repair_card", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
    else
      -- This should never happen.
      printToAll("Error, invalid card selected.", {1,0,0})
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function cancelBuildRepairCards(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    selectedBuildRepairIndex = nil

    Global.UI.setAttribute("panel_build_repair_cards", "active", false)
    Global.UI.setAttribute("mark_build_repair", "active", false)
    Global.UI.setAttribute("panel_build_repair", "active", true)
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function confirmBuildRepairCards(player, value, id)
  local cardName = nil
  local edificeName = nil
  local ruinName = nil

  if ((true == player.host) or (player.color == winningColor)) then
    if (nil != selectedBuildRepairCardIndex) then
      if ("build" == buildRepairOptions[selectedBuildRepairIndex][selectedBuildRepairCardIndex]) then
        -- Find the first available archive edifice.  There is guaranteed to be at least one, since otherwise
        -- no "build" option would have been found.
        selectedEdificeIndex = 1
        for testEdificeIndex = 1,6 do
          if (true == edificesInArchive[testEdificeIndex]) then
            selectedEdificeIndex = testEdificeIndex
            break
          end
        end

        Global.UI.setAttribute("sheet_edifices", "offsetXY", edificeOffsets[selectedEdificeIndex])
        Global.UI.setAttribute("sheet_ruins", "offsetXY", edificeOffsets[selectedEdificeIndex])
        Global.UI.setAttribute("panel_build_repair_cards", "active", false)
        Global.UI.setAttribute("panel_choose_edifice", "active", true)
      elseif ("repair" == buildRepairOptions[selectedBuildRepairIndex][selectedBuildRepairCardIndex]) then
        cardName = curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1]
        edificeName = string.sub(cardName, 1, (string.find(cardName, "/") - 2))
        ruinName = string.sub(cardName, (string.find(cardName, "/") + 2))

        -- Flip the ruin back to the edifice side.
        curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][2] = false
        printToAll(ruinName .. " was repaired and is now " .. edificeName .. ".", {1,1,1})

        -- Continue with the chronicle phase.
        Global.UI.setAttribute("panel_build_repair_cards", "active", false)
        handleChronicleAfterBuildRepair(player)
      else
        -- This should never happen.
        printToAll("Error, invalid card selected.", {1,0,0})
      end
    else -- end if (nil != selectedBuildRepairCardIndex)
      printToAll("Error, no card selected.", {1,0,0})
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function edificeLeft(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    if (selectedEdificeIndex > 1) then
      selectedEdificeIndex = (selectedEdificeIndex - 1)
    else
      selectedEdificeIndex = 6
    end

    -- If an invalid edifice was selected, keep searching left.
    while (false == edificesInArchive[selectedEdificeIndex]) do
      if (selectedEdificeIndex > 1) then
        selectedEdificeIndex = (selectedEdificeIndex - 1)
      else
        selectedEdificeIndex = 6
      end
    end

    Global.UI.setAttribute("sheet_edifices", "offsetXY", edificeOffsets[selectedEdificeIndex])
    Global.UI.setAttribute("sheet_ruins", "offsetXY", edificeOffsets[selectedEdificeIndex])
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function edificeRight(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    if (selectedEdificeIndex < 6) then
      selectedEdificeIndex = (selectedEdificeIndex + 1)
    else
      selectedEdificeIndex = 1
    end

    -- If an invalid edifice was selected, keep searching right.
    while (false == edificesInArchive[selectedEdificeIndex]) do
      if (selectedEdificeIndex < 6) then
        selectedEdificeIndex = (selectedEdificeIndex + 1)
      else
        selectedEdificeIndex = 1
      end
    end

    Global.UI.setAttribute("sheet_edifices", "offsetXY", edificeOffsets[selectedEdificeIndex])
    Global.UI.setAttribute("sheet_ruins", "offsetXY", edificeOffsets[selectedEdificeIndex])
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function edificeCancel(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    selectedBuildRepairCardIndex = nil

    Global.UI.setAttribute("panel_choose_edifice", "active", false)
    Global.UI.setAttribute("mark_build_repair_card", "active", false)
    Global.UI.setAttribute("panel_build_repair_cards", "active", true)
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function edificeConfirm(player, value, id)
  local oldCardName = nil
  local newCardName = nil

  if ((true == player.host) or (player.color == winningColor)) then
    oldCardName = curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1]
    newCardName = normalCardCodes[edificeCardCodes[selectedEdificeIndex]]
    edificeName = string.sub(newCardName, 1, (string.find(newCardName, "/") - 2))

    -- Replace the denizen card with the edifice.
    curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][1] = newCardName
    curMapNormalCards[selectedBuildRepairIndex][selectedBuildRepairCardIndex][2] = false
    printToAll(oldCardName .. " was replaced by " .. edificeName .. ".", {1,1,1})

    -- Discard the old denizen card.  The scanTable() function will not be called again
    -- during the Chronicle phase so this is okay to do.
    if (selectedBuildRepairIndex <= 2) then
      table.insert(discardContents[2], oldCardName)
    elseif (selectedBuildRepairIndex <= 5) then
      table.insert(discardContents[3], oldCardName)
    else
      table.insert(discardContents[1], oldCardName)
    end

    -- Continue with the chronicle phase.
    Global.UI.setAttribute("panel_choose_edifice", "active", false)
    handleChronicleAfterBuildRepair(player)
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function handleChronicleAfterBuildRepair(player)
  local adviserSuitCounts = nil
  local cardSuit = nil
  local maxSuitCount = 0

  -- 2.4:  Slide any faceup site cards on the map, along with their denizen cards, toward the Cradle to fill vacant site slots.
  --       Deal facedown sites to all vacant slots.  Flip the first site of each region if the region is left with no faceup sites.
  -- Note that the maximum site index is 7, since nothing can ever slide into the final site.
  for siteIndex = 1,7 do
    -- Find vacant sites, starting from the Cradle.
    if ("NONE" == curMapSites[siteIndex][1]) then
      for slideSourceSiteIndex = (siteIndex + 1), 8 do
        if ("NONE" != curMapSites[slideSourceSiteIndex][1]) then
          -- Slide the site.
          curMapSites[siteIndex][1] = curMapSites[slideSourceSiteIndex][1]
          curMapSites[siteIndex][2] = curMapSites[slideSourceSiteIndex][2]
          curMapSites[slideSourceSiteIndex][1] = "NONE"
          curMapSites[slideSourceSiteIndex][2] = false

          printToAll(curMapSites[siteIndex][1] .. " moved towards the Cradle to fill a vacancy.", {1,1,1})

          -- Slide all denizen / edifice / ruin cards at the site.
          for normalCardIndex = 1,3 do
            curMapNormalCards[siteIndex][normalCardIndex][1] = curMapNormalCards[slideSourceSiteIndex][normalCardIndex][1]
            curMapNormalCards[siteIndex][normalCardIndex][2] = curMapNormalCards[slideSourceSiteIndex][normalCardIndex][2]
            curMapNormalCards[slideSourceSiteIndex][normalCardIndex][1] = "NONE"
            curMapNormalCards[slideSourceSiteIndex][normalCardIndex][2] = false
          end

          -- Stop searching for a site to slide, since one was found.
          break
        end -- end if ("NONE" != curMapSites[slideSourceSiteIndex][1])
      end -- end for slideSourceSiteIndex = (siteIndex + 1), 8
    end -- end if ("NONE" == curMapSites[siteIndex][1])
  end -- end for siteIndex = 1,7

  -- Refill sites, flipping if needed.
  refillSitesDuringChronicle()

  --
  -- 3)  Add six cards
  --

  -- Determine the most common suit(s) in the winner's advisers, if any.

  adviserSuitCounts = { ["Discord"] = 0,
                        ["Arcane"]  = 0,
                        ["Order"]   = 0,
                        ["Hearth"]  = 0,
                        ["Beast"]   = 0,
                        ["Nomad"]   = 0 }
  adviserSuitOptions = {}

  for adviserIndex = 1,numPlayerAdvisers[winningColor] do
    cardSuit = cardsTable[playerAdvisers[winningColor][adviserIndex]].suit
    adviserSuitCounts[cardSuit] = (adviserSuitCounts[cardSuit] + 1)
  end

  maxSuitCount = 0
  for i,curSuit in ipairs(suitNames) do
    if (adviserSuitCounts[curSuit] == maxSuitCount) then
      -- This suit is tied for the maximum count, so add it to the options.
      table.insert(adviserSuitOptions, curSuit)
    elseif (adviserSuitCounts[curSuit] > maxSuitCount) then
      -- This suit sets a new maximum, so replace the options.
      adviserSuitOptions = { curSuit }
      maxSuitCount = adviserSuitCounts[curSuit]
    else
      -- Ignore this suit since it is not even tied for maximum.
    end
  end

  -- If there are at least 2 valid options, prompt the winner to choose.
  if ((#adviserSuitOptions) > 1) then
    -- Block all suits before enabling valid option(s).
    for i,curSuit in ipairs(suitNames) do
      Global.UI.setAttribute("ban_suit_" .. curSuit, "active", true)
      Global.UI.setAttribute("select_suit_" .. curSuit, "active", false)
    end

    -- Enable valid options.
    for i,curSuit in ipairs(adviserSuitOptions) do
      Global.UI.setAttribute("ban_suit_" .. curSuit, "active", false)
      Global.UI.setAttribute("select_suit_" .. curSuit, "active", true)
    end

    -- Enable the panel.
    selectedSuit = nil
    Global.UI.setAttribute("mark_suit", "active", false)
    Global.UI.setAttribute("panel_select_suit", "active", true)
  else -- end if ((#adviserSuitOptions) > 1)
    -- This simulates choosing the suit from the suit selection dialog.
    selectedSuit = adviserSuitOptions[1]
    confirmSelectSuit(player, "", "confirm_select_suit")
  end
end

function selectSuit(player, value, id)
  if ((true == player.host) or (player.color == winningColor)) then
    -- Sanity check just in case an invalid button was clicked.
    for i,curSuit in ipairs(adviserSuitOptions) do
      if (curSuit == value) then
        selectedSuit = value
        Global.UI.setAttribute("mark_suit", "active", true)
        Global.UI.setAttribute("mark_suit", "offsetXY", Global.UI.getAttribute(id, "offsetXY"))
        break
      end
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function confirmSelectSuit(player, value, id)
  local archivePullSuits = {}
  local chosenPullIndex = 0

  if ((true == player.host) or (player.color == winningColor)) then
    if (nil != selectedSuit) then
      -- Determine contents of the archive.
      calculateArchiveContents()

      -- Determine the 3 suits that should have cards added, starting with the selected suit.
      archivePullSuits[1] = selectedSuit
      archivePullSuits[2] = chronicleNextSuits[archivePullSuits[1]]
      archivePullSuits[3] = chronicleNextSuits[archivePullSuits[2]]

      -- Check whether the archive has enough cards to pull from these suits.  Otherwise, heal the archive.
      if (((#(archiveContentsBySuit[archivePullSuits[1]])) >= 3) and
          ((#(archiveContentsBySuit[archivePullSuits[2]])) >= 2) and
          ((#(archiveContentsBySuit[archivePullSuits[3]])) >= 1)) then
        -- Add 3 cards from the first suit.
        for archivePullCount = 1,3 do
          chosenPullIndex = math.random(1, #(archiveContentsBySuit[archivePullSuits[1]]))
          table.insert(curWorldDeckCards, archiveContentsBySuit[archivePullSuits[1]][chosenPullIndex])
          table.remove(archiveContentsBySuit[archivePullSuits[1]], chosenPullIndex)
          curWorldDeckCardCount = (curWorldDeckCardCount + 1)
        end

        -- Add 2 cards from the next suit.
        for archivePullCount = 1,2 do
          chosenPullIndex = math.random(1, #(archiveContentsBySuit[archivePullSuits[2]]))
          table.insert(curWorldDeckCards, archiveContentsBySuit[archivePullSuits[2]][chosenPullIndex])
          table.remove(archiveContentsBySuit[archivePullSuits[2]], chosenPullIndex)
          curWorldDeckCardCount = (curWorldDeckCardCount + 1)
        end

        -- Add 1 card from the last suit.
        chosenPullIndex = math.random(1, #(archiveContentsBySuit[archivePullSuits[3]]))
        table.insert(curWorldDeckCards, archiveContentsBySuit[archivePullSuits[3]][chosenPullIndex])
        table.remove(archiveContentsBySuit[archivePullSuits[3]], chosenPullIndex)
        curWorldDeckCardCount = (curWorldDeckCardCount + 1)

        printToAll("The world has changed.", {1,1,1})
        printToAll("  Added 3 " .. archivePullSuits[1] .. " cards to the world deck.", {1,1,1})
        printToAll("  Added 2 " .. archivePullSuits[2] .. " cards to the world deck.", {1,1,1})
        printToAll("  Added 1 " .. archivePullSuits[3] .. " card to the world deck.", {1,1,1})

        wasArchiveHealed = false
      else -- end if the archive has enough cards to pull 3/2/1 of the needed suits.
        mostDispossessedSuit = calculateMostDispossessedSuit()

        -- Take 6 cards of the chosen suit from the dispossessed deck and add them to the world deck.
        for dispossessedPullCount = 1,6 do
          chosenPullIndex = math.random(1, #(dispossessedContentsBySuit[mostDispossessedSuit]))
          table.insert(curWorldDeckCards, dispossessedContentsBySuit[mostDispossessedSuit][chosenPullIndex])
          table.remove(dispossessedContentsBySuit[mostDispossessedSuit], chosenPullIndex)
          curWorldDeckCardCount = (curWorldDeckCardCount + 1)
        end

        -- Clear the dispossessed deck, which effectively shuffles all dispossessed cards into the archive.
        curDispossessedDeckCardCount = 0
        curDispossessedDeckCards = {}

        printToAll("The Dispossessed have returned to the land!", {1,1,1})
        printToAll("  Added 6 " .. mostDispossessedSuit .. " cards to the world deck.", {1,1,1})
        printToAll("  Shuffled all Dispossessed cards back into the Archive.", {1,1,1})

        wasArchiveHealed = true
      end

      -- Continue with the chronicle phase.
      Global.UI.setAttribute("panel_select_suit", "active", false)
      handleChronicleAfterSelectSuit()
    else -- end if (nil != selectedSuit)
      printToAll("Error, no suit selected.", {1,0,0})
    end
  else
    printToAll("Error, only the host or winning player can click that.", {1,0,0})
  end
end

function calculateArchiveContents()
  local cardName = nil
  local cardFound = false

  -- Reset archive contents.
  for i,curSuit in ipairs(suitNames) do
    archiveContentsBySuit[curSuit] = {}
  end

  -- For every possible card, add it to the archive unless it was in the starting world deck for this game, or it is in the dispossessed deck.
  for cardSaveID = 0,197 do
    cardName = normalCardCodes[cardSaveID]
    cardFound = false

    for worldDeckIndex = 1,curWorldDeckCardCount do
      if (cardName == curWorldDeckCards[worldDeckIndex]) then
        cardFound = true
        break
      end
    end

    if (false == cardFound) then
      for dispossessedDeckIndex = 1,curDispossessedDeckCardCount do
        if (cardName == curDispossessedDeckCards[dispossessedDeckIndex]) then
          cardFound = true
          break
        end
      end
    end

    if (false == cardFound) then
      table.insert(archiveContentsBySuit[cardsTable[cardName].suit], cardName)
    end
  end -- end for cardSaveID = 0,197
end

function calculateMostDispossessedSuit()
  local returnSuit = nil
  local cardInfo = nil
  local maxSuitCount = 0
  local dispossessedSuitOptions = {}
  local dispossessedSuitCounts = { ["Discord"] = 0,
                                   ["Arcane"]  = 0,
                                   ["Order"]   = 0,
                                   ["Hearth"]  = 0,
                                   ["Beast"]   = 0,
                                   ["Nomad"]   = 0 }

  for i,curSuit in ipairs(suitNames) do
    dispossessedContentsBySuit[curSuit] = {}
  end

  for i,curCard in ipairs(curDispossessedDeckCards) do
    cardInfo = cardsTable[curCard]
    table.insert(dispossessedContentsBySuit[cardInfo.suit], curCard)
    dispossessedSuitCounts[cardInfo.suit] = (dispossessedSuitCounts[cardInfo.suit] + 1)
  end

  for i,curSuit in ipairs(suitNames) do
    if (dispossessedSuitCounts[curSuit] == maxSuitCount) then
      -- This suit is tied for the maximum count, so add it to the options.
      table.insert(dispossessedSuitOptions, curSuit)
    elseif (dispossessedSuitCounts[curSuit] > maxSuitCount) then
      -- This suit sets a new maximum, so replace the options.
      dispossessedSuitOptions = { curSuit }
      maxSuitCount = dispossessedSuitCounts[curSuit]
    else
      -- Ignore this suit since it is not even tied for maximum.
    end
  end

  -- If there is more than one option, choose one at random.
  if ((#dispossessedSuitOptions) > 1) then
    returnSuit = dispossessedSuitOptions[math.random(1, (#dispossessedSuitOptions))]
  elseif ((#dispossessedSuitOptions) == 0) then
    returnSuit = dispossessedSuitOptions[1]
  else
    -- This should never happen.
    printToAll("Error, no dispossessed cards available.", {1,0,0})
  end

  return returnSuit
end

function handleChronicleAfterSelectSuit()
  local newSuitOrderString = nil
  local discardCount = 0
  local dispossessOptions = {}
  local dispossessIndex = nil
  local discardsToCheck = {}
  local cardName = nil
  local cardFound = false

  --
  -- 4)  Stack and Save the Suit Supplies
  --

  if (false == wasArchiveHealed) then
    -- Start with the suit that had 3 cards added from the archive, and add other suits in sequence per the Chronicle rules.
    curSuitOrder[1] = selectedSuit
    for suitOrderIndex = 2,6 do
      curSuitOrder[suitOrderIndex] = chronicleNextSuits[curSuitOrder[suitOrderIndex - 1]]
    end
  else
    -- Start with the suit that had 6 cards added from the archive, and add other suits in sequence per the Chronicle rules.
    curSuitOrder[1] = mostDispossessedSuit
    for suitOrderIndex = 2,6 do
      curSuitOrder[suitOrderIndex] = chronicleNextSuits[curSuitOrder[suitOrderIndex - 1]]
    end
  end

  newSuitOrderString = curSuitOrder[1]
  for suitOrderIndex = 2,6 do
    newSuitOrderString = (newSuitOrderString .. ", " .. curSuitOrder[suitOrderIndex])
  end

  --
  -- 5)  Remove Six Cards to the Dispossessed
  --

  dispossessOptions = {}

  -- First, collect the discard piles of all three regions.
  for discardZoneIndex = 1,3 do
    discardCount = #(discardContents[discardZoneIndex])

    for cardIndex = 1,discardCount do
      cardName = discardContents[discardZoneIndex][cardIndex]
      if ("Denizen" == cardsTable[cardName].cardtype) then
        table.insert(dispossessOptions, cardName)
      end
    end
  end

  -- Next, add the advisers of all losing players.
  for i,curColor in ipairs(playerColors) do
    if (winningColor != curColor) then
      for cardIndex = 1,numPlayerAdvisers[curColor] do
        -- Note that playerAdvisers ONLY contains denizen cards, so cardtype does not need checked here.
        table.insert(dispossessOptions, playerAdvisers[curColor][cardIndex])
      end
    end
  end

  -- Finally, choose 6 cards from the resulting list.
  for removeCount = 1,6 do
    if ((#dispossessOptions) > 0) then
      dispossessIndex = math.random(1, #dispossessOptions)
      cardName = dispossessOptions[dispossessIndex]

      -- Remove the card from the world deck.
      for i,curCard in ipairs(curWorldDeckCards) do
        if (cardName == curCard) then
          table.remove(curWorldDeckCards, i)
          curWorldDeckCardCount = (curWorldDeckCardCount - 1)

          break
        end
      end

      -- Add the card to the dispossessed deck.
      table.insert(curDispossessedDeckCards, cardName)
      curDispossessedDeckCardCount = (curDispossessedDeckCardCount + 1)

      -- Remove the card from the dispossessed options list.
      table.remove(dispossessOptions, dispossessIndex)
    else -- end if ((#dispossessOptions) > 0)
      -- It should be impossible or nearly impossible for this game state to ever occur.
      printToAll("Not enough cards were available to dispossess.", {1,1,1})
    end
  end -- end for removeCount = 1,6

  --
  -- 6)  Rebuild the World Deck
  --

  discardsToCheck = {}

  -- All the remaining dispossess options are discarded.
  for i,curCard in ipairs(dispossessOptions) do
    table.insert(discardsToCheck, curCard)
  end

  -- The winner's advisers need to go back to the world deck in addition to the discard pile contents and loser advisers already collected.
  for cardIndex = 1,numPlayerAdvisers[winningColor] do
    -- Note that playerAdvisers ONLY contains denizen cards, so cardtype does not need checked here.
    table.insert(discardsToCheck, playerAdvisers[winningColor][cardIndex])
  end

  -- At this point, curWorldDeckCards contains the following:
  --   * All Vision cards.
  --   * All world deck cards that started the game, not including any initial faceup denizen cards.
  --   * 6 new cards from the Archive.
  --
  -- Three changes needs made, however:
  --   * New denizen cards may exist on the map, and these cards need removed from curWorldDeckCards if they are still there.
  --   * Denizen cards that started the game on the map may have been discarded, and if so, need added to curWorldDeckCards.

  for siteIndex = 1,8 do
    for normalCardIndex = 1,3 do
      cardName = curMapNormalCards[siteIndex][normalCardIndex][1]
      cardInfo = cardsTable[cardName]

      if (nil != cardInfo) then
        if ("Denizen" == cardInfo.cardtype) then
          for i,curCard in ipairs(curWorldDeckCards) do
            if (cardName == curCard) then
              table.remove(curWorldDeckCards, i)
              curWorldDeckCardCount = (curWorldDeckCardCount - 1)

              break
            end
          end -- end for i,curCard in ipairs(curWorldDeckCards)
        end -- end if ("Denizen" == cardInfo.cardtype)
      else
        printToAll("Error, invalid denizen/edifice/ruin/relic card with name \"" .. cardName .. "\".", {1,0,0})
      end
    end -- end for normalCardIndex = 1,3
  end -- end for siteIndex = 1,8

  for i,curDiscard in ipairs(discardsToCheck) do
    cardFound = false

    for i,curWorldCard in ipairs(curWorldDeckCards) do
      if (curDiscard == curWorldCard) then
        cardFound = true

        break
      end
    end

    if (false == cardFound) then
      table.insert(curWorldDeckCards, curDiscard)
      curWorldDeckCardCount = (curWorldDeckCardCount + 1)
    end
  end

  -- The generateRandomWorldDeck() function ignores Vision cards and generates the world deck for the next game.
  generateRandomWorldDeck({}, 0, 0)
  -- Generate randomized relic deck.
  generateRandomRelicDeck({}, 0, 0)

  --
  -- 7)  Save the Map and Player Boards
  --

  -- Generate final save string and update the chronicle.  Note that the table is NOT scanned here, since the state is being adjusted.
  chronicleStateString = generateSaveString()
  ingameStateString = ""
  -- Cleanup the table.
  cleanTable()
  loadFromSaveString(chronicleStateString, false)

  -- Hide pieces for all players.
  for i,curColor in ipairs(playerColors) do
    resetSupplyCylinder(curColor)
    hidePieces(curColor)
  end

  -- Hide general pieces.
  hideGeneralPieces()

  -- Announce that everything is finished.
  printToAll("", {1,1,1})
  printToAll("CHRONICLE UPDATE COMPLETE.", {0,0.8,0})
  printToAll("Save your progress using \"Games\" at the top of the screen.", {1,1,1})
  printToAll("", {1,1,1})

  isChronicleInProgress = false
end


