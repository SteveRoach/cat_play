module DebugHelper
	@@debug_level = Debug::DebugControl::DebugLevel
	@@indent = 0

	def self.set_debug_level(debug_level)
		@@debug_level = debug_level
	end

	def self.get_debug_level
		@@debug_level
	end

	def self.write_debug(function_name, level, indent_indicator, message)

		if level <= @@debug_level
			if indent_indicator == "-"
				@@indent -= 2
			end

			output = String.new("dbg(" +	Time.new.strftime("%H:%M:%S") + "): " + function_name + ": " + " " * @@indent + message)
			Rails.logger.debug output

			if indent_indicator == "+"
				@@indent += 2
			end
		end
	end
end

