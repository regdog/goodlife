#class KindeditorImage < ActiveRecord::Base
#   before_create :randomize_file_name
#    has_attached_file :data
#
#    validates_attachment_content_type :data, :content_type => ['image/x-png', 'image/pjpeg']
#
#    private
#    def randomize_file_name
#
#      unless data_file_name.nil?
#        extension = File.extname(data_file_name).downcase
#        self.data.instance_write(:file_name, "#{ActiveSupport::SecureRandom.hex(16)}#{extension}")
#      end
#    end
#end
