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
	left: detachable LOUVRE_EXPRESSION
	right: detachable LOUVRE_EXPRESSION

	operator: LOUVRE_BINARY_OPERATOR

	actual_return_type: detachable LOUVRE_CLASS
		local
			t1, t2: detachable LOUVRE_CLASS
		do
			check attached left as al and then attached right as ar then
				t1 := al.actual_return_type
				t2 := ar.actual_return_type

				if operator.equals ({LOUVRE_BINARY_OPERATOR}.equals_op) then
					if attached t1 as at1 and then attached t2 as at2 and then at1.equals (at2) then
						Result := operator.return_type
					else
						Result := Void
					end
				else
					if operator.op1_type.equals (t1) and operator.op2_type.equals (t2) then
						Result := operator.return_type
					else
						Result := Void
					end
				end

			end
		end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		do
			if left = Void then
				left := newOperand
			elseif attached left as left_expression and then not left_expression.is_complete then
				left_expression.set_next_null_operand_to(newOperand)
			elseif right = Void then
				right := newOperand
			elseif attached right as right_expression then
				right_expression.set_next_null_operand_to(newOperand)
			end
		end

	is_complete: BOOLEAN
		do
			Result := True

			if left = Void or right = Void then
				Result := False
			elseif attached left as left_expression and then not left_expression.is_complete then
				Result := False
			elseif attached right as right_expression then
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
				elseif attached left as lel and then not lel.is_complete then
					Result := Result + "nil"
				else
					Result := Result + "?"
				end
			end

			Result := Result + ")"
		end

feature {NONE} -- Initialization

	make(operator_: LOUVRE_BINARY_OPERATOR)
			-- Initialization for `Current'.
		do
			operator := operator_
			left := Void
			right := Void
		end

end
