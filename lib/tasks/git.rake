namespace :git do
  desc "symlink to svn vendor dir."
  task :symlink do
    SVN_VENDOR_DIR = File.join(ENV["HOME"], "svn", "rubyagile", "vendor")
    unless File.exist? "#{RAILS_ROOT}/vendor/rails"
      ln_s "#{SVN_VENDOR_DIR}/rails", "#{RAILS_ROOT}/vendor/rails", :verbose => true
    end
    plugin_dirs = Dir.glob("#{SVN_VENDOR_DIR}/plugins/*").map { |dir| File.basename(dir)}
    target = plugin_dirs - ["open_id_authentication"]
    target.each do |plugin|
      unless File.exist? "#{RAILS_ROOT}/vendor/plugins/#{plugin}"
        ln_s "#{SVN_VENDOR_DIR}/plugins/#{plugin}", "#{RAILS_ROOT}/vendor/plugins/#{plugin}", :verbose => true
      end
    end
  end

  task :setup do
    cp "#{RAILS_ROOT}/config/database.yml.sample", "#{RAILS_ROOT}/config/database.yml", :verbose => true
    unless File.exist? "#{RAILS_ROOT}/log"
      mkdir "#{RAILS_ROOT}/log", :verboe => true
    end
  end
end
