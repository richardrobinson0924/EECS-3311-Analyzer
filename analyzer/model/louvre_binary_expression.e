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
					right := newOperand
				end
			elseif right = Void then
				left := newOperand
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
				Result := left_expression.is_complete
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
				Result := Result + "nil"
			end

			Result := Result + ")"
		end

	to_string_alt: STRING
		do
			Result := ""
		end

feature {NONE} -- Initialization

	make(operator_: LOUVRE_OPERATOR)
			-- Initialization for `Current'.
		do
			operator := operator_
			left := Void
			right := Void

			type := {LOUVRE_TYPE}.louvre_expression_type
		end

end
