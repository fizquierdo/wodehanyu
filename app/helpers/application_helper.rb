module ApplicationHelper
	# determine the level at which the user is playing
	def hsk_levels
		[1]
	end
	# these formats are required by springy
	def springy_node(pairs)
		'{' + pairs.map{|w| w[0].to_s+':"'+w[1]+'"'}.join(',') + '},'
	end
	def springy_edge(from, to, directional=true)
		to   = '"' + to + '"'
		from = '"' + from + '"'
		pairs =[['color', '"#00A0B0"'], ['directional', directional.to_s]]
		properties = '{' + pairs.map{|w| w.join(':')}.join(',') + '}'
		'[' + [from, to, properties].join(',') + '],'
	end
	def gradient(rate)
		value = rate.to_f * 100
		value = value.round
		value = 100 if value >= 100
		value = 0 if value <= 0
		#g = Gradient.new(0xE39733, 0x6E856D, 100)
		g = Gradient.new(0xff5533, 0x6Eaa6D, 100)
		'#' + g.gradient(value).to_s(16)
	end
	class Gradient
		attr_accessor :resolution, :R0, :G0, :B0, :R1, :G1, :B1

		def initialize(start, stop, resolution)
			@resolution = Float(resolution)

			@R0 = (start & 0xff0000) >> 16;
			@G0 = (start & 0x00ff00) >> 8;
			@B0 = (start & 0x0000ff) >> 0;

			@R1 = (stop & 0xff0000) >> 16;
			@G1 = (stop & 0x00ff00) >> 8;
			@B1 = (stop & 0x0000ff) >> 0;
		end

		def gradient(step)
			r = interpolate(@R0, @R1, step);
			g = interpolate(@G0, @G1, step);
			b = interpolate(@B0, @B1, step);

			(((r << 8) | g) << 8) | b;
		end

		def interpolate(start, stop, step)
			if (start < stop)
				return (((stop - start) * (step / @resolution)) + start).round;
			else
				return (((start - stop) * (1 - (step / @resolution))) + stop).round;
			end
		end
	end
end
