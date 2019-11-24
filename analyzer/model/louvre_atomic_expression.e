note
	description: "Summary description for {LOUVRE_ATOMIC_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ATOMIC_EXPRESSION
inherit
	LOUVRE_EXPRESSION

create
	make

feature
	operand: detachable LOUVRE_EXPRESSION

	actual_return_type: detachable LOUVRE_CLASS
		do
			check attached operand as op then
				Result := op.actual_return_type
			end
		end

	to_string: STRING
		do
			Result := "?"
			if attached operand as ao then
				Result := ao.to_string
			end
		end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		do
			if attached operand as op then
				op.set_next_null_operand_to (newOperand)
			else
				operand := newOperand
			end
		end

	is_complete: BOOLEAN
		do
			Result := True

			if attached operand as op then
				Result := op.is_complete
			else
				Result := False
			end
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

end
