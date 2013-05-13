Pod::Spec.new do |s|
  s.name          = 'JCSegueUserInfo'
  s.version       = '1.0.0'
  s.summary       = 'UIStoryboardSegues plus user information.'
  s.author        = { 'Jonathan Crooke' => 'joncrooke@gmail.com' }
  s.dependency      'libextobjc/EXTSwizzle', '0.2.5'
  s.homepage      = 'https://joncrooke@bitbucket.org/joncrooke/jcsegueuserinfo.git'
  s.license       = 'MIT'
  s.source        = {
    :git => 'https://joncrooke@bitbucket.org/joncrooke/jcsegueuserinfo.git',
    :branch => 'develop'
  }
  s.source_files = 'JCSegueUserInfo/*.{h,m}'
end
