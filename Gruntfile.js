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
    });

    grunt.registerTask('server', function(){
        grunt.task.run([
            'connect',
            'watch'
        ]);
    });

    grunt.registerTask('default', ['server']);

    // log changes during watch
    grunt.event.on('watch', function(action, filepath, target) {
        grunt.log.writeln(target + ': ' + filepath + ' has ' + action);
    });

};
