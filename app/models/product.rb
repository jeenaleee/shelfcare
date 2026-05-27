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
#  tossed      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#

class Product < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true, optional: true

  validates :name, presence: true
  validates :open_date, presence: true
  validates :pao_months, presence: true


  def expiry_date
    open_date + pao_months.months
  end

  def status
    if expiry_date < Date.today
      "expired"
    elsif expiry_date < Date.today + 30.days
      "expiring soon"
    else
      "good"
    end
  end
end
