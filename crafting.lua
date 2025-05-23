--core.register_craft({})
local S = core.get_translator("elysflowers")


core.register_craftitem("elysflowers:marshmallow_root", {
    description = S("Marshmallow Root"),
    inventory_image = "marshmallow_root.png",
    groups = { herb = 1, flora = 1, flammable = 2, compostability = 25 },
})

core.register_craftitem("elysflowers:marshmellow", {
    description = S("Marshmellows"),
    _mcl_cooking_output = "elysflowers:roasted_marshmellow",
    _doc_items_longdesc = S("A sweet treat, and a camping classic! Roast over a campfire for added flavor"),
    _mcl_saturation = 1.4,
    on_place = core.item_eat(5),
    on_secondary_use = core.item_eat(5),
    inventory_image = "marshmellow.png",
    groups = { herb = 1, flora = 1, flammable = 2, eatable = 5, food = 2, compostability = 2, food_marshmellow = 1, campfire_cookable = 1 },
    on_use = core.item_eat(2),
})

--for compat with default minetest game
core.register_craft({
    type = "cooking",
    output = "elysflowers:roasted_marshmellow",
    recipe = "elysflowers:marshmellow",
    cooktime = 3
})

core.register_craftitem("elysflowers:roasted_marshmellow", {
    description = S("Roasted Marshmellows"),
    on_place = core.item_eat(5),
    on_secondary_use = core.item_eat(5),
    inventory_image = "roasted_marshmellow.png",
    groups = { herb = 1, flora = 1, flammable = 2, eatable = 5, food = 2, compostability = 10, food_marshmellow = 1, campfire_cookable = 1 },
    on_use = core.item_eat(2),
    _mcl_saturation = 1.9,
})





core.register_craft({
    type = "shapeless",
    output = "elysflowers:marshmallow_root",
    recipe = { "elysflowers:marshmallow", "elysflowers:marshmallow", "elysflowers:marshmallow" }
})


core.register_craft({
    type = "shapeless",
    output = "elysflowers:marshmellow",
    recipe = { "elysflowers:marshmallow_root", "elysflowers:marshmallow_root", "elysflowers:marshmallow_root", "elysflowers:marshmallow_root" }
})
