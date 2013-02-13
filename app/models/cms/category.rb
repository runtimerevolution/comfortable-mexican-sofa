class Cms::Category < ActiveRecord::Base

  ComfortableMexicanSofa.establish_connection(self)

  self.table_name = 'cms_categories'

  attr_accessible :label,
                  :categorized_type

  # -- Relationships --------------------------------------------------------
  acts_as_list :scope => [:site_id, :categorized_type]
  belongs_to :site
  has_many :categorizations,
    :dependent => :destroy

  # -- Validations ----------------------------------------------------------
  validates :site_id,
    :presence   => true
  validates :label,
    :presence   => true,
    :uniqueness => { :scope => [:categorized_type, :site_id] }
  validates :categorized_type,
    :presence   => true

  # -- Scopes ---------------------------------------------------------------
  default_scope order(:label)
  scope :of_type, lambda { |type|
    where(:categorized_type => type)
  }

  def self.by_order
    unscoped.order(:position)
  end

end