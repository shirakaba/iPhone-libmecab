require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.homepage     = "https://github.com/shirakaba/iPhone-libmecab"
  s.license      = { :type => "Apache", :file => "bundleContents/COPYING" }
  s.author       = package['author']
  s.platforms    = { :ios => "10.3", :macos => "10.11" }
  s.source       = { :git => "https://github.com/shirakaba/iPhone-libmecab.git", :tag => "v#{s.version}" }
  s.resource_bundle = { "mecab-ko-dic-utf-8" => "bundleContents/*" }
  s.info_plist = {
    'mecab-ko-dic authors' => 'Yongwoon Lee (bibreen@gmail.com); Yungho Yu (mousegood@gmail.com)',
    'mecab-ko-dic repo' => 'https://bitbucket.org/eunjeon/mecab-ko-dic',
    'mecab-ko-dic version' => '2.1.1'
  }

end
