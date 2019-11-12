note
	description: "Summary description for {LOUVRE_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_OPERATOR

create
	make_operator


feature
	symbol: STRING
	operand_type: LOUVRE_TYPE
	return_type: LOUVRE_TYPE

feature {NONE} -- Initialization

	make_operator(name: STRING; operand_type_: LOUVRE_TYPE; return_type_: LOUVRE_TYPE)
			-- Initialization for `Current'.
		do
			symbol := name
			operand_type := operand_type_
			return_type := return_type_
		end

end
