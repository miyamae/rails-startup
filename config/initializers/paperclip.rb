if ENV['uploads_storage'] == 's3'
  Paperclip::Attachment.default_options[:storage] = 's3'
  Paperclip::Attachment.default_options[:s3_credentials] = {
    :bucket => ENV['uploads_s3_bucket'],
    :access_key_id => ENV['uploads_aws_access_key_id'],
    :secret_access_key => ENV['uploads_aws_secret_access_key']
  }
  Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  Paperclip::Attachment.default_options[:s3_host_name] = ENV['uploads_s3_host_name']
  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
end
if ENV['uploads_path'].present?
  Paperclip::Attachment.default_options[:path] = ENV['uploads_path']
end
