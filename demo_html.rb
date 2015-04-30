class FancyMarkup
	def initialize
		@html_page = ""
		@tab_level = 0
	end
	
	def html(attributes = {}, &block)
		render("html", attributes, "", &block)
	end

	def body(attributes = {}, &block)
		render("body", attributes, "", &block)
	end

	def div(attributes = {}, &block)
		render("div", attributes, "", &block)
	end

	def ul(attributes = {}, &block)
		render("ul", attributes, "", &block)
	end

	def li(tag_inner_content, attributes = {})
		render("li", attributes, tag_inner_content)
	end

	def render(tag_type, attributes, tag_inner_content = "", &block)
		@html_page += "#{add_tabs(@tab_level)}<#{tag_type}"
		@html_page += " " << attributes.map { |key, value| "#{key}=\"#{value}\"" }.join(" ") unless attributes.empty?
		@html_page += ">"
		
		block_given? ? inner_tag(&block) : @html_page += tag_inner_content

		@html_page += "</#{tag_type}>\n"
	end

	private
	def inner_tag(&block)
		@tab_level += 1 

		@html_page += "\n"

		instance_eval(&block)

		@tab_level -= 1

		@html_page += "#{add_tabs(@tab_level)}"
	end

	def add_tabs(number_tabs)
		tabs = ""

		(number_tabs).times { tabs += "\t" }

		tabs
	end
end

output = FancyMarkup.new.html do
	body do
		div(id: "constainer") do
			ul(class: "pretty") do
				li("Item 1", class: :active)
				li("Item 2")
			end
		end
	end
end

puts output