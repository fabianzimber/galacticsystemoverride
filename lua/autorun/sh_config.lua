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
GalacticSystem.FactionStartMoney        = 2000

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
    imp = {
        Name = "Galactic Empire", --Name of the Faction
        Description = "Join the empire! Join the strongest force in the Universe! Join our fleet and crush the enemies of the Empire with an iron fist! Long live Emperor Palpetine!" --Description of the faction (should be a long text)
    },
    reb = {
        Name = "Rebellion",
        Description = "Join the rebellion! Fight against the monstrous empire and defend your rights! Help our fleet to deal them a blow and weaken the Empire!"
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
}

GalacticSystem.PlanetInformation = {
    tython = {
        PositionX = 485,                -- This is a bit complicated. The map is a 1200 pixel x and 800 pixel y image. This defines where on X the planet should begin (size of the planet is 50x50) 
        PositionY = 285,                -- This is a bit complicated. The map is a 1200 pixel x and 800 pixel y image. This defines where on Y the planet should begin (size of the planet is 50x50) 
        BuildSlotGround = 3,            -- How many ground build slots does this planet have. Currently there are only mines to build, maybe there will be more buildings in future
        SlotSpace = 3,                  -- How many fleets can hover above this planet
        Name = "Tython",                -- The name of this planet
        Icon = "planets/tython.png",    -- The image of this planet. The image should be in yourworkshopaddon/materials/planets/planetname.png and should have an ideal size of 200x200 (at least this ratio)
        BasePlanet = false,             -- Is this a starter planet? A starter planet can not be attacked / conquered, so it always belongs to the given faction
    },
    coruscant = {
        PositionX = 485,
        PositionY = 210,
        BuildSlotGround = 5,
        BuildSlotSpace = 3,
        SlotSpace = 5,
        Name = "Coruscant",
        Icon = "planets/coruscant.png",
        BasePlanet = true,
        Faction = "imp",
    },
    korriban = {
        PositionX = 800,
        PositionY = 150,
        BuildSlotGround = 3,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Korriban",
        Icon = "planets/korriban.png",
    },
    tatooine = {
        PositionX = 900,
        PositionY = 600,
        BuildSlotGround = 4,
        BuildSlotSpace = 1,
        SlotSpace = 2,
        Name = "Tatooine",
        Icon = "planets/tatooine.png"
    },
    kashyyk = {
        PositionX = 720,
        PositionY = 370,
        BuildSlotGround = 1,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Kashyyk",
        Icon = "planets/kashyyk.png",
        BasePlanet = true,
        Faction = "reb",
    },
    ordmandell = {
        PositionX = 500,
        PositionY = 100,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Ord Mandell",
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
        PositionX = 640,
        PositionY = 480,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Naboo",
        Icon = "planets/naboo.png"
    },
    rishi = {
        PositionX = 1050,
        PositionY = 440,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Rishi",
        Icon = "planets/rishi.png"
    },
    zeffo = {
        PositionX = 980,
        PositionY = 560,
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
        PositionX = 900,
        PositionY = 120,
        BuildSlotGround = 2,
        BuildSlotSpace = 1,
        SlotSpace = 3,
        Name = "Rhen Var",
        Icon = "planets/rhenvar.png"
    },
}

