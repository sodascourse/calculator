Pod::Spec.new do |spec|
  spec.name         = 'CalculatorCore'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'Apache License, version 2.0' }
  spec.homepage     = 'https://github.com/sodascourse/calculator'
  spec.authors      = { 'Tien-Che Tsai' => 'sodas@icloud.com' }
  spec.summary      = 'A core used to work for a simple calculator'
  spec.source       = { :git => 'https://github.com/sodascourse/calculator.git', :tag => "#{spec.version.to_s}" }
  spec.source_files = 'CalculatorCore/*.swift'
end
