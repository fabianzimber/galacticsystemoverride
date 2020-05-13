---------------------------------------
---------------------------------------
--           GalacticSystem          --
--                                   --
--                                   --
--                                   --
--              Author:              --
--      Fabian 'Mekphen' Zimber      --
--                                   --
---------------------------------------
---------------------------------------

---------------------------------------
--       Config  | GalacticSystem    --
---------------------------------------

GalacticSystem = GalacticSystem or {}

-- Base Speed --
-- You can test around with this number. Sets how long the travel time for a fleet is --
GalacticSystem.BaseSpeed                = 10

-- Mine Earning --
-- Every mine of a faction gives this value in the mine intervall. Remember that a faction can have multiple planets with multiple mines --
GalacticSystem.MineEarning              = 200

-- Mine Intervall --
-- Sets how often the mines should payout their earning, in seconds --
GalacticSystem.MineIntervall            = 120

-- Mine Price --
-- How much one mine should cost --
GalacticSystem.MinePrice                = 2000

-- Base Income per Planet --
-- How much money a planet itself generates (this is also payed out with the mine intervall) --
GalacticSystem.BaseIncomePerPlanet      = 100

-- Faction Edit Permission --
-- The Permission required to edit the faction name and description --
GalacticSystem.EditFactionPermission    = 3

-- Faction Start Money --
-- The money a new faction has at beginning --
GalacticSystem.FactionStartMoney        = 50000

-- Override get Faction Method --
-- If you are using a custom faction system, you can override the get faction (see optional method below) --
GalacticSystem.OverrideGetFactionMethod = false

-- Color for Planet Labels shown in the Map --
GalacticSystem.OwnColor                 = Color(0, 255, 0) -- Color of own planets
GalacticSystem.FriendlyColor            = Color(0, 0, 255) -- Color of allied faction planets
GalacticSystem.EnemyColor               = Color(255, 0, 0) -- Color of enemy planets
GalacticSystem.NeutralColor             = Color(255, 255, 0) -- Color of neutral planets

-- Fonts --
GalacticSystem.FontSmall                = "Trebuchet18"
GalacticSystem.FontMedium               = "Trebuchet24"
GalacticSystem.FontBig                  = "Trebuchet32"
GalacticSystem.FontTitle                = "Trebuchet48"

-- Persistence --
-- If the data should be stored in txt files, every time something changes. If this is false, the setup factions / planets / fleets will reset on restart --
GalacticSystem.Persistence              = true

-- Optional, Override Get Faction Method --
--[[
function GalacticSystem:OverrideGetFaction(ply)
    -- return [string] (id) from ply's Faction
end
]]

-- Optional, Ovverride Get Permission Method --
--[[
function GalacticSystem:OverrideGetPermission(ply)
    -- return [table] from GalacticSystem.PermissionLevels
end
]]

-- Get Money Method --
-- If your using DarkRP you should be fine, otherwise edit the method, so that it returns the number of given players money --
function GalacticSystem:GetPlayerMoney(ply)
    if DarkRP then
        return ply:getDarkRPVar("money")
    else
        -- Insert you GetMoney Method for your custom Gamemode here
        return 0
    end
end

-- Add Money Method --
-- Again if you have darkrp your fine, otherwise edit this method, that the given player received the given money (its important that the method also support negative values, since there is no removemoney method) --
if SERVER then
    function GalacticSystem:AddMoney(ply, money)
        if DarkRP then
            ply:addMoney(money)
        end 
        --Insert your custom AddMoney Method for your custom Gamemode here
    end
end

GalacticSystem.PermissionLevels = {
    none = {
        Name            = "None", -- Name that is shown in the /addjobtofaction Window
        ViewPlanets     = false, -- Can open the overview of a planet
        MoveFleets      = false, -- Can move fleets to other planets (includes also starting battles with a movement)
        EditFleets      = false, -- Can Rename Fleets
        EditShips       = false, -- Can assign Ships to Fleets / Rename Ships
        CreateFleets    = false, -- Can Create new Fleets from a single Ship
        DestroyFleets   = false, -- Can destroy existing fleets
        Deposit         = false, -- Can deposit money on the faction bankaccount
        Withdraw        = false, -- Can Withdraw money from the faction bankaccount
        BuildMine       = false, -- Can build a mine on a planet
        BuildStation    = false, -- Can build / upgrade spacestations on a planet
        Retreat         = false, -- Can retreat from battles
        CommanderMsg    = false, -- Receives Chat Messages for Commander
    },
    
    viewer = {
        Name            = "Viewer",
        ViewPlanets     = true,
        MoveFleets      = false,
        EditFleets      = false,
        EditShips       = false,
        CreateFleets    = false,
        DestroyFleets   = false,
        Deposit         = true,
        Withdraw        = false,
        BuildMine       = false,
        BuildStation    = false,
        Retreat         = false,
        CommanderMsg    = false,
    },
    basic = {
        Name            = "Basic",
        ViewPlanets     = true,
        MoveFleets      = true,
        EditFleets      = true,
        EditShips       = true,
        CreateFleets    = false,
        DestroyFleets   = false,
        Deposit         = true,
        Withdraw        = false,
        BuildMine       = true,
        BuildStation    = false,
        Retreat         = true,
        CommanderMsg    = true,
    },
    manager = {
        Name            = "Manager",
        ViewPlanets     = true,
        MoveFleets      = true,
        EditFleets      = true,
        EditShips       = true,
        CreateFleets    = true,
        DestroyFleets   = true,
        Deposit         = true,
        Withdraw        = false,
        BuildMine       = true,
        BuildStation    = true,
        Retreat         = true,
        CommanderMsg    = true,
    },
    leader = {
        Name            = "Leader",
        ViewPlanets     = true,
        MoveFleets      = true,
        EditFleets      = true,
        EditShips       = true,
        CreateFleets    = true,
        DestroyFleets   = true,
        Deposit         = true,
        Withdraw        = true,
        BuildMine       = true,
        BuildStation    = true,
        Retreat         = true,
        CommanderMsg    = true,
    }
}
 
-- Faction Config --
GalacticSystem.FactionInformation = {
    rep = {
        Name = "Republic",
        Description = "Join the republic! Fight against the KUS!"
    },
    kus = {
        Name = "KUS",
        Description = "Join the kus! Fight against republic!"
    }
}

-- Ship Config --
GalacticSystem.ShipTypes = {
    starDestroyerClass1 = {                                                     -- Ship Class Name, (No Spaces, no Special character, etc.)
        hp = 50000,                                                             -- HP, Number - In Battle the firepower value is deducted from the hp
        firepower = 6500,                                                       -- Firepower
        model = "models/props/starwars/furniture/scale_stardestroyer.mdl",      -- Should be a spawnable model of the ship. NOTE: This is not an entity! This must be a prop model, not the copy to clipboard from an entity!
        defaultName = "Class-1 Stardestroyer",                                  -- Name of the Ship
        price = 35000000,                                                       -- Price of the ship 
    },
    starDestroyerClass2 = {
        hp = 65000,
        firepower = 12000,
        model = "models/props/starwars/furniture/scale_stardestroyer.mdl",
        defaultName = "Class-2 Stardestroyer",
        price = 45000000,
    },
    ventatorClass = {
        hp = 35000,
        firepower = 4000,
        model = "models/starwars/ships/republic/republic attack cruiser.mdl",
        defaultName = "Venator Class",
        price = 20000000,
    },
    cruiser = {
        hp = 10000,
        firepower = 1500,
        model = "models/bsp_raider/bsp_raider.mdl",
        defaultName = "Cruiser",
        price = 3000000,
    },
    attackCruiser = {
        hp = 8000,
        firepower = 3000,
        model = "models/sweaw/ships/rep_corvette_1st_servius.mdl",
        defaultName = "Attack-Cruiser",
        price = 3200000,
    },
    gozantiClass = {
        hp = 6000,
        firepower = 500,
        model = "models/skipray/skipray1.mdl",
        defaultName = "Gozanti-Class",
        price = 1000000,
    },
    razorClass = {
        hp = 6000,
        firepower = 500,
        model = "models/sfp_ig2000/sfp_ig2000.mdl",
        defaultName = "Razor-Class",
        price = 800000,
    },
    tieFighter = {
        hp = 200,
        firepower = 50,
        model = "models/tie2/tie2.mdl",
        defaultName = "TIE-Fighter", 
        price = 20000,
    },
    tieAdvanced = {
        hp = 500,
        firepower = 20,
        model = "models/tiead/tiead1.mdl",
        defaultName = "TIE-Advanced",
        price = 15000,
    },
    nebulonB = {
        hp = 35000,
        firepower = 5000,
        model = "models/swbf3/vehicles/reb_nebulon.mdl",
        defaultName = "Nebulon-B Frigate",
        price = 12000000,
    },
    crKorvette = {
        hp = 15000,
        firepower = 1500,
        model = "models/sweaw/ships/rep_corvette_2nd_servius.mdl",
        defaultName = "CR90-Corvette",
        price = 1000000,
    },
    stormClass = {
        hp = 20000,
        firepower = 1000,
        model = "models/sweaw/ships/rep_corvette_3rd_servius.mdl",
        defaultName = "Storm Class-2",
        price = 800000,
    },
    xwing = {
        hp = 100,
        firepower = 50,
        model = "models/min3r/x-wing.mdl",
        defaultName = "X-Wing",
        price = 15000,
    },
    uwing = {
        hp = 200,
        firepower = 250,
        model = "models/sfp_r41/sfp_r41.mdl",
        defaultName = "U-Wing",
        price = 25000,
    },
    
    starDestroyerClassKanzler = {
        hp = 80000,
        firepower = 15000,
        model = "models/props/starwars/furniture/scale_stardestroyer.mdl",
        defaultName = "Liberator-Klasse Sternzerstörer",
        price = 10000000,
    },
    starDestroyerClassLiberator = {
        hp = 65000,
        firepower = 12000,
        model = "models/props/starwars/furniture/scale_stardestroyer.mdl",
        defaultName = "Kanzler-Klasse Sternzerstörer",
        price = 850000,
    },
    ValiantVentatorClass = {
        hp = 35000,
        firepower = 4000,
        model = "models/starwars/ships/republic/republic attack cruiser.mdl",
        defaultName = "Valiant-Venator-Klasse Sternenzerstörer",
        price = 100000,
    },
    VenatorClass = {
        hp = 10000,
        firepower = 1500,
        model = "models/bsp_raider/bsp_raider.mdl",
        defaultName = "Venator-Klasse Sternenzerstörer",
        price = 50000,
    },
    AcclamatorCruiser = {
        hp = 8000,
        firepower = 3000,
        model = "models/sweaw/ships/rep_corvette_1st_servius.mdl",
        defaultName = "Acclamator-Klasse Angriffskreuzer",
        price = 32000,
    },
    GuardianClass = {
        hp = 6000,
        firepower = 500,
        model = "models/skipray/skipray1.mdl",
        defaultName = "Guardian-Klasse",
        price = 22000,
    },
    SabreClass = {
        hp = 6000,
        firepower = 500,
        model = "models/sfp_ig2000/sfp_ig2000.mdl",
        defaultName = "Sabre-Klasse",
        price = 10000,
    },
      lucrehulkClass = {
        hp = 35000,
        firepower = 1000,
        model = "models/props/starwars/furniture/scale_stardestroyer.mdl",
        defaultName = "Lucrehulk-Klasse Blockaden Raumstation",
        price = 1,
    },
    subjugatorClass = {
        hp = 20000,
        firepower = 5000,
        model = "models/props/starwars/furniture/scale_stardestroyer.mdl",
        defaultName = "Subjugator-Klasse Schwerer Sternzerstörer",
        price = 1,
    },
    dreadnoughtClass = {
        hp = 20000,
        firepower = 4000,
        model = "models/starwars/ships/republic/republic attack cruiser.mdl",
        defaultName = "Dreadnought-Providence-Klasse Sternenzerstörer",
        price = 1,
    },
    providenceClass = {
        hp = 10000,
        firepower = 1500,
        model = "models/bsp_raider/bsp_raider.mdl",
        defaultName = "Providence-Klasse Sternenzerstörer",
        price = 1,
    },
    munificentClass = {
        hp = 8000,
        firepower = 3000,
        model = "models/sweaw/ships/rep_corvette_1st_servius.mdl",
        defaultName = "Munificent-Klasse Sternenfrigatte",
        price = 1,
    },
    recusantClass = {
        hp = 6000,
        firepower = 500,
        model = "models/skipray/skipray1.mdl",
        defaultName = "Recusant-Klasse Leichter Zerstörer",
        price = 1,
    },
    sabaothClass = {
        hp = 6000,
        firepower = 500,
        model = "models/sfp_ig2000/sfp_ig2000.mdl",
        defaultName = "Sabaoth-Kreuzer",
        price = 1,
    },
    --[[REP - Fighter]]
    arc170 = {
        hp = 200,
        firepower = 90,
        model = "models/sdog/arc170ch.mdl",
        defaultName = "ARC-170",
        price = 1600,
    },
    btlbYwing = {
        hp = 900,
        firepower = 60,
        model = "models/ywing/ywing_btlb_test.mdl",
        defaultName = "BTLB Y-Wing",
        price = 2000,
    },
    V19 = {
        hp = 500,
        firepower = 20,
        model = "models/sweaw/ships/rep_v19torrent.mdl",
        defaultName = "V-19 Torrent Starfighter",
        price = 500,
    },
    Vwing = {
        hp = 160,
        firepower = 60,
        model = "models/vwing/vwing1.mdl",
        defaultName = "V-Wing",
        price = 700,
    },
    Z95 = {
        hp = 500,
        firepower = 40,
        model = "models/z95/z951.mdl",
        defaultName = "Z-95 Headhunter",
        price = 1000,
    },
    Laat = {
        hp = 1200,
        firepower = 5,
        model = "models/blu/laat.mdl",
        defaultName = "Laat/i",
        price = 500,
    },
    --[[KUS - Fighter]]
      trifighter = {
        hp = 200,
        firepower = 90,
        model = "models/sdog/arc170ch.mdl",
        defaultName = "Droiden Tri-Fighter",
        price = 1,
    },
    hyenaBomber = {
        hp = 900,
        firepower = 60,
        model = "models/ywing/ywing_btlb_test.mdl",
        defaultName = "Hyena-Class Bomber",
        price = 1,
    },
    advancedbomber = {
        hp = 500,
        firepower = 20,
        model = "models/sweaw/ships/rep_v19torrent.mdl",
        defaultName = "Vulture Advanced Bomber",
        price = 1,
    },
    hmpGunship = {
        hp = 160,
        firepower = 60,
        model = "models/vwing/vwing1.mdl",
        defaultName = "HMP Droiden Gunship",
        price = 1,
    },
    Vulture = {
        hp = 500,
        firepower = 40,
        model = "models/z95/z951.mdl",
        defaultName = "Vulture Droid",
        price = 1,
    },
}

GalacticSystem.SpaceStations = {
    imperialSmall = {                   -- Class Name, (again no special characters, no spaces etc.)
        factionId = "imp",                  -- ID for which faction this space station will be used
        ships = {                       
            "tieFighter",               -- list of ship class names (defined above), that can be build
            "tieAdvanced",
        },
        hp = 1000,                      -- HP of the spacestation
        firepower = 25,                 -- Firepower of the spacestation
        upgradesTo = "imperialMedium",  -- class name of what the spacestation upgrades to leave "" if this is the highest stages
        name = "Small Spacestation",    -- Shown Name of spacestation
        starter = true,                 -- Is this the first spacestation, this faction can build?
        price = 500,                    -- Price of this spacestation
    },
    imperialMedium = {
        factionId = "imp",
        ships = {
            "tieFighter",
            "tieAdvanced",
            "razorClass",
            "gozantiClass",
            "cruiser",
        },
        hp = 5000,
        firepower = 500,
        upgradesTo = "imperialBig",
        name = "Medium Spacestation",
        starter = false,
        price = 500000,
    },
    imperialBig = {
        factionId = "imp",
        ships = {
            "tieFighter",
            "tieAdvanced",
            "razorClass",
            "gozantiClass",
            "cruiser",
            "ventatorClass",
            "starDestroyerClass1",
        },
        hp = 12000,
        firepower = 1000,
        upgradesTo = "imperialHuge",
        name = "Big Spacestation",
        starter = false,
        price = 3000000,
    },
    imperialHuge = {
        factionId = "imp",
        ships = {
            "tieFighter",
            "tieAdvanced",
            "razorClass",
            "gozantiClass",
            "cruiser",
            "ventatorClass",
            "starDestroyerClass1",
            "starDestroyerClass2",
        },
        hp = 30000,
        firepower = 2000,
        upgradesTo = "",
        name = "Huge Spacestation",
        starter = false,
        price = 15000000,
    },
    rebellSmall = {
        factionId = "reb",
        ships = {
            "xwing",
            "uwing",
        },
        hp = 2000,
        firepower = 100,
        upgradesTo = "rebellMedium",
        name = "Small Spacestation",
        starter = true,
        price = 500,
    },
    rebellMedium = {
        factionId = "reb",
        ships = {
            "xwing",
            "uwing",
            "stormClass",
            "crKorvette",
        },
        hp = 10000,
        firepower = 500,
        upgradesTo = "rebellBig",
        name = "Medium Spacestation",
        starter = true,
        price = 500000,
    },
    rebellBig = {
        factionId = "reb",
        ships = {
            "xwing",
            "uwing",
            "stormClass",
            "crKorvette",
            "nebulonB",
        },
        hp = 35000,
        firepower = 1000,
        upgradesTo = "",
        name = "Big Spacestation",
        starter = true,
        price = 3000000,
    },
    RepublicSectorSmall = {
        factionId = "rep",
        ships = {
            "Vwing",
            "Z95",
            "Laat",
        },
        hp = 1000,
        firepower = 25,
        upgradesTo = "RepublicSectorMedium",
        name = "Kleine Sektor Raumstation",
        starter = true,
        price = 500,
      },
      RepublicSectorMedium = {
        factionId = "rep",
        ships = {
            "Vwing",
            "Z95",
            "Laat",
            "SabreClass",
            "GuardianClass",
            "AcclamatorCruiser",
        },
        hp = 5000,
        firepower = 500,
        upgradesTo = "RepublicSektorBig",
        name = "Mittlere Sektor Raumstation",
        starter = false,
        price = 50000,
      },
      RepublicSektorBig = {
        factionId = "rep",
        ships = {
            "arc170",
            "Vwing",
            "Z95",
            "Laat",
            "SabreClass",
            "GuardianClass",
            "AcclamatorCruiser",
            "VenatorClass",
        },
        hp = 12000,
        firepower = 1000,
        upgradesTo = "RepublicHuge",
        name = "Kleine Haupt Raumstation",
        starter = false,
        price = 300000,
      },
   
      RepublicHuge = {
        factionId = "rep",
        ships = {
            "arc170",
            "btlbYwing",
            "V19",
            "Vwing",
            "Z95",
            "Laat",
            "SabreClass",
            "GuardianClass",
            "AcclamatorCruiser",
            "VenatorClass",
            "ValiantVentatorClass",
        },
        hp = 30000,
        firepower = 2000,
        upgradesTo = "RepublicGiant",
        name = "Haupt Raumstation",
        starter = false,
        price = 500000,
      },
   
      RepublicGiant = {
        factionId = "rep",
        ships = {
            "arc170",
            "btlbYwing",
            "V19",
            "Vwing",
            "Z95",
            "Laat",
            "SabreClass",
            "GuardianClass",
            "AcclamatorCruiser",
            "VenatorClass",
            "ValiantVentatorClass",
            "starDestroyerClassLiberator",
            "starDestroyerClassKanzler",
        },
        hp = 40000,
        firepower = 3000,
        name = "Große Haupt Raumstation",
        starter = false,
        price = 2000000,
      },
        KusSmall = {
        factionId = "kus",
        ships = {
            "Vulture",
            "hyenaBomber",
            "trifighter",
            "lucrehulkClass",
            "dreadnoughtClass",
                "munificentClass",
                "sabaothClass",
        },
        hp = 2000,
        firepower = 205,
        upgradesTo = "KusMedium",
        name = "KUS Kleine Raumstation",
        starter = true,
        price = 500,
      },
      KusMedium = {
        factionId = "kus",
        ships = {
            "Vulture",
            "hmpGunship",
            "hyenaBomber",
            "trifighter",
            "lucrehulkClass",
            "dreadnoughtClass",
            "providenceClass",
            "munificentClass",
            "sabaothClass",
        },
        hp = 15000,
        firepower = 1500,
        upgradesTo = "KusBig",
        name = "KUS Sektor Raumstation",
        starter = false,
        price = 50000,
      },
      KusBig = {
        factionId = "kus",
        ships = {
            "Vulture",
            "hmpGunship",
            "advancedbomber",
            "hyenaBomber",
            "trifighter",
            "lucrehulkClass",
            "subjugatorClass",
            "dreadnoughtClass",
            "providenceClass",
            "munificentClass",
            "recusantClass",
            "sabaothClass",
        },
        hp = 100000,
        firepower = 5000,
        name = "KUS Haupt Raumstation",
        starter = false,
        price = 600000,
      },
}

GalacticSystem.PlanetInformation = {
    coruscant = {
        PositionX = 485,
        PositionY = 210,
        BuildSlotGround = 5,
        BuildSlotSpace = 3,
        SlotSpace = 5,
        Name = "Coruscant",
        Icon = "planets/coruscant.png",
        BasePlanet = true,
        Faction = "rep",
    },
    geonosis = {
        PositionX = 900,
        PositionY = 600,
        BuildSlotGround = 4,
        BuildSlotSpace = 1,
        SlotSpace = 4,
        Name = "Geonosis",
        Icon = "planets/geonosis.png",
        BasePlanet = true,
        Faction = "kus",
    },
    tython = {
        PositionX = 485,
        PositionY = 285,
        BuildSlotGround = 3,
        BuildSlotSpace = 3,
        SlotSpace = 3,
        Name = "Tython",
        Icon = "planets/tython.png"
    },
    korriban = {
        PositionX = 790,
        PositionY = 150,
        BuildSlotGround = 3,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Korriban",
        Icon = "planets/korriban.png"
    },
    tatooine = {
        PositionX = 850,
        PositionY = 550,
        BuildSlotGround = 4,
        BuildSlotSpace = 1,
        SlotSpace = 2,
        Name = "Tatooine",
        Icon = "planets/tatooine.png"
    },
    kashyyyk = {
        PositionX = 700,
        PositionY = 210,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Kashyyyk",
        Icon = "planets/kashyyk.png"
    },
    ordmandell = {
        PositionX = 490,
        PositionY = 130,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Ord Mantell",
        Icon = "planets/ordmandell.png"
    },
    dantooine = {
        PositionX = 510,
        PositionY = 10,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Dantooine",
        Icon = "planets/dantooine.png"
    },
    alderaan = {
        PositionX = 600,
        PositionY = 210,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Alderaan",
        Icon = "planets/alderaan.png"
    },
    kuat = {
        PositionX = 660,
        PositionY = 285,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Kuat",
        Icon = "planets/kuat.png"
    },
    naboo = {
        PositionX = 670,
        PositionY = 630,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Naboo",
        Icon = "planets/naboo.png"
    },
    rishi = {
        PositionX = 1050,
        PositionY = 480,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Rishi",
        Icon = "planets/rishi.png"
    },
    zeffo = {
        PositionX = 980,
        PositionY = 550,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Zeffo",
        Icon = "planets/zeffo.png"
    },
    hoth = {
        PositionX = 580,
        PositionY = 650,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Hoth",
        Icon = "planets/hoth.png"
    },
    rhenvar = {
        PositionX = 790,
        PositionY = 230,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Rhen Var",
        Icon = "planets/rhenvar.png"
    },
    anaxes = {
        PositionX = 550,
        PositionY = 170,
        BuildSlotGround = 3,
        BuildSlotSpace = 1,
        SlotSpace = 2,
        Name = "Anaxes",
        Icon = "planets/anaxes.png"
    },
    christophsis = {
        PositionX = 850,
        PositionY = 615,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Christophsis",
        Icon = "planets/christophsis.png"
    },
    felucia = {
        PositionX = 835,
        PositionY = 210,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Felucia",
        Icon = "planets/felucia.png"
    },
    florrum = {
        PositionX = 850,
        PositionY = 140,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Florrum",
        Icon = "planets/florrum.png"
    },
    fondor = {
        PositionX = 490,
        PositionY = 360,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Fondor",
        Icon = "planets/fondor.png"
    },
    kamino = {
        PositionX = 1025,
        PositionY = 530,
        BuildSlotGround = 4,
        BuildSlotSpace = 1,
        SlotSpace = 4,
        Name = "Kamino",
        Icon = "planets/kamino.png"
    },
    mandalore = {
        PositionX = 660,
        PositionY = 100,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Mandalore",
        Icon = "planets/mandalore.png"
    },
    mustafa = {
        PositionX = 470,
        PositionY = 700,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Mustafar",
        Icon = "planets/mustafa.png"
    },
    mygeeto = {
        PositionX = 450,
        PositionY = 70,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Mygeeto",
        Icon = "planets/mygeeto.png",
    },
    ryloth = {
        PositionX = 960,
        PositionY = 630,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Ryloth",
        Icon = "planets/ryloth.png",
    },
    taris = {
        PositionX = 615,
        PositionY = 110,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Taris",
        Icon = "planets/taris.png"
    },
    trandosha = {
        PositionX = 740,
        PositionY = 180,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Trandosha",
        Icon = "planets/trandosha.png"
    },
    narshaddaa = {
        PositionX = 700,
        PositionY = 380,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Nar Shaddaa",
        Icon = "planets/rhenvar.png"
    },
    utapau = {
        PositionX = 530,
        PositionY = 700,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Utapau",
        Icon = "planets/ordmantell.png"
    },
    corellia = {
        PositionX = 580,
        PositionY = 330,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 1,
        Name = "Corellia",
        Icon = "planets/rhenvar.png"
    },
}

