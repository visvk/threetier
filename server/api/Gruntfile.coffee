module.exports = (grunt) ->
	grunt.initConfig
		env:
			dev:
				NODE_ENV: 'development'
				PORT: 3000
			simple:
				NODE_ENV: 'development'
				PORT: 3002
		mochaTest:
			test:
				options:
					reporter: 'spec'
					require: 'coffee-script'
					mocha: require('mocha')
				src: ['test/**/*_test.coffee']

	grunt.registerTask('test', ['env:dev', 'mochaTest']);
	grunt.registerTask('test_simple', ['env:simple', 'mochaTest']);

	grunt.loadNpmTasks('grunt-mocha-test');
	grunt.loadNpmTasks('grunt-env');
