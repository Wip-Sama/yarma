local yafla_gui_components = require("__yafla__/scripts/experimental/gui_components.lua")
local yafla_gui_builder = require("__yafla__/scripts/experimental/gui_builder.lua")

local switch_filter_mode = function(event)
	local switch_flow = event.element.parent.children[(#event.element.parent.children) - 1]
	switch_flow.clear()
	local filters = {
		--Resource
		{
			CHOOSE_ELEM_BUTTON {
				elem_type = "item"
			}
		},
		--Amount
		{
			TEXTFIELD {
				top_margin = 5,
				text = 0,
				numeric = true,
				allow_decimal = true,
			},
			Aritmetic_dropdown({ top_margin = 6 }),
		},
		--Time_left
		{
			Time_dropdown({ top_margin = 6 }),
			TEXTFIELD {
				top_margin = 5,
				text = 0,
				numeric = true,
				allow_decimal = true,
			},
			Aritmetic_dropdown({ top_margin = 6 }),
		},
		--Extraction_speed
		{
			Time_dropdown({ top_margin = 6 }),
			TEXTFIELD {
				top_margin = 5,
				text = 0,
				numeric = true,
				allow_decimal = true,
			},
			Aritmetic_dropdown({ top_margin = 6 }),
		},
		--Surface
		{
			Surface_dropdown({ top_margin = 6 })
		}
	}
	yafla_gui_builder.build(switch_flow,
		filters[event.element.selected_index]
	)
end

yafla_gui_builder.register_handler("switch_filter_mode", switch_filter_mode)

local function generate_ui()
	for _, v in pairs(game.players) do
		local window = Window(v, {
			pinnable = true,
			closable = true
		})
		yafla_gui_builder.build(window,
			{
				FRAME {
					direction = "vertical",
					style = "inside_shallow_frame",
					horizontally_stretchable = true,
					vertically_stretchable = true,
					bottom_margin = 10,
					FRAME {
						horizontally_stretchable = true,
						height = 30,
					},
					SCROLL_PANE {
						height = 396,
						horizontally_stretchable = true,
						vertical_scroll_policy = "always",
						horizontal_scroll_policy = "never",
						style = "list_box_scroll_pane",
						FLOW {
							horizontally_stretchable = true,
							vertically_stretchable = true,
						}
					},
				},
				FRAME {
					direction = "horizontal",
					style = "inside_shallow_frame",
					horizontally_stretchable = true,
					padding = 4,
					height = 48,
					LABEL {
						top_margin = 10,
						left_margin = 6,
						caption = "Filter by: ",
						ignored_by_interaction = true,
						style = "bold_label",
					},
					DROP_DOWN {
						top_margin = 6,
						items = {
							"Resource",
							"Amount",
							"Time left",
							"Extraction speed",
							"Surface"
						},
						selected_index = 1,
						on_selection_changed = "switch_filter_mode"
					},
					FLOW {
						CHOOSE_ELEM_BUTTON {
							elem_type = "item"
						}
					},
					EMPTY_WIDGET {
						horizontally_stretchable = true,
					},
				},
			}
		)
	end
end

script.on_init(generate_ui)
script.on_configuration_changed(generate_ui)
script.on_event(defines.events.on_player_created, generate_ui)
