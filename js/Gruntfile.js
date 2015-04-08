(function() {
  module.exports = function(grunt) {
    grunt.initConfig({
      env: {
        dev: {
          NODE_ENV: 'development',
          PORT: 8080
        },
        simple: {
          NODE_ENV: 'development',
          PORT: 8080
        }
      },
      mochaTest: {
        test: {
          options: {
            reporter: 'spec',
            require: 'coffee-script',
            mocha: require('mocha')
          },
          src: ['test/**/*_test.coffee']
        }
      },
      pkg: grunt.file.readJSON('package.json'),
      coffee: {
        coffee_to_js: {
          expand: true,
          flatten: false,
          cwd: __dirname + "/",
          src: ["*.coffee", "tier_ui/*.coffee", "tier_business/*.coffee", "tier_data/*.coffee", "lib/*.coffee"],
          dest: 'js/',
          ext: ".js"
        }
      },
      copy: {
        main: {
          expand: true,
          flatten: false,
          src: ["tier_ui/app/**"],
          dest: "js/"
        }
      }
    });
    grunt.loadNpmTasks('grunt-mocha-test');
    grunt.loadNpmTasks('grunt-env');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.registerTask('test', ['env:dev', 'mochaTest']);
    grunt.registerTask('test_simple', ['env:simple', 'mochaTest']);
    return grunt.registerTask('compile', ['coffee', 'copy']);
  };

}).call(this);
