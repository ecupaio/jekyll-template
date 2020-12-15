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
    cwebp: {
      target: {
        options: {
          q: 75
        },
        files: [{
          expand: true,
          cwd: 'img/',
          src: ['**/*.{png,jpg,jpeg}'],
          dest: 'img/'
        }]
      }
    },
    watch: {
      imagemin: {
        files: 'img/*.{png,jpg,gif,jpeg,svg}',
        tasks: ['newer:imagemin:target']
      },
      cwebp: {
        files: 'img/*.{png,jpg,jpeg}',
        tasks: ['newer:cwebp:target']
      },
      terser: {
        files: ['js/*.js',"js/min/!*.min.js"],
        tasks: ['newer:terser:target']
      },
      css: {
        files: ['scss/*.scss'],
        tasks: ['sass', 'postcss']
      }
    },
    terser: {
      options: {
        compress: true,
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
  grunt.loadNpmTasks('grunt-terser');
	grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-cwebp');
  grunt.registerTask('default', ['terser','sass', 'postcss','concurrent:target']);
};
