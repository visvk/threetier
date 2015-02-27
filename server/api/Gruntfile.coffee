module.exports = (grunt) ->
	grunt.initConfig
		env:
			dev:
				NODE_ENV: 'development'
		mochaTest:
			test:
				options:
					reporter: 'spec'
					require: 'coffee-script'
					mocha: require('mocha')
				src: ['test/**/*_test.coffee']

	grunt.registerTask('test', ['env:dev', 'mochaTest']);

	grunt.loadNpmTasks('grunt-mocha-test');
	grunt.loadNpmTasks('grunt-env');
