#Rails.application.config.to_prepare do
  CamaleonCms::Site.class_eval do
    has_many :eccs, :class_name => "Plugins::Ecc::Ecc", dependent: :destroy
  end
#end
