require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.homepage     = "https://github.com/shirakaba/iPhone-libmecab"
  s.license      = { :type => "BSD", :file => "Assets/BSD" }
  s.author       = package['author']
  s.platforms    = { :ios => "10.3", :macos => "10.11" }
  s.source       = { :git => "https://github.com/shirakaba/iPhone-libmecab.git", :tag => "v#{s.version}" }
  # s.public_header_files = 'Classes/mecab.h', 'Classes/MecabObjC.h', 'Classes/Node.h'
  s.source_files = 'Classes/*.{c,cpp,mm}' #, 'Classes/*.{h}'
  s.resources    = 'Assets/*'
  s.xcconfig = {
    'GCC_DYNAMIC_NO_PIC' => 'NO',
    'GCC_MODEL_TUNING' => 'G5',
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
    'CLANG_CXX_LIBRARY' => 'compiler-default'
  }
  # s.library      = 'c++'
  # s.static_framework = true
  s.frameworks    = 'Foundation'
  s.libraries    = 'stdc++', 'iconv', 'mecab'
  s.info_plist = {
    'mecab-ko authors' => 'Taku Kudo (taku@chasen.org); Yongwoon Lee (bibreen@gmail.com); Yungho Yu (mousegood@gmail.com)',
    'mecab-ko repo' => 'https://bitbucket.org/eunjeon/mecab-ko/src/master/',
    'mecab-ko version' => '0.996'
  }

end
