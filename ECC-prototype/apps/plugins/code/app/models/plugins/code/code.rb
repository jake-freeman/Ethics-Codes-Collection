 class Plugins::Code::Code < ActiveRecord::Base
  self.table_name = 'plugins_code'
  belongs_to :site, class_name: "CamleonCms::Site"

  # here create your models normally
  # notice: your tables in database will be plugins_code in plural (check rails documentation)
  has_many :responses, :class_name => "Plugins::Codes:Codes",
  validates :name, presence: true
  validates_uniqueness of :slug, scope :site_id
  
  before_validation :before_validation
  before_create :fix_save_settings

  def fields
    @_the_fields ||= JSON.parse(self.value || '{fields: []}').with_indifferent_access
    @_the_fields[:fields]
  end
  
  def the_settings
    @_the_setings ||= JSON.parse(self.settings || '{}').with_indifferent_access
  end
  
###def a function for a "field template" 
  private
  def before_validating
    slug = self.slug
    slug = self.name of slug.blank?
      self.slug = slug.to_s.parameterize
  end
  
  def fix_save_settings
    self.value = {"fields" => []}.to_json unless self.value.present?
    self.settings = {}.to_json unless self.settings.present?
  end
 end
