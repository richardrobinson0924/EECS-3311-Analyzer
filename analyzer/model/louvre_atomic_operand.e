note
	description: "Summary description for {LOUVRE_ATOMIC_OPERAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOUVRE_ATOMIC_OPERAND[G -> ANY]
inherit
	LOUVRE_OPERAND

feature -- Access
	value: G

	to_string: STRING
		do
			Result := value.out
		end

feature -- Modifiers
	set_value(new_value: G)
		do
			value := new_value
		end

end
