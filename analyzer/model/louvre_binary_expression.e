note
	description: "Summary description for {LOUVRE_BINARY_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_BINARY_EXPRESSION
inherit
	LOUVRE_EXPRESSION

create
	make

feature
	left: detachable LOUVRE_OPERAND

	right: detachable LOUVRE_OPERAND

	operator: LOUVRE_OPERATOR

	set_next_null_operand_to(newOperand: LOUVRE_OPERAND)
		do
			if left = Void then
				left := newOperand
			elseif attached {LOUVRE_EXPRESSION} left as left_expression then
				if not left_expression.is_complete then
					left_expression.set_next_null_operand_to(newOperand)
				else
					if right = Void then
						right := newOperand
					elseif attached {LOUVRE_EXPRESSION} right as right_expression then
						right_expression.set_next_null_operand_to(newOperand)
					end
				end
			elseif right = Void then
				right := newOperand
			elseif attached {LOUVRE_EXPRESSION} right as right_expression then
				right_expression.set_next_null_operand_to(newOperand)
			end
		end

	is_complete: BOOLEAN
		do
			Result := True

			if left = Void then
				Result := False
			elseif attached {LOUVRE_EXPRESSION} left as left_expression then
			--	Result := left_expression.is_complete
				if left_expression.is_complete then
					if right = Void then
						Result := False
					elseif attached {LOUVRE_EXPRESSION} right as ler then
						Result := ler.is_complete
					end
				else
					Result := False
				end
			elseif right = Void then
				Result := False
			elseif attached {LOUVRE_EXPRESSION} right as right_expression then
				Result := right_expression.is_complete
			end
		end

	to_string: STRING
		do
			create Result.make_from_string("(")

			if attached left as left_attached then
				Result := Result + left_attached.to_string
			else
				Result := Result + "?"
			end

			Result := Result + " " + operator.to_string + " "

			if attached right as right_attached then
				Result := Result + right_attached.to_string
			else
				if left = Void then
					Result := Result + "nil"
				elseif attached {LOUVRE_EXPRESSION} left as lel and then not lel.is_complete then
					Result := Result + "nil"
				else
					Result := Result + "?"
				end
			end

			Result := Result + ")"
		end

feature {NONE} -- Initialization

	make(operator_: LOUVRE_OPERATOR)
			-- Initialization for `Current'.
		do
			operator := operator_
			left := Void
			right := Void

		--	return_type := operator.return_type
		end

end
