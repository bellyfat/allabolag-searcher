ApoexAllabolag::Application.routes.draw do
  resources :results

  root :to => "apo_ex#allabolag"
end
