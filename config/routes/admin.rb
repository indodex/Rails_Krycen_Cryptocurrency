namespace :admin do
  get '/', to: 'dashboard#index', as: :dashboard

  resources :documents
  resources :id_documents,     only: [:index, :show, :update]
  resource  :currency_deposit, only: [:new, :create]
  resources :proofs
  resources :tickets, only: [:index, :show] do
    member do
      	patch :close
	patch :reopen
    end
    resources :comments, only: [:create]
  end

  namespace :settings do
    resources :notifications, only: [:index, :show, :edit, :update, :create, :new] do
      member do
        get :active
        delete :delete
      end
    end
  end


  match '/members/gen_address', to: 'members#gen_address', via: :all, as: 'gen_address_members'
  resources :members, only: [:index, :show] do
    member do
      post :active
      post :toggle
    end

    resources :two_factors, only: [:destroy]
  end

  namespace :deposits do
    Deposit.descendants.each do |d|
      resources d.resource_name
    end
  end

  namespace :withdraws do
    Withdraw.descendants.each do |w|
      resources w.resource_name
    end
  end

  namespace :statistic do
    resource :members, :only => :show
    resource :orders, :only => :show
    get 'trades/success', to: 'trades#success'
    resource :trades, :only => [:show]
    resource :deposits, :only => :show
    resource :withdraws, :only => :show
    resource :random_stats, :only => :show
  end
end
