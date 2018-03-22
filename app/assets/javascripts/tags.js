$('.tag_link').click(function(event){
	event.preventDefault();
	var chosen_tag = $(this).text();
	var displayed_tags = $('#tag_text').val();
	var displayed_tags_length = displayed_tags.length;
	var n = displayed_tags.search(chosen_tag);
	if(n == -1){
		if(displayed_tags_length > 0){
			$('#tag_text').val( $('#tag_text').val() + ", " + chosen_tag)
		}
		else{
			$('#tag_text').val( $('#tag_text').val() + chosen_tag)
		}
	}
});
