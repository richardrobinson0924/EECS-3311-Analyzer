note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPRESSION
inherit
	LOUVRE_OPERAND redefine out end

create
	make

feature
	representation: STRING
		do
			create Result.make_from_string("")
		end

	left: detachable LOUVRE_OPERAND

	right: detachable LOUVRE_OPERAND

	operator: LOUVRE_OPERATOR

	set_next_null_operand_to(newOperand: LOUVRE_OPERAND)
		local
			e: EXPRESSION
		do
			if attached {EXPRESSION} left as left_expression then

			end
		end

	type: LOUVRE_TYPE

	is_complete: BOOLEAN
		do
			if attached {EXPRESSIO then

			end
		end

	out: STRING
		do
			create Result.make_from_string("")
		end

feature {NONE} -- Initialization

	make(operator_: LOUVRE_OPERATOR)
			-- Initialization for `Current'.
		do
			operator := operator_
			left := Void
			right := Void

			type := {LOUVRE_TYPE}.louvre_expression_type
		end

end
