Pod::Spec.new do |s|
  s.name         = "MCLocalization"
  s.version      = "1.0.1"
  s.summary      = "Set of tools to simplify \"on the fly\" localization in iOS apps."

  s.description  = <<-DESC

There is the "standard" way Apple of localizing iOS apps using NSLocalizedString. It's versatile enought and you should stick to it unless you have good reasons not to.

I reuse the same localization files in an iOS app, on a web site and, possibly, in an app made for another platform. Advantage of JSON there is that libraries for handling JSON are available for just about any modern platform.

As a side advantage, it is much easier to create tools which do not rely on localizers being proficient with escaping C strings or use translation services not geared towards iOS app localization.

                   DESC

  s.homepage     = "https://github.com/Baglan/MCLocalization"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Baglan Dosmagambetov" => "baglan.dos@gmail.com" }
  s.social_media_url = "https://twitter.com/baglan"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Baglan/MCLocalization.git", :tag => "1.0.1" }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'
  s.requires_arc = true
end
