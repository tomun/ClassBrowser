Gem::Specification.new do |s|
	s.name        = 'ClassBrowser'
	s.version     = '1.0.1'
	s.date        = '2014-12-07'
	s.summary     = "A Ruby class browser"
	s.description = "ClassBrowser is an interactive class browser that lets you view the current ObjectSpace's class and module hierarchy."
	s.authors     = ["Tom Underhill"]
	s.email       = 'tunderhill@gmail.com'
	s.homepage    = 'http://www.tomunderhill.cu.cc'
	s.licenses    = ['MIT']
	s.files       = ["lib/ClassBrowser.rb", "lib/ClassNode.rb", "lib/HierarchyWriter.rb"]
	s.executables = ["ClassBrowser"]
end