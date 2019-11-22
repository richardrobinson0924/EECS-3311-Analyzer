note
	description: "Summary description for {LOUVRE_ATOMIC_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_ATOMIC_EXPRESSION

inherit
	LOUVRE_EXPRESSION

create
	make

feature
	operand: detachable LOUVRE_OPERAND

	to_string: STRING
		do
			Result := "?"
			if attached operand as ao then
				Result := ao.to_string
			end
		end

	set_next_null_operand_to(newOperand: LOUVRE_OPERAND)
		do
			if operand = Void then
				operand := newOperand
			elseif attached {LOUVRE_EXPRESSION} operand as leo then
				leo.set_next_null_operand_to (newOperand)
			else
				check False end
			end
		end

	is_complete: BOOLEAN
		do
			Result := True

			if operand = Void then
				Result := False
			elseif attached {LOUVRE_EXPRESSION} operand as leo then
				Result := leo.is_complete
			end
		end


	return_type: LOUVRE_CLASS
		do
			if attached operand as op then
				Result := op.return_type
			else
				Result := {CLASS_POOL_ACCESS}.pool.get ("NONE")
			end
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

end
