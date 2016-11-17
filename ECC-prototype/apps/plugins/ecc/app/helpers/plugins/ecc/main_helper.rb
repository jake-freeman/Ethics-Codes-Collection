module Plugins::Ecc::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  # here all actions on going to active
  # you can run sql commands like this:
  # results = ActiveRecord::Base.connection.execute(query);
  # plugin: plugin model
  def ecc_on_active(plugin)
    generate_custom_field_ecc
  end

  # here all actions on going to inactive
  # plugin: plugin model
  def ecc_on_inactive(plugin)
  end

  # here all actions to upgrade for a new version
  # plugin: plugin model
  def ecc_on_upgrade(plugin)
  end

  def ecc_admin_before_load
     pt = current_site.post_types.hidden_menu.where(slug: "ecc").first
    if pt.present?
      items_i = []
      items_i << {icon: "list", title: t('plugin.ecc.all_pages'), url: admin_plugins_ecc_ecc_staticpages_path(pt.id)}
      items_i << {icon: "list", title: t('plugin.ecc.all_orgs'), url: admin_plugins_ecc_ecc_orgs_path(pt.id)} 
       items_i << {icon: "list", title: t('plugin.ecc.all_codes'), url: admin_plugins_ecc_ecc_codes_path(pt.id)} 
     if pt.manage_categories?
        items_i << {icon: "folder-open", title: t('camaleon_cms.admin.post_type.categories'), url: cama_admin_post_type_categories_path(pt.id)} if can? :categories, pt
      end
      if pt.manage_tags?
        items_i << {icon: "tags", title: t('camaleon_cms.admin.post_type.tags'), url: cama_admin_post_type_post_tags_path(pt.id)} if can? :post_tags, pt
      end

      items_i << {icon: "cogs", title: t('camaleon_cms.admin.button.settings'), url: admin_plugins_ecc_settings_path}

      admin_menu_insert_menu_after("content", "ecc", {icon: "camera", title: t('plugin.ecc.ecc'), url: "", items: items_i}) if items_i.present?
    end

    # add assets admin
    append_asset_libraries({ecc: {css: [plugin_gem_asset('admin')], js: [plugin_gem_asset('admin')]}})

  end

def get_ecc_post_type
  @ecc = current_site.post_types.hidden_menu.where(slug: "ecc").first
  unless @ecc.present?
    @ecc = current_site.post_types.hidden_menu.new(slug: "ecc", name: "Ecc")
    if @ecc.save
      @ecc.set_meta('_default', {
        has_category: false,
        has_tags: true,
        not_deleted: true,
        has_summary: true,
        has_content: true,
        has_comments: false,
        has_picture: false,
        has_template: false,
      })
      @ecc.categories.create({name: 'Uncategorized', slug: 'Uncategorized'.parameterize})
    end

  end

end

private
def generate_custom_field_ecc
  get_ecc_post_type
  unless @ecc.get_field_groups.where(slug: "plugin_ecc_node_data").present?
    @ecc.get_field_groups.destroy_all
    group = @ecc.add_custom_field_group({name: 'Eccs Details', slug: 'plugin_ecc_node_data'})
  end
end
end
