class Image < Upload
  has_attached_file :upload,
                    :styles => { :medium => "200x200>", :small => "150x150>", :thumb => "75x75#" },
                    :url => "/uploads/:class/:id/:style.:extension",
                    :path => ":rails_root/public/uploads/:class/:id/:style.:extension"

  validates_attachment_size :upload, :less_than => 2.megabytes
end