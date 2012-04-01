HomeAlbum::Application.routes.draw do

  get 'gallery(/*gallery_path)' => 'gallery#index', :gallery_path => ''

end
