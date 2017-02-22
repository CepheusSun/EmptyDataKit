#
# Be sure to run `pod lib lint EmptyDataKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EmptyDataKit'
  s.version          = '0.1.2'
  s.summary          = 'A simple and light framework helps you to add a friendly placeholder view when your UITableView or UICollectionView is empty with data'

  s.description      = <<-DESC
A simple and light framework helps you to add a friendly placeholder view when your UITableView or UICollectionView is empty with data. And EmptyDataKit is also very simple to use, you can only give the widget a property, and it will work.
DESC

  s.homepage         = 'https://github.com/CepheusSun/EmptyDataKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CepheusSun' => 'cd_sunyang@163.com' }
  s.source           = { :git => 'https://github.com/CepheusSun/EmptyDataKit.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'EmptyDataKit/Classes/*'

  s.dependency 'BlocksKit'
end
