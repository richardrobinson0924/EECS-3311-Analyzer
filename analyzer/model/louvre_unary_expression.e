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
	operand: detachable LOUVRE_OPERAND

	operator: LOUVRE_UNARY_OPERATOR

feature
	to_string: STRING
		do
			Result := operator.to_string
			if attached operand as ao then
				Result := Result + ao.to_string
			else
				Result := Result + "nil"
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
			Result := operator.return_type
		end


feature {NONE} -- Initialization

	make(operator_: LOUVRE_UNARY_OPERATOR)
			-- Initialization for `Current'.
		do
			operator := operator_
			operand := Void
		end

end
