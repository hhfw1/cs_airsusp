# Grappling Gun | QB/ESX/STANDALONE

If you need support I now have a discord available, it helps me keep track of issues and give better support.

https://discord.gg/ESwSKregtt


# INSTALLATION


---
## Item installation
 1.Fill Config to design script according to your needs
 2.Add the image files from the image folder to your `inventory` folder

# QB

- Add these lines to your qb-core > shared lua under the Items section
```lua
	["grapple"] = {
		["name"] = "grapple",                                                        
		["label"] = "Grapple Gun",
		["weight"] = 1000,
		["type"] = "item",
		["image"] = "grapple.png",
		["unique"] = false,
		["useable"] = true,
		["shouldClose"] = true,
		["combinable"] = nil,
		["description"] = "Where are you?"
    	},
```
# ESX

``` sql
    INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('grapple', 'Grapple Gun', 2, 0, 1);
```
