# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  brand       :string
#  name        :string
#  notes       :text
#  open_date   :date
#  pao_months  :integer
#  photo       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#
class Product < ApplicationRecord
end
