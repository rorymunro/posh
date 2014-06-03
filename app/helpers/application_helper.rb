module ApplicationHelper

	#returns the full page title
	def full_title(page_title)
		base_title = "The Posh"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
