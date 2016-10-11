module Spina
  module DefaultTheme
    include ::ActiveSupport::Configurable

    config_accessor :title, :page_parts, :view_templates, :layout_parts, :custom_pages, :plugins, :structures

    self.title = 'Default theme'

    self.page_parts = [{
      name:               'page_content',
      title:              'Content', 
      page_partable_type: 'Spina::Text'
    }, {
      name: 'tags',
      title: 'Tags',
      page_partable_type: 'Spina::Text'
    }]

    self.structures = {}

    self.layout_parts = []

    self.view_templates = {
      'homepage' => {
        title:      'Homepage',
        page_parts: ['page_content' ]
      },
      'show' => {
        title:        'Default',
        description:  'A simple page',
        usage:        'Use for codes',
        page_parts:   ['page_content', 'tags']
      }, 
      'static' => {
      title: 'Static pages',
      description: 'A simple page',
      usage: 'used for displaying basic pages (index, etc)',
      page_parts: ['page_content']
      }
    }

    self.custom_pages = [{
      name:           'homepage',
      title:          'Homepage',
      deletable:      false,
      view_template:  'homepage'
    }]

    self.plugins = []

  end
end

theme = Spina::Theme.new
theme.name = 'default'
theme.config = Spina::DefaultTheme.config
Spina.register_theme(theme)
