#= UUID filename for Paperclip
#
# class Article < ActiveRecord::Base
#   has_attached_file :image1
#   has_attached_file :image2
#   include PaperclipUuidFilename      # after has_attached_file
#   uuid_attached_file :image1, :image2

module PaperclipUuidFilename
  extend ActiveSupport::Concern

  included do
    before_post_process do
      randomize_paperclip_filename(*self.class.uuid_attached_file)
    end
  end

  module ClassMethods
    @@uuid_attached_file = {}
    def uuid_attached_file(*values)
      @@uuid_attached_file[self] ||= values
    end
  end

  def randomize_paperclip_filename(*names)
    names.each do |name|
      file_name = send("#{name}_file_name")
      content_type = send("#{name}_content_type")
      if file_name.present? && file_name.length != 40
        ext = {
          'image/jpeg' => '.jpg',
          'image/jpg' => '.jpg',
          'image/png' => '.png',
          'image/gif' => '.gif'}[content_type] rescue ''
        uuid = UUIDTools::UUID.random_create
        self.send(name).instance_write(:file_name, "#{uuid}#{ext}")
      end
    end
  end

end
