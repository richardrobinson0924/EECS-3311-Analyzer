note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NUMERICAL_NEGATION
inherit
	ETF_NUMERICAL_NEGATION_INTERFACE
create
	make
feature -- command
	numerical_negation
    	do
    		if attached model.current_instruction as ci then
				ci.expression.set_next_null_operand_to (create {LOUVRE_UNARY_EXPRESSION}.make ({LOUVRE_UNARY_OPERATOR}.numerical_negation))
			else
				model.set_status ("Error (An assignment instruction is not currently being specified).")
			end

			model.set_out (model.to_string)
			
			-- perform some update on the model state
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
