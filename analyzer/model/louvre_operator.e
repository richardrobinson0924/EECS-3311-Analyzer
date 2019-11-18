note
	description: "Summary description for {LOUVRE_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_OPERATOR

create
	make_operator, make_unary_operator


feature
	symbol: STRING
	operand_type: LOUVRE_CLASS
	return_type: LOUVRE_CLASS
	is_unary: BOOLEAN

	to_string: STRING
		do
			Result := " " + symbol + " "
		end

feature
	addition: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"+",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	subtraction: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"-",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	modulo: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"%%",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	quotient: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"/",
			access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	multiplication: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"*",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	conjunction: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"||",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	disjunction: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"&&",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	less_than: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"<",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	greater_than: LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				">",
				access.pool.get ("INTEGER"),
				access.pool.get ("INTEGER")
			)
		ensure
			instance_free: class
		end

	equals(overloaded_type: LOUVRE_ATOMIC_OPERAND[ANY]): LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"=",
				overloaded_type,
				access.pool.get("BOOLEAN")
			)
		ensure
			instance_free: class
		end

	negation(overloaded_type: LOUVRE_ATOMIC_OPERAND[ANY]): LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_unary_operator (
				"~",
				overloaded_type,
				overloaded_type
			)
		ensure
			instance_free: class
		end

	identity(t: LOUVRE_CLASS): LOUVRE_OPERATOR
		local
			access: CLASS_POOL_ACCESS
		once
			Result := create {LOUVRE_OPERATOR}.make_unary_operator ("", t, t)
		ensure
			instance_free: class
		end

feature {NONE} -- Initialization

	make_operator(name: STRING; operand_type_: LOUVRE_CLASS; return_type_: LOUVRE_CLASS)
			-- Initialization for `Current'.
		do
			symbol := name
			operand_type := operand_type_
			return_type := return_type_

			is_unary := False
		end

	make_unary_operator(name: STRING; operand_type_: LOUVRE_CLASS; return_type_: LOUVRE_CLASS)
			-- Initialization for `Current'.
		do
			symbol := name
			operand_type := operand_type_
			return_type := return_type_

			is_unary := True
		end

	make_call_chain_operator(

end
