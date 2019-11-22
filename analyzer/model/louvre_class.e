note
	description: "Summary description for {LOUVRE_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_CLASS

create
	make

feature -- Queries
	name: STRING

	equals(other: detachable LOUVRE_CLASS): BOOLEAN
		do
			Result := attached other as ao and then name ~ ao.name
		end

	-- Here you go Aamna
	-- Tips: you'll probs need a bunch of helper features
	--       you'll need to access the class pool
	invalid_assignment_instructions: LINKED_LIST[LOUVRE_ASSIGNMENT_INSTRUCTION]
		do
			create Result.make

			across routines as routine loop
				across routine.item.assignment_instructions as ai loop
					if ai.item.var ~ "Result" and attached {LOUVRE_QUERY} routine as query then
						if not (attached get_type_of_expression(routine.item, ai.item.expression) as rhs and then query.return_type.equals (rhs)) then
							Result.extend (ai.item)
						end
					elseif not (attached attributes[ai.item.var] as lhs_att and then attached get_type_of_expression(routine.item, ai.item.expression) as rhs and then lhs_att.return_type.equals (rhs)) then
						Result.extend (ai.item)
					end
				end
				
			end
		end

	get_type_of_expression(encapsulating_routine: LOUVRE_ROUTINE; expression: LOUVRE_EXPRESSION): detachable LOUVRE_CLASS
		local
			t1, t2: detachable LOUVRE_CLASS
		do
			if attached {LOUVRE_CALL_CHAIN} expression as lcce then
				Result := get_type_of_call_chain(encapsulating_routine, lcce.chain)
			elseif attached {LOUVRE_BINARY_EXPRESSION} expression as lbee then
				check attached lbee.left as al and then attached lbee.right as ar then
					if attached {LOUVRE_EXPRESSION} al as aleal then
						t1 := get_type_of_expression(encapsulating_routine, aleal)
					else
						t1 := al.return_type
					end

					if attached {LOUVRE_EXPRESSION} ar as alear then
						t2 := get_type_of_expression(encapsulating_routine, alear)
					else
						t2 := ar.return_type
					end

					if lbee.operator.equals ({LOUVRE_BINARY_OPERATOR}.equals_op) then
						if attached t1 as at1 and then attached t2 as at2 and then at1.equals (at2) then
							Result := lbee.operator.return_type
						else
							Result := Void
						end
					else
						if lbee.operator.op1_type.equals (t1) and lbee.operator.op2_type.equals (t2) then
							Result := lbee.operator.return_type
						else
							Result := Void
						end
					end

				end
			elseif attached {LOUVRE_UNARY_EXPRESSION} expression as luee then
				check attached luee.operand as op then
					if attached {LOUVRE_EXPRESSION} op as leop then
						t1 := get_type_of_expression(encapsulating_routine, leop)
					else
						t1 := op.return_type
					end

					if luee.operator.operand_type.equals (t1) then
						Result := luee.operator.return_type
					else
						Result := Void
					end
				end
			elseif attached {LOUVRE_ATOMIC_EXPRESSION} expression as laee then
				check attached laee.operand as op then
					if attached {LOUVRE_EXPRESSION} op as leop then
						Result := get_type_of_expression(encapsulating_routine, leop)
					else
						Result := op.return_type
					end
				end
			else
				check False end
			end

		end

	get_type_of_call_chain(encapsulating_routine: LOUVRE_ROUTINE; call_chain: ARRAYED_LIST[STRING]): detachable LOUVRE_CLASS
		local
			first_class: detachable LOUVRE_CLASS
			result_is_void: BOOLEAN
			returnable_class: LOUVRE_CLASS
		do
			result_is_void := FALSE

			if attached attributes[call_chain[1]] as att then
				first_class := att.return_type
			elseif across encapsulating_routine.parameters is tuple some tuple[1] ~ call_chain[1] end then
				across encapsulating_routine.parameters is tuple loop
					if tuple[1] ~ call_chain[1] then
						check attached {LOUVRE_CLASS} tuple[2] as t2 then first_class := t2 end
					end
				end
			else
				first_class := Void
				Result := Void
				result_is_void := TRUE
			end

			if attached first_class as afc then
				returnable_class := afc

				across 2 |..| call_chain.count is i loop
					if not result_is_void and then attached {LOUVRE_ATTRIBUTE} returnable_class.attributes[call_chain[i]] as tmp_class then
						returnable_class := tmp_class.return_type
						result_is_void := False
					else
						result_is_void := True
					end
				end
			else
				result_is_void := True
			end

			if not result_is_void then
				Result := returnable_class
			end

		end

	attributes: HASH_TABLE[LOUVRE_ATTRIBUTE, STRING]
		do
			create Result.make (0)

			across routines as routine loop
				if attached {LOUVRE_ATTRIBUTE} routine.item as r then
					Result.put(r, routine.key)
				end
			end
		end

	queries: HASH_TABLE[LOUVRE_QUERY, STRING]
		do
			create Result.make (0)

			across routines as routine loop
				if attached {LOUVRE_QUERY} routine.item as r then
					Result.put(r, routine.key)
				end
			end
		end

	commands: HASH_TABLE[LOUVRE_COMMAND, STRING]
		do
			create Result.make (0)

			across routines as routine loop
				if attached {LOUVRE_COMMAND} routine.item as r then
					Result.put(r, routine.key)
				end
			end
		end

	routines: HASH_TABLE[LOUVRE_ROUTINE, STRING]

	to_string: STRING
		do
			create Result.make_from_string("")
			Result := Result + "    " + name + "%N"
			Result := Result + "      " + "Number of attributes: " + attributes.count.out + "%N"

			across attributes is att loop
				Result := Result + att.out + "%N";
			end

			Result := Result + "      " + "Number of queries: " + queries.count.out + "%N"

			across queries is query loop
				Result := Result + query.out + "%N";
			end

			Result := Result + "      " + "Number of commands: " + commands.count.out + "%N"

			across commands is command loop
				Result := Result + command.out + "%N"
			end

		end

	java_string: STRING
		do
			Result := "  class " + name + " {%N"

			across routines as routine loop
				Result := Result + routine.item.java_string + "%N"
			end

			Result := Result + "  }%N"
		end


feature {NONE} -- Initialization

	make(name_: STRING)
			-- Initialization for `Current'.
		do
			name := name_
			create routines.make (0)
		end

end
