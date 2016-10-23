require 'json'
require 'erb'

data = JSON.parse(File.read('./data.json'))
entries = ''

data['rules'].each do |rule|

  rule['words'].each do |value|
    type = 'word'
    entries << ERB.new(File.read("./templates/#{rule['action']}.erb")).result(binding)
  end unless rule['words'].nil?

  rule['from'].each do |value|
    type = 'from'
    entries << ERB.new(File.read("./templates/#{rule['action']}.erb")).result(binding)
  end unless rule['from'].nil?

  rule['subject'].each do |value|
    type = 'subject'
    entries << ERB.new(File.read("./templates/#{rule['action']}.erb")).result(binding)
  end unless rule['subject'].nil?


end

File.write('./filter.xml', ERB.new(File.read("./templates/main.erb")).result(binding))
