note
	description: "Summary description for {LOUVRE_INTEGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_INTEGER
inherit
	LOUVRE_ATOMIC_OPERAND[INTEGER]

create
	make_with_value

feature
	actual_return_type: LOUVRE_CLASS
		once
			Result := {CLASS_POOL_ACCESS}.pool.integer
		end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		do end

	is_complete: BOOLEAN
		once
			Result := True
		end

feature {NONE} -- Initialization

	make_with_value(i: INTEGER)
			-- Initialization for `Current'.
		do
			value := i
		end

end
