note
	description: "Summary description for {LOUVRE_UNARY_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_UNARY_EXPRESSION
inherit
	LOUVRE_EXPRESSION

create
	make

feature
	operand: detachable LOUVRE_EXPRESSION

	operator: LOUVRE_UNARY_OPERATOR

feature
	actual_return_type: detachable LOUVRE_CLASS
		local
			t1: detachable LOUVRE_CLASS
		do
			check attached operand as op then
				t1 := op.actual_return_type

				if operator.operand_type.equals (t1) then
					Result := operator.return_type
				else
					Result := Void
				end
			end
		end

	to_string: STRING
		do
			Result := operator.to_string
			if attached operand as ao then
				Result := Result + ao.to_string
			else
				Result := Result + "nil"
			end
		end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		do
			if attached operand as op then
				op.set_next_null_operand_to (newOperand)
			else
				operand := newOperand
			end
		end

	is_complete: BOOLEAN
		do
			Result := True

			if attached operand as op then
				Result := op.is_complete
			else
				Result := False
			end
		end

feature {NONE} -- Initialization

	make(operator_: LOUVRE_UNARY_OPERATOR)
			-- Initialization for `Current'.
		do
			operator := operator_
			operand := Void
		end

end
