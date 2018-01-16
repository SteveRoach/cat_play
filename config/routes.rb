Rails.application.routes.draw do 
  get 'gallery/cats'

  get 'gallery/boat'

  get 'gallery/people'

  root			'static_pages#home' 
  get			'about'			=>	'static_pages#about' 
  get			'journal'		=>	'static_pages#journal' 
  get			'technical'		=>	'static_pages#technical'
  get           'crew'          =>  'static_pages#crew'
  get           'gallery'       =>  'static_pages#gallery'

  resources		:messages, only: [:new, :create]

end 
 