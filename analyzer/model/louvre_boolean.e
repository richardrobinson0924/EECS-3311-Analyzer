note
	description: "Summary description for {LOUVRE_BOOLEAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_BOOLEAN
inherit
	LOUVRE_ATOMIC_OPERAND[BOOLEAN]

create
	make_value

feature
	actual_return_type: detachable LOUVRE_CLASS
		once
			Result := {CLASS_POOL_ACCESS}.pool.boolean
		end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		do
		end

	is_complete: BOOLEAN
		once
			Result := True
		end

feature {NONE} -- Initialization

	make_value(i: BOOLEAN)
			-- Initialization for `Current'.
		do
			value := i
		end

end

