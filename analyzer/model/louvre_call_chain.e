note
	description: "Summary description for {LOUVRE_CALL_CHAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_CALL_CHAIN
inherit
	LOUVRE_EXPRESSION

create
	make

feature
	chain: ARRAYED_LIST[STRING]
	routine: LOUVRE_ROUTINE
	clazz: LOUVRE_CLASS


	actual_return_type: detachable LOUVRE_CLASS
		local
			first_class: detachable LOUVRE_CLASS
			result_is_void: BOOLEAN
			returnable_class: LOUVRE_CLASS
		do
			result_is_void := FALSE

			if attached clazz.attributes[chain[1]] as att then
				first_class := att.return_type
			elseif across routine.parameters is tuple some tuple[1] ~ chain[1] end then
				across routine.parameters is tuple loop
					if tuple[1] ~ chain[1] then
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

				across 2 |..| chain.count is i loop
					if not result_is_void and then attached {LOUVRE_ATTRIBUTE} returnable_class.attributes[chain[i]] as tmp_class then
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

	to_string: STRING
		do
			Result := ""

			across chain as s loop
				Result := Result + s.item
				if s.cursor_index /= chain.count then
					Result := Result + "."
				end
			end
		end

	set_next_null_operand_to(newOperand: LOUVRE_EXPRESSION)
		do
		end

	is_complete: BOOLEAN
		do
			Result := True
		end

feature {NONE} -- Initialization

	make(chain_: ITERABLE[STRING]; callable_routine: LOUVRE_ROUTINE; callable_class: LOUVRE_CLASS)
			-- Initialization for `Current'.
		do
			create chain.make_from_iterable (chain_)
			routine := callable_routine
			clazz := callable_class
		end

end
