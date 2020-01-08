Pod::Spec.new do |spec|

  spec.name         = "mecab-naist-jdic-utf-8"
  spec.version      = "0.1.0"
  spec.summary      = "NAIST JDIC in UTF-8 format, for use with Mecab."
  spec.description  = <<-DESC
  NAIST JDIC in UTF-8 format, for use with Mecab. A dictionary for morphological analysis of Japanese text.
                   DESC
  spec.homepage     = "https://github.com/shirakaba/iPhone-libmecab"
  spec.license      = { :type => "BSD", :file => "FILE_LICENSE" }
  spec.author             = { "Jamie Birch" => "14055146+shirakaba@users.noreply.github.com" }
  s.platforms      = { :ios => "10.3", :macos => "10.11" }
  spec.source       = { :git => "https://github.com/shirakaba/iPhone-libmecab.git", :tag => "#{spec.version}" }
  spec.resource_bundle = { "mecab-naist-jdic-utf-8" => "mecab-naist-jdic-utf-8/*" }

end
