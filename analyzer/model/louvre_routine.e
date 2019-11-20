note
	description: "Summary description for {LOUVRE_ROUTINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOUVRE_ROUTINE

feature
	name: STRING

	assignment_instructions: ARRAYED_LIST[LOUVRE_ASSIGNMENT_INSTRUCTION]

	parameters: ARRAY[TUPLE[name: STRING; type: LOUVRE_CLASS]]

	java_string: STRING
		deferred end

end
