Pod::Spec.new do |s|
  s.name          = 'JCSegueUserInfo'
  s.version       = '1.0'
  s.summary       = 'Programmatic UIStoryboardSegue - the missing (data) link.'
  s.author        = { 'Jonathan Crooke' => 'joncrooke@gmail.com' }
  s.dependency      'libextobjc/EXTSwizzle', '0.2.5'
  s.dependency      'ObjcAssociatedObjectHelpers', '1.1'
  s.homepage      = 'https://joncrooke@bitbucket.org/joncrooke/jcsegueuserinfo.git'
  s.license       = 'MIT'
  s.platform      = :ios, '5.0'
  s.requires_arc  = true
  s.source        = {
    :git => 'https://github.com/itsthejb/JCSegueUserInfo.git',
    :tag => "v" + s.version.to_s
  }
  s.source_files = 'JCSegueUserInfo/*.{h,m}'
end
