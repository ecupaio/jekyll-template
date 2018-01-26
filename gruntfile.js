module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		imagemin: {
			target: {
				files: [{
					expand: true,
					cwd: 'images/',
					src: ['**/*.{png,jpg,gif,jpeg,svg}'],
					dest: 'min_images/'
				}]
			}
		},
		watch: {
			imagemin: {
				files: 'images/*.{png,jpg,gif}',
				tasks: ['imagemin']
			},

		}
	});
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-imagemin');
	grunt.loadNpmTasks('grunt-newer');
	grunt.registerTask('default',['newer:imagemin:target', 'watch']);
};
