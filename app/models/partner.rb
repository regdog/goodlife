class Partner < ActiveRecord::Base
  TYPES = ['Merchant', 'Distributor']

  default_scope order('created_at')
end
