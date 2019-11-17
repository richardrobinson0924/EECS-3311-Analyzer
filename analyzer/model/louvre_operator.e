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

feature
	addition: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"+",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_integer_type
			)
		ensure
			instance_free: class
		end

	subtraction: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"-",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_integer_type
			)
		ensure
			instance_free: class
		end

	modulo: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"%%",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_integer_type
			)
		ensure
			instance_free: class
		end

	quotient: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"/",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_integer_type
			)
		ensure
			instance_free: class
		end

	multiplication: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"/",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_integer_type
			)
		ensure
			instance_free: class
		end

	conjunction: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"||",
				{LOUVRE_TYPE}.louvre_boolean_type,
				{LOUVRE_TYPE}.louvre_boolean_type
			)
		ensure
			instance_free: class
		end

	disjunction: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"&&",
				{LOUVRE_TYPE}.louvre_boolean_type,
				{LOUVRE_TYPE}.louvre_boolean_type
			)
		ensure
			instance_free: class
		end

	less_than: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"<",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_boolean_type
			)
		ensure
			instance_free: class
		end

	greater_than: LOUVRE_OPERATOR
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				">",
				{LOUVRE_TYPE}.louvre_integer_type,
				{LOUVRE_TYPE}.louvre_boolean_type
			)
		ensure
			instance_free: class
		end

	equals(overloaded_type: LOUVRE_TYPE): LOUVRE_OPERATOR
		require
			int_or_bool: overloaded_type.is_equal ({LOUVRE_TYPE}.louvre_boolean_type) or overloaded_type.is_equal ({LOUVRE_TYPE}.louvre_integer_type)
		once
			Result := create {LOUVRE_OPERATOR}.make_operator (
				"=",
				overloaded_type,
				{LOUVRE_TYPE}.louvre_boolean_type
			)
		ensure
			instance_free: class
		end

	negation(overloaded_type: LOUVRE_TYPE): LOUVRE_OPERATOR
		require
			int_or_bool: overloaded_type.is_equal ({LOUVRE_TYPE}.louvre_boolean_type) or overloaded_type.is_equal ({LOUVRE_TYPE}.louvre_integer_type)
		once
			Result := create {LOUVRE_OPERATOR}.make_unary_operator (
				"~",
				overloaded_type,
				overloaded_type
			)
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

end
