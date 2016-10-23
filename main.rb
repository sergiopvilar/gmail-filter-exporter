require 'json'
require 'erb'

data = JSON.parse(File.read('./data.json'))
entries = ''

data['rules'].each do |rule|
  rules = []
  rules = rule['words'] unless rule['words'].nil?
  rule['from'].each { |from| rules << "from:#{from}" } unless rule['from'].nil?
  rule['subject'].each { |subject| rules << "subject:#{subject}" } unless rule['subject'].nil?
  entries << ERB.new(File.read("./templates/#{rule['action']}.erb")).result(binding)
end

File.write('./filter.xml', ERB.new(File.read("./templates/main.erb")).result(binding))
