require 'json'
require 'erb'

data = JSON.parse(File.read('./data.json'))
entries = ''

data['rules'].each do |rule|
  rows = []
  rows = rule['words'] unless rule['words'].nil?
  rule['from'].each { |from| rows << "from:#{from}" } unless rule['from'].nil?
  rule['subject'].each { |subject| rows << "subject:#{subject}" } unless rule['subject'].nil?
  rows.each_slice(30).to_a.each do |rules|
    entries << ERB.new(File.read("./templates/#{rule['action']}.erb")).result(binding)
  end
end

File.write('./filter.xml', ERB.new(File.read("./templates/main.erb")).result(binding))
