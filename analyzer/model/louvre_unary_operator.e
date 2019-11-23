note
	description: "Summary description for {LOUVRE_UNARY_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_UNARY_OPERATOR
inherit
	LOUVRE_OPERATOR

create
	make

feature
	operand_type: LOUVRE_CLASS

feature
	numerical_negation: LOUVRE_UNARY_OPERATOR
		once
			create Result.make (
				"!",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.integer
			)
		ensure
			instance_free: class
		end

	logical_negation: LOUVRE_UNARY_OPERATOR
		once
			create Result.make (
				"~",
				{CLASS_POOL_ACCESS}.pool.boolean,
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

feature {NONE}
	make(symbol_: STRING; operand_type_: LOUVRE_CLASS; return_type_: LOUVRE_CLASS)
		do
			symbol := symbol_
			return_type := return_type_
			operand_type := operand_type_
		end

end
