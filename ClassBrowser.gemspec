Gem::Specification.new do |s|
	s.name        = 'ClassBrowser'
	s.version     = '1.0.4'
	s.date        = '2014-12-11'
	s.summary     = "A Ruby class browser"
	s.description = "ClassBrowser is an interactive class browser that lets you view the current ObjectSpace's class and module hierarchy."
	s.authors     = ["Tom Underhill"]
	s.email       = 'tunderhill@gmail.com'
	s.homepage    = 'https://github.com/tomun/ClassBrowser'
	s.licenses    = ['MIT']
	s.files       = ["lib/class_browser.rb", "lib/class_node.rb", "lib/hierarchy_writer.rb"]
	s.executables = ["ClassBrowser"]
end
