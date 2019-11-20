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

	set_next_null_operand_to(newOperand: LOUVRE_OPERAND)
		do
		end

	is_complete: BOOLEAN
		do
			Result := True
		end

feature {NONE} -- Initialization

	make(chain_: ITERABLE[STRING])
			-- Initialization for `Current'.
		do
			create chain.make_from_iterable (chain_)
		end

end
