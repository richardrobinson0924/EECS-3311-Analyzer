note
	description: "Summary description for {LOUVRE_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOUVRE_TYPE
inherit
	LOUVRE_CLASS redefine is_equal end

create {LOUVRE_TYPE} make_enum

feature
	is_equal(other: like Current): BOOLEAN
		do
			Result := out.is_equal(other.out)
		end

	Louvre_Integer_Type: LOUVRE_TYPE
		once
			create Result.make_enum("INTEGER")
		ensure
			instance_free: class
		end

	Louvre_Boolean_Type: LOUVRE_TYPE
		once
			create Result.make_enum("BOOLEAN")
		ensure
			instance_free: class
		end

	Louvre_Expression_Type: LOUVRE_TYPE
		once
			create Result.make_enum("EXPRESSION")
		ensure
			instance_free: class
		end

feature

	make_enum(s: STRING)
		do
			name := s
			create routines.make (0)
		end


end
