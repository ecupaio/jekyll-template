module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    imagemin: {
      target: {
        files: [{
          expand: true,
          cwd: 'img/',
          src: ['**/*.{png,jpg,gif,jpeg,svg}'],
          dest: 'img/'
        }]
      }
    },
    watch: {
      imagemin: {
        files: 'img/*.{png,jpg,gif}',
        tasks: ['imagemin']
      },
      uglify: {
        files: ['js/*.js',"js/min/!*.min.js"],
        tasks: ['newer:uglify:target']
      }
    },
    uglify: {
      options: {
        mangle: false
      },
      target: {
        files: [{
          expand: true,
          cwd: "js/",
          src: ["*.js", "!*.min.js"],
          dest: "js/min/",
          ext: ".min.js"
        }]
      }
    },
    shell: {
      jekyllServe: {
        command: 'bundle exec jekyll serve --livereload '
      }
    },
		concurrent: {
      target: ['shell:jekyllServe','watch'],
			options: {
				logConcurrentOutput: true
			}
		}
  });
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-newer');
  grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-shell');
  grunt.registerTask('default', ['uglify','concurrent:target']);
};
