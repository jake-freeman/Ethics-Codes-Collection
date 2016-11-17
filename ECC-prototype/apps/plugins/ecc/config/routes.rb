Rails.application.routes.draw do

  namespace :frontend do
    get 'codes/display'
  end

    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'ecc' do
            get 'index' => 'front#index'
#            resources :eccs, controller: "front/eccs" do 
#              resources :staticpages, controller: "front/staticpages"
#              resources :orgs, controller: "front/orgs"
 #             resources :codes, controller: "front/codes"
#            end
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'ecc' do
            get 'index' => 'admin#index'
            get 'settings' => 'admin/settings#index'
            resources :eccs, controller: "admin/eccs" do
              resources :orgs, controller: "admin/orgs"
              resources :codes, controller: "admin/codes"
              resources :staticpages, controller: "admin/statics"
              end
          end
        end
      end

      # main routes
      #scope 'ecc', module: 'plugins/ecc/', as: 'ecc' do
      #  Here my routes for main routes
      #end
    end
  end
