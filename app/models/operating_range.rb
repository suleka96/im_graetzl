class OperatingRange < ActiveRecord::Base
  belongs_to :graetzl
  belongs_to :operator, polymorphic: true
end
