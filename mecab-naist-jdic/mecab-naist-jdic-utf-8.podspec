require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.homepage     = "https://github.com/shirakaba/iPhone-libmecab"
  s.license      = { :type => "BSD", :file => "mecab-naist-jdic-utf-8/COPYING" }
  s.author       = package['author']
  s.platforms    = { :ios => "10.3", :macos => "10.11" }
  s.source       = { :git => "https://github.com/shirakaba/iPhone-libmecab.git", :tag => "v#{s.version}" }
  s.resource_bundle = { "mecab-naist-jdic-utf-8" => "mecab-naist-jdic-utf-8/*" }

end
