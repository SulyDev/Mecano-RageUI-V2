Config = {}
Config.marker = true --- true = Oui | false = Non

Config.pos = {
	blips = {
		position = {x = -209.22, y = -1324.59, z = 30.89} -- Position du Blips (Point sur la carte)
	},
    coffre = {
		position = {x = -207.22, y = -1341.83, z = 34.89} -- Position du Coffre
	},
    patron = {
		position = {x = -206.96, y = -1331.42, z = 34.89} -- Position du Patron
	},
	vestiaire = {
		position = {x = -223.6, y = -1320.41, z = 30.89} -- Position du Vestiaire
	},
    garage = {
		position = {x = -186.75, y = -1312.0, z = 31.3} -- Position du Garage
	},
	spawnvoiture = {
		position = {x = -190.46, y = -1290.21, z = 31.12, h = 270.62} -- Position du Spawn Garage
	},

}


GBennysvoiture = {
    {nom = "Véhicule - ~o~FlatBed", modele = "flatbed"},
    {nom = "Véhicule - ~o~Dépaneuse", modele = "towtruck"},
    {nom = "Véhicule - ~o~Déplacement", modele = "kamacho"},
}

mecano = {
    clothes = {
        specials = {
            [0] = {
                label = "Reprendre sa tenue",
                minimum_grade = 0,
                variations = {male = {}, female = {}},
                onEquip = function()
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                    end)
                    SetPedArmour(PlayerPedId(), 0)
                end
            },
            [1] = {
                label = "Tenue - ~o~Mécano",
                minimum_grade = 0,
                variations = {
                    male = { -- Homme
					['bags_1'] = 0, ['bags_2'] = 0,  -- Sac
					['tshirt_1'] = 39, ['tshirt_2'] = 0,  -- T shirt
					['torso_1'] = 55, ['torso_2'] = 0,  -- Torse
					['arms'] = 30,  -- Bras
					['pants_1'] = 46, ['pants_2'] = 0,  -- Pantalon
					['shoes_1'] =25, ['shoes_2'] = 0,  -- Chaussure
					['mask_1'] = 0, ['mask_2'] = 0,  -- Masque
					['bproof_1'] = 0,  -- Gillet par balle
					['chain_1'] = 0,  -- Chaine
					['helmet_1'] = -1, ['helmet_2'] = 0,  -- Casque
                    },
                    female = { -- Femme
					['bags_1'] = 0, ['bags_2'] = 0,  -- Sac
					['tshirt_1'] = 39, ['tshirt_2'] = 0,  -- T shirt
					['torso_1'] = 55, ['torso_2'] = 0,  -- Torse
					['arms'] = 30,  -- Bras
					['pants_1'] = 46, ['pants_2'] = 0,  -- Pantalon
					['shoes_1'] =25, ['shoes_2'] = 0,  -- Chaussure
					['mask_1'] = 0, ['mask_2'] = 0,  -- Masque
					['bproof_1'] = 0,  -- Gillet par balle
					['chain_1'] = 0,  -- Chaine
					['helmet_1'] = -1, ['helmet_2'] = 0,  -- Casque
                    }
                },
                onEquip = function()  
                end
            },
            [2] = {
                label = "Tenue - ~o~Directeur",
                minimum_grade = 4,
                variations = {
                    male = { -- Homme
                        ['bags_1'] = 0, ['bags_2'] = 0,  -- Sac
                        ['tshirt_1'] = 39, ['tshirt_2'] = 0,  -- T shirt
                        ['torso_1'] = 55, ['torso_2'] = 0,  -- Torse
                        ['arms'] = 30,  -- Bras
                        ['pants_1'] = 46, ['pants_2'] = 0,  -- Pantalon
                        ['shoes_1'] =25, ['shoes_2'] = 0,  -- Chaussure
                        ['mask_1'] = 0, ['mask_2'] = 0,  -- Masque
                        ['bproof_1'] = 0,  -- Gillet par balle
                        ['chain_1'] = 0,  -- Chaine
                        ['helmet_1'] = -1, ['helmet_2'] = 0,  -- Casque
                    },
                    female = { -- Femme
					['bags_1'] = 0, ['bags_2'] = 0,  -- Sac
					['tshirt_1'] = 39, ['tshirt_2'] = 0,  -- T shirt
					['torso_1'] = 55, ['torso_2'] = 0,  -- Torse
					['arms'] = 30,  -- Bras
					['pants_1'] = 46, ['pants_2'] = 0,  -- Pantalon
					['shoes_1'] =25, ['shoes_2'] = 0,  -- Chaussure
					['mask_1'] = 0, ['mask_2'] = 0,  -- Masque
					['bproof_1'] = 0,  -- Gillet par balle
					['chain_1'] = 0,  -- Chaine
					['helmet_1'] = -1, ['helmet_2'] = 0,  -- Casque
                    }
                },
                onEquip = function()  
                end
            }
        }
	},
}
