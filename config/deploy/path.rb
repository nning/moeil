before 'bundle:install', 'env:path'

namespace :env do
  desc 'Add Gem.bindir to PATH.'
  task :path do
    bindir = capture 'ruby -e "puts Gem.bindir"'
    default_environment['PATH'] = "${PATH}:#{bindir}"
  end
end
