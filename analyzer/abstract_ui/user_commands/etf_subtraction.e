note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SUBTRACTION
inherit
	ETF_SUBTRACTION_INTERFACE
create
	make
feature -- command
	subtraction
    	do
    		if attached model.current_instruction as ci then
				model.add_expression (create {LOUVRE_BINARY_EXPRESSION}.make ({LOUVRE_BINARY_OPERATOR}.subtraction))
			else
				model.set_status ("Error (Assignment instruction not currently being specified).")
			end

			model.set_out (model.to_string)

			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
