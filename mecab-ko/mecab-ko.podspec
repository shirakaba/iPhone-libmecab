require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name         = package['name']
  s.version      = package['version']
  s.summary      = package['description']
  s.homepage     = "https://github.com/shirakaba/iPhone-libmecab"
  s.license      = { :type => "BSD", :file => "Assets/BSD" }
  s.author       = package['author']
  s.platforms    = { :ios => "10.3", :osx => "10.11" }
  s.source       = { :git => "https://github.com/shirakaba/iPhone-libmecab.git", :tag => "v#{s.version}" }
  s.public_header_files = 'Classes/mecab.h', 'ios/*.h'
  s.source_files = 'Classes/*.{cpp,h}', 'ios/*.{m,h}'
  # These are all entry points to Mecab that we don't want to include (because they lead to: "duplicate symbol_main").
  s.exclude_files = 'Classes/mecab-cost-train.cpp', 'Classes/mecab-dict-gen.cpp', 'Classes/mecab-dict-index.cpp', 'Classes/mecab-system-eval.cpp', 'Classes/mecab-test-gen.cpp'
  s.resources    = 'Assets/*'


  s.xcconfig = {
    'CLANG_ENABLE_OBJC_ARC' => 'NO',
    'GCC_PREPROCESSOR_DEFINITIONS' => 'HAVE_CONFIG_H MECAB_DEFAULT_RC=\"./\" DIC_VERSION=102',
    # I'm unsure how many of these below are necessary to specify, but they were in use in iPhone-libmecab.
    'GCC_DYNAMIC_NO_PIC' => 'NO',
    'GCC_MODEL_TUNING' => 'G5',
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
    'CLANG_CXX_LIBRARY' => 'compiler-default'
  }
  s.libraries  = 'iconv'
  s.info_plist = {
    'iPhone-libmecab authors' => 'Toshinori Watanabe; Matthew Long; Jamie Birch',
    'iPhone-libmecab special thanks' => 'Joseph Toronto',
    'mecab-ko authors' => 'Taku Kudo (taku@chasen.org); Yongwoon Lee (bibreen@gmail.com); Yungho Yu (mousegood@gmail.com)',
    'mecab-ko repo' => 'https://bitbucket.org/eunjeon/mecab-ko/src/master/',
    'mecab-ko version' => '0.996'
  }

end
