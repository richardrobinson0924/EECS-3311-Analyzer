note
	description: "Summary description for {LOUVRE_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOUVRE_EXPRESSION
inherit
	LOUVRE_OPERAND

feature
	type: LOUVRE_TYPE

	set_next_null_operand_to(newOperand: LOUVRE_OPERAND)
		require
			incomplete: not is_complete
		deferred end

	is_complete: BOOLEAN
		deferred end

end
