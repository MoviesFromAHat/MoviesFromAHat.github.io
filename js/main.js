(function(d) {

    'use strict';

    // get DOM elements

    var movies;
    var $btn = $("#selectBtn");
    var $selectionWrapper = $("#selection");
    var $future = $("#movies");
    var $previous = $("#watched");

    // helper functions

    function filterWatchedMovies (movie) {
        return movie.length > 2;
    }

    function filterUnwatchedMovies (movie) {
        return movie.length === 2;
    }

    function sortMoviesByDate (movie) {
        return Date.parse(movie[2]);
    }

    function buildMovieListItem (movie) {
        var $li = $("<li>");
        var $anchor = $("<a>", {
            href: movie[1],
            target: 'imdb',
            title: movie[0],
            text: movie[0]
        });

        $li.append($anchor);

        if(movie.length > 2) {
            var $span = $("<span>", {
                text: " — " + movie[2]
            });
            $li.append($span);
        }

        return $li;
    }

    // event binding helper functions

    function selectMovie () {
        var unwatchedMovies = _(movies)
            .filter(filterUnwatchedMovies)
            .value();

        var selection = _.sample(unwatchedMovies);
        $selectionWrapper.html("This week's selection is: <br /><span><a target='imdb' href='" + selection[1] + "'>" + selection[0] + "</a></span>");
    }

    function init () {

        // filtered & sorted movie lists

        var watchedMovies = _(movies)
            .filter(filterWatchedMovies)
            .sortBy(sortMoviesByDate)
            .value();

        var unwatchedMovies = _(movies)
            .filter(filterUnwatchedMovies)
            .value();

        var allMovies = watchedMovies.concat(unwatchedMovies);

        // build dom structure

        _.each(allMovies, function(movie) {
            var $li = buildMovieListItem(movie);
            
            if(movie.length > 2) {
                $previous.append($li);
            } else {
                $future.append($li);
            }
        });

        // bind select button

        $btn.on('click', function () {
            $(this).html("Select a different movie.");
            $selectionWrapper.css("display", "block");
            selectMovie();
        });

    }

    // Load movies and init

    $(d).ready(function() {
        $.getJSON('movies/movies.json', function(response) {
            movies = _.map(response,function(movieData, movie) {
                if(_.isUndefined(movieData.watchDate)) {
                    return [movie, movieData.url];
                }
                return [movie, movieData.url, movieData.watchDate];
            });

            init();
        });
    });

})(document);
