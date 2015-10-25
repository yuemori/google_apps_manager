guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rubocop, all_on_start: false, cli: ['--format', 'clang', '-D'] do
  watch(%r{^lib/(.+)\.rb$})
end
