Pod::Spec.new do |s|

  s.name         = "TetrominoKit"
  s.version      = "0.0.1"
  s.summary      = "Cross platform implementation for classic tetromino game."

  s.description  = <<-DESC
  Cross platform implementation for classic tetromino game as a framework.
                   DESC
  s.author       = { "Christopher Reitz" => "christopher@reitz.re" }
  s.homepage     = "https://github.com/Stitch7/Tetromino"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.source       = { :git => "https://github.com/Stitch7/Tetromino.git" }
  #s.source_files = "**/*.swift"
  s.source_files = "Source/*.swift"

  s.platform     = :ios, "9.0"

end
