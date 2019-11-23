note
	description: "Summary description for {LOUVRE_BINARY_OPERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_BINARY_OPERATOR
inherit
	LOUVRE_OPERATOR

create
	make, make_different_ops

feature
	op1_type: LOUVRE_CLASS
	op2_type: LOUVRE_CLASS

feature

	addition: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"+",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

	subtraction: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"-",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.integer
			)
		ensure
			instance_free: class
		end

	modulo: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"%%",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.integer
			)
		ensure
			instance_free: class
		end

	quotient: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"/",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.integer
			)
		ensure
			instance_free: class
		end

	multiplication: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"*",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.integer
			)
		ensure
			instance_free: class
		end

	conjunction: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"&&",
				{CLASS_POOL_ACCESS}.pool.boolean,
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

	disjunction: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"||",
				{CLASS_POOL_ACCESS}.pool.boolean,
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

	less_than: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"<",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

	greater_than: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				">",
				{CLASS_POOL_ACCESS}.pool.integer,
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

	equals_op: LOUVRE_BINARY_OPERATOR
		once
			create Result.make (
				"=",
				{CLASS_POOL_ACCESS}.pool.get ("NONE"),
				{CLASS_POOL_ACCESS}.pool.boolean
			)
		ensure
			instance_free: class
		end

feature {NONE}
	make(symbol_: STRING; op_type: LOUVRE_CLASS; return_type_: LOUVRE_CLASS)
		do
			symbol := symbol_
			return_type := return_type_

			op1_type := op_type
			op2_type := op_type
		end

	make_different_ops(symbol_: STRING; op1_type_, op2_type_: LOUVRE_CLASS; return_type_: LOUVRE_CLASS)
		do
			symbol := symbol_
			return_type := return_type_

			op1_type := op1_type_
			op2_type := op2_type_
		end

end
