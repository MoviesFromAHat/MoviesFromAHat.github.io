jQuery.extend({
  getQueryParameters : function(str) {
      return (str || document.location.search).replace(/(^\?)/,'').split("&").map(function(n){return n = n.split("="),this[n[0]] = n[1],this;}.bind({}))[0];
  }
});

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

    function filterLength (length, movie) {
        if(_.isUndefined(length)){
            return true;
        }
        return movie.runtime <= length;
    }

    function filterGenre(genres, movie) {
        if(_.isUndefined(genres)){
            return true;
        }

        var genreList = genres.split(',');
        var match = true;

        _.forEach(genreList, function(genre) {
            if(!_.contains(movie.genres, genre)) {
                match = false;
            }
        });

        return match;
    }

    function sortMoviesByWatchDate (movie) {
        return Date.parse(movie.watchDate);
    }

    function sortMoviesByDate (movie) {
        return Date.parse(movie.year);
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

    function selectMovie (options) {
        var genres, length;

        if (options) {
            genres = options.genres;
            length = options.length;
        }

        var genreFilter = _.partial(filterGenre, genres);
        var lengthFilter = _.partial(filterLength, length);

        var unwatchedMovies = _(movies)
            .filter(lengthFilter)
            .filter(genreFilter)
            .filter(filterUnwatchedMovies)
            .value();

        var selection = _.sample(unwatchedMovies);
        var title = selection.title;
        var year = selection.year;
        var url = selection.url;
        var img = selection.img;
        var runtime = selection.runtime;

        var output = "This week's selection is: <br /><br />";
        output += "<a target='imdb' href='" + url + "'>";
        output += "<img src='img/" + img + "' /><br />";
        output += "<span>" + title + "<br /><span>(" + year + ", " + runtime + " min)</span></span></a>";

        $selectionWrapper.html(output);
    }

    function init (options) {

        var genres, length;

        if (options) {
            genres = options.genres;
            length = options.length;
        }

        // filtered & sorted movie lists
        var genreFilter = _.partial(filterGenre, genres);
        var lengthFilter = _.partial(filterLength, length);

        var watchedMovies = _(movies)
            .filter(lengthFilter)
            .filter(genreFilter)
            .filter(filterWatchedMovies)
            .sortBy(sortMoviesByWatchDate)
            .value();

        var unwatchedMovies = _(movies)
            .filter(lengthFilter)
            .filter(genreFilter)
            .filter(filterUnwatchedMovies)
            .sortBy(sortMoviesByDate)
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
            selectMovie({
                genres: genres,
                length: length
            });
            $(this).remove();
            $moviesContainer.remove();
            $('html').addClass("full");
        });

    }

    // Load movies and init

    $(d).ready(function() {
        $.getJSON('movies/movies.json', function(response) {
            var params = $.getQueryParameters();
            movies = response.movies;
            init({
                genres: params.genre,
                length: params.length
            });
        });
    });

})(document);
