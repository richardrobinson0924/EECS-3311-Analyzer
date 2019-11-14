note
	description: "Summary description for {LOUVRE_ROUTINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOUVRE_ROUTINE

feature
	name: STRING
		deferred end

	assignment_instructions: ARRAYED_LIST[LOUVRE_ASSIGNMENT_INSTRUCTION]
		deferred end

end
