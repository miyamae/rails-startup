namespace :tmp do
  namespace :cache do
    # desc "Move all files and directories in tmp/cache to /tmp"
    task :flush do
      FileUtils.mv('tmp/cache', "/tmp/flushed_cache.#{Time.now.to_i}")
      FileUtils.mkdir('tmp/cache')
    end
  end
end
