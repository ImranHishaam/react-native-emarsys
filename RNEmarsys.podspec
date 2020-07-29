package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "RNEmarsys"
  s.version      = package['version']
  s.summary      = package['description']
  s.description  = <<-DESC
                  A bridge for the emarsys sdk
                   DESC
  s.homepage     = package['homepage']
  s.license      = package['license']
  s.author       = { "author" => "tech@leciseau.fr" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/LeCiseau/react-native-emarsys.git", :tag => "master" }
  s.source_files = "ios/*.{h,m}"
  s.requires_arc = true
  s.module_name  = "RNEmarsys"

  s.dependency "React"
  s.dependency "EmarsysSDK" , '~> 2.5.5'

end
