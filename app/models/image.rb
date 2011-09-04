# Represents an image
#
class Image < Upload
  belongs_to :feat
  belongs_to :reward
  has_attached_file :upload, :style => { :small => "200x200", :thumb => "75x75" }

  validates_attachment_size :upload, :less_than => 3.megabytes

end
