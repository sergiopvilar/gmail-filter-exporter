require 'json'
require 'erb'

data = JSON.parse(File.read('./data.json'))
entries = ''

data['rules'].each do |rule|

  ['words', 'from', 'subject'].each do |type|
    rule[type].each do |value|
      entries << ERB.new(File.read("./templates/#{rule['action']}.erb")).result(binding)
    end unless rule[type].nil?
  end

end

File.write('./filter.xml', ERB.new(File.read("./templates/main.erb")).result(binding))
