HomeAlbum::Application.routes.draw do

  get 'gallery(/*gallery_path)' => 'gallery#index', :gallery_path => ''

  if Rails.env.development?
    get 'resize_128x128(/*gallery_path)' => 'gallery#resize_128x128', :gallery_path => ''
    get 'resize_1024x768(/*gallery_path)' => 'gallery#resize_1024x768', :gallery_path => ''
  end
end
