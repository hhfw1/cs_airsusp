# Air Suspension | QB/ESX/STANDALONE

https://discord.gg/62jqEKz8Sb


# INSTALLATION


---
## Item installation
 1.Fill Config to design script according to your needs
 2.Add the image files from the image folder to your `inventory` folder

# QB

- Add these lines to your qb-core > shared lua under the Items section
```lua
	["airsuspension"] = {
		["name"] = "airsuspension",                                                        
		["label"] = "Air Suspension",
		["weight"] = 1000,
		["type"] = "item",
		["image"] = "airsuspension.png",
		["unique"] = false,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Where are you?"
    },
```
# ESX

- Insert SQL
``` sql
    INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('airsuspension', 'Air Suspension', 2, 0, 1);
```
