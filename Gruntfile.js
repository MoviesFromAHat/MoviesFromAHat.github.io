module.exports = function (grunt){

    "use strict";

    require('load-grunt-tasks')(grunt);
    require('time-grunt')(grunt);

    grunt.initConfig({
        watch: {
            options:{
                nospawn: false
            },
            js: {
                files: ['js/{,*/}*.js'],
                tasks: ['jshint']
            },
        },
        connect: {
            server: {
                options: {
                    port: 8000,
                    open: true
                }
            }
        },
        jshint: {
            all: ['Gruntfile.js', 'js/**/*.js']
        }
    });

    grunt.registerTask('server', ['connect', 'watch']);
    grunt.registerTask('default', ['jshint','server']);

};
