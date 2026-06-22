------------------------------------------------------------------------------
-- Created by: MrKarfen
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Basic Mod Scripts
------------------------------------------------------------------------------

-- Остановка автомобиля игрока
function PlayerStop()
	local Plf = GetPlayerVehicle()
	Plf:SetCustomControlEnabled( true )
	Plf:SetCustomLinearVelocity( 0 )
	Plf:SetThrottle( 0 )
	Plf:SetCustomControlEnabled( false )
end

function GetWorkshopVehicles( WorkshopName )
	return GetEntityByName( WorkshopName ):GetRepositoryByTypename("Vehicles")
end

function GetWorkshopParts( WorkshopName )
	return GetEntityByName( WorkshopName ):GetRepositoryByTypename("CabinsAndBaskets")
end

function GetShopGuns( ShopName )
	return GetEntityByName( ShopName ):GetRepositoryByTypename("GunsAndGadgets")
end

--------------------------------------------------
-- Сheat codes for testers
--------------------------------------------------

-- Воспонить конструкцию автомобиля игрока
function givefuel()
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddModifier( "fuel", "+ 10000" )
end

-- Воспонить топливо автомобиля игрока
function givehp()
	if testcheat()~=1 then return end
	GetPlayerVehicle():AddModifier( "hp", "+ 10000" )
end

-- Спавн ящика с указаным оружием
function SpawnGunBox(GunPrototype)
	if testcheat()~=1 then return end
	local name = BoxName
	if name==nil then 
		name = "ItemsChest"..random(10000)
	end
	
    local pos, yaw, pitch, roll, lookAt = GetCameraPos()

	if GunPrototype==nil then
		local GunPrototype = "hornet01"
	end
	
	local chestID = CreateNewObject{	prototypeName = "someChest",
										objName = name
							  	   }	

	local MyChest=GetEntityByID(chestID)
	if MyChest==nil then
		LOG("TRIGGER ERROR: Can't create box ")
		return nil
	end
		
	MyChest:SetPosition(pos)
	local id = CreateNewObject{ prototypeName = GunPrototype, objName = "RandomGuns"..random(10000), belong = 1100 }
    local gun = GetEntityByID( id )

    if gun==nil then
       LOG("TRIGGER ERROR: Create Affixes - Can't create gun")
       return nil
    end
	MyChest:AddChild(gun)
end

-- Спавн указаного предмета
function SpawnItem(ItemPrototype)
    if not ItemPrototype then
		ItemPrototype="hornet01"
	end
    Position = GetCameraPos()
	AddPlayerItemsWithBox(ItemPrototype, 1, 0, Position)
end

-- Спавн указаного оружия в инвентарь
function SpawnGun(GunPrototype)
	if testcheat()~=1 then return end
	local veh = GetPlayerVehicle()

    if not GunPrototype then
		GunPrototype="hornet01"
	end

	local name = "RandomGuns"..random(10000)

	local id = CreateNewObject{ prototypeName = GunPrototype, objName = name, belong = 1100 }
    local gun = GetEntityByID( id )

    if gun==nil then
       LOG("TRIGGER ERROR: Create Affixes - Can't create gun")
       return nil
    end
	
    local poloj = veh:AddObjectToRepository(gun)
    return gun
end