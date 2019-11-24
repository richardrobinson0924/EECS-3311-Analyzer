note
	description: "Summary description for {LOUVRE_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOUVRE_EXPRESSION

feature
	actual_return_type: detachable LOUVRE_CLASS
		require
			complete: is_complete
		deferred end

	to_string: STRING
		deferred end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		require
			incomplete: not is_complete
		deferred end

	is_complete: BOOLEAN
		deferred end

end
