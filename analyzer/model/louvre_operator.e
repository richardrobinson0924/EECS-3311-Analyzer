note
	description: "Summary description for {LOUVRE_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOUVRE_OPERATOR


feature
	symbol: STRING
	return_type: LOUVRE_CLASS

	to_string: STRING
		do
			Result := "" + symbol + ""
		end

feature


	negation(overloaded_type: LOUVRE_ATOMIC_OPERAND[ANY]): LOUVRE_UNARY_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			create Result.make (
				"~",
				overloaded_type,
				overloaded_type
			)
		ensure
			instance_free: class
		end

	identity(t: LOUVRE_CLASS): LOUVRE_UNARY_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			create Result.make ("", t, t)
		ensure
			instance_free: class
		end


end
