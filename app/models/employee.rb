class Employee < ActiveRecord::Base
  has_many :subordinates, class_name: "Employee",
                          foreign_key: "manager_id"
  has_one :phone, dependent: :destroy                        
  belongs_to :manager, class_name: "Employee"
  
  default_scope { order('last_name, first_name')}
  scope :without_ids, ->(ids) { where('id not in (?)', ids) }

  validates :first_name, :last_name, presence: true
  validates_associated :phone

  accepts_nested_attributes_for :phone

  before_destroy :update_subordinates

  def self.all_subordinates(employee)
    @subordinates_array ||= []
    sub_ordinates = employee.subordinates
    @subordinates_array += sub_ordinates.all
    sub_ordinates.each{ |empl| all_subordinates(empl) }
    @subordinates_array
  end

  def full_name
    [last_name, first_name].join(' ')
  end

private
    
  def update_subordinates
    self.subordinates.update_all(manager_id: nil)
  end

end
