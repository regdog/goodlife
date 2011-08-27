class Tag < ActiveRecord::Base
  def self.with_names(names)
    names.map do |name|
      Tag.find_or_create_by_name(name)
    end
  end

  def display_name
    name.titleize.gsub("E ", "e")
  end
end
