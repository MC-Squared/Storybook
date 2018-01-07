guard :shell do
  watch(/storybook.rb/) { system('ruby storybook.rb') }
  watch(%r{^lib/.+/.+\.rb}) { system('ruby storybook.rb') }
end
