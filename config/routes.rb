Rails.application.routes.draw do 


  root			                      'static_pages#home' 
  get			'about'			         =>	'static_pages#about' 
/  get			'journal'		         =>	'static_pages#journal' /
  get			'technical'		       =>	'static_pages#technical'
  get     'crew'               => 'static_pages#crew'
  get     'gallery'            => 'static_pages#gallery'
  get     'admin'              => 'static_pages#admin'
  get     'gallery_boat'       => 'gallery#boat'
  get     'gallery_crew'       => 'gallery#crew'
  get     'gallery_cats'       => 'gallery#cats'
  get     'gallery_people'     => 'gallery#people'
  get     'login'              => 'sessions#new'
  post    'login'              => 'sessions#create'
  delete  'logout'             => 'sessions#destroy'

  resources		:messages, only: [:new, :create]
  resources   :sections, only: [:new, :create, :index, :destroy]
  resources   :tags, only: [:new, :create, :index, :destroy]
  resources   :journals, only: [:new, :create, :index, :destroy]

end 
