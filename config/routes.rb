Rails.application.routes.draw do 

  root			                      'static_pages#home' 
  get			'about'			         =>	'static_pages#about' 
  get			'journal'		         =>	'static_pages#journal' 
  get			'technical'		       =>	'static_pages#technical'
  get     'crew'               => 'static_pages#crew'
  get     'gallery'            => 'static_pages#gallery'
  get     'gallery_boat'       => 'gallery#boat'
  get     'gallery_crew'       => 'gallery#crew'
  get     'gallery_cats'       => 'gallery#cats'
  get     'gallery_people'     => 'gallery#people'

  resources		:messages, only: [:new, :create]

end 
 