# 生成 meta.yaml

require 'pathname'
require 'yaml'
require 'redcarpet'

dir = Pathname.new(File.dirname(__FILE__)).realpath

meta = {}
articles = []

Dir.foreach(dir) do |file|
  if file.match(/\.sac$/)
    f = File.read("#{dir}/#{file}")
    content = f.split("######")
    yaml = YAML.load(content[0])
    articles << {id: yaml[:article][:id], title: yaml[:article][:title], file: file}
  end
end

meta[:articles] = articles 

File.open("meta.yaml", 'w') do |f|
  f.puts meta.to_yaml
end
