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
      },
      css: {
        files: ['scss/*.scss'],
        tasks: ['sass', 'postcss', 'copy:mincss']
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
    sass: {
      options: {
        compress: false
      },
      scss: {
        files: [{
          expand: true,
          cwd: 'scss/',
          src: ['*.scss','!_*.scss'],
          dest: 'css/',
          ext: '.min.css'
        }]
      }    
    },
    postcss: {
      options: {
        processors: [
          require('autoprefixer')({overrideBrowserslist: ['last 2 versions']}),
          require('csswring')()
        ]
      },
      mincss: {
        files: [{
          expand: true,
          cwd: 'css/',
          src: ['*.min.css'],
          dest: 'css/'
        }]
      }
    },
    copy: {
      mincss: [{
        expand: true,
        cwd: 'css/',
        src: ['*.min.css'],
        dest: '_site/css/'
      }]
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
  grunt.loadNpmTasks('grunt-contrib-sass'); 
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-postcss');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-newer');
  grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-shell');
  grunt.registerTask('default', ['uglify','sass','concurrent:target']);
};
