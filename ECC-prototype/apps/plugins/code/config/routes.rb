Rails.application.routes.draw do

    scope PluginRoutes.system_info["relative_url_root"] do
      scope '(:locale)', locale: /#{PluginRoutes.all_locales}/, :defaults => {  } do
        # frontend
        namespace :plugins do
          namespace 'code' do
            get 'index' => 'front#index'
          end
        end
      end

      #Admin Panel
      scope :admin, as: 'admin', path: PluginRoutes.system_info['admin_path_name'] do
        namespace 'plugins' do
          namespace 'code' do
            get 'index' => 'admin#index'
          end
        end
      end

      #main routes
      scope 'code', module: 'plugins/code/', as: 'code' do
       # Here my routes for main routes
      
      end
    end
  end
