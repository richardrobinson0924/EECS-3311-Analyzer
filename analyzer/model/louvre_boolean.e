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
	make

feature
	type: LOUVRE_TYPE

feature {NONE} -- Initialization

	make(i: BOOLEAN)
			-- Initialization for `Current'.
		do
			value := i
			type := {LOUVRE_TYPE}.louvre_boolean_type
		end

end

