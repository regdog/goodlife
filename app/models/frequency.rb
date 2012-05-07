# encoding: UTF-8
class Frequency < ActiveRecord::Base
  has_many :habits

  # consts for the different frequencies
  VALUES = {
    '每天' => 1,
    '每周' => 2,
    '每周末' => 3,
    '每两周' => 4,
    '每月' => 5
  }

  #ASAP = 1
  #HALF_HOURLY = 2
  #HOURLY = 3
  #FOUR_TIMES_A_DAY = 4
  #TWICE_A_DAY = 5
  #DAILY = 6
  #WEEKLY = 7
  #FORTNIGHTLY = 8
  #MONTHLY = 9


end
