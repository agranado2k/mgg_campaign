Rails.application.routes.draw do
  get 'campaign/index', to: "campaign#index"
  get 'campaign/detail', to: "campaign#detail"

  root to: "campaign#index"
end
