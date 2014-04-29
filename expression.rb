
class Expression

	attr_accessor :tokens

	def initialize(string_expr)
		regexp_array = [];

		string_regexp = [/^"(\\.|[^"])*"/   ,1, true , 0.1];
		quote1_regexp = [/^'(\\.|[^'])*'/   ,2, true , 0.1];
		regexp_regexp = [/^\/(\\.|[^\/])*\//,3, true , 0.2];
		var_regexp    = [/^[[:word:]]+/     ,4, true , 0.1];
		spchar_regexp = [/^[^\w\s]/         ,5, true , 0  ];
		space_regexp  = [/^\s/              ,6, false, 0  ];


		regexp_array += [string_regexp]
		regexp_array += [quote1_regexp]
		regexp_array += [var_regexp   ]
		regexp_array += [spchar_regexp]
		regexp_array += [regexp_regexp]
		regexp_array += [space_regexp ]

		do_parse = true

		@tokens = [];
		
		while (do_parse)  do
			is_cmp = false
			regexp_array.each do |regexp|
				res = regexp[0].match(string_expr);
				if res != nil then
					is_cmp = true;
					@tokens += [Token.new(res[0], regexp[1], regexp[2], regexp[3])]
					size_of_token = res[0].size;
					string_expr = string_expr[size_of_token..-1];
					break;
				end
			end
			do_parse = is_cmp;
		end

	end
end

