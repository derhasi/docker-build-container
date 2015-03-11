module.exports = function (grunt) {

  require('time-grunt')(grunt);

  grunt.initConfig({
    clean: {
      compass: "css-compass",
      sass: "css-sass"
    },
    compass: {
      dist: {
        options: {
          sassDir: 'sass',
          cssDir: 'css-compass',
          cacheDir: '.compass/sass-cache',
          require: [
            'compass-normalize',
            'rgbapng',
            'toolkit',
            'breakpoint',
            'sass-globbing',
            'singularitygs'
          ]
        }
      }
    },
    sass: {
      dist: {
        options: {
          compass: true,
          sourcemap: 'none',
          cacheLocation: '.sass/sass-cache',
          require: [
            'compass',
            'compass-normalize',
            'rgbapng',
            'toolkit',
            'breakpoint',
            'sass-globbing',
            'singularitygs'
          ]
        },
        files: [
          {
            expand: true,
            cwd: 'sass',
            src: ['**/*.scss'],
            dest: 'css-sass',
            ext: '.css',
            extDot: 'last'
          }
        ]
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-sass');

  // Default task(s).
  grunt.registerTask('default', [
    'clean',
    'compass',
    'sass',
  ]);

};