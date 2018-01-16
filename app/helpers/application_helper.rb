module ApplicationHelper 

    # Returns the full title on a per-page basis. 
    def full_title(base_title = '', page_title = '') 
        if base_title.empty? 
            if page_title.empty? 
                '' 
            else 
                page_title 
            end 
        else 
            if page_title.empty? 
                base_title 
            else 
                base_title + " | " + page_title 
            end 
        end 
    end 
end 