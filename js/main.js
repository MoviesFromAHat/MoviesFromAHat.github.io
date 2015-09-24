(function(d) {

    'use strict';

    // get DOM elements

    var movies;
    var $btn = $("#selectBtn");
    var $selectionWrapper = $("#selection");
    var $future = $("#movies");
    var $previous = $("#watched");
    var $moviesContainer = $(".previous-selection-container");
    var $selectionContainer = $(".selection-container");


    // helper functions

    function filterWatchedMovies (movie) {
        return !!movie.watchDate;
    }

    function filterUnwatchedMovies (movie) {
        return !movie.watchDate;
    }

    function sortMoviesByDate (movie) {
        return Date.parse(movie.watchDate);
    }

    function buildMovieListItem (movie) {
        var $li = $("<li>");
        var $anchor = $("<a>", {
            href: movie.url,
            target: 'imdb',
            title: movie.title,
            text: movie.title
        });

        $li.append($anchor);

        if(movie.watchDate) {
            var $span = $("<span>", {
                text: " — " + movie.watchDate
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
        var title = selection.title;
        var year = selection.year;
        var url = selection.url;
        $selectionWrapper.html("This week's selection is: <br /><span><a target='imdb' href='" + url + "'>" + title + " (" + year + ")</a></span>");
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
            
            if(movie.watchDate) {
                $previous.append($li);
            } else {
                $future.append($li);
            }
        });

        // bind select button

        $btn.on('click', function () {
            $(this).html("Select a different movie.");
            selectMovie();
            $(this).remove();
            $moviesContainer.remove();
            $('html').addClass("full");
        });

    }

    // Load movies and init

    $(d).ready(function() {
        $.getJSON('movies/movies.json', function(response) {
            movies = response.movies;
            init();
        });
    });

})(document);
