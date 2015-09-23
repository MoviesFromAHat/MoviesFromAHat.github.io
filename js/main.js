(function(w, d) {

    var init = function(movies) {

        var unwatchedMovies = _.filter(movies,function(movie){
              return movie.length === 2;
        });

        var selectionWrapper = document.getElementById("selection");
        var btn = document.getElementById("selectBtn");

        var selectMovie = function () {
            var selection = _.sample(unwatchedMovies);
            selectionWrapper.innerHTML = "This week's selection is: <br /><span><a target='imdb' href='" + selection[1] + "'>" + selection[0] + "</a></span>";
        };

        btn.onclick = function () {
            btn.innerHTML = "Select a different Movie";
            selectionWrapper.style.display = "block";
            selectMovie();
        }

        var list = document.getElementById("movies"),
            watched = document.getElementById("watched");

        var watchedList = _.filter(movies, function(movie){
           return (movie.length > 2);
        });

        watchedList = _.sortBy(watchedList, function(m){
           return Date.parse(m[2]);
        });

        var unwatchedList = _.filter(movies, function(movie){
           return !(movie.length > 2);
        });

        var sorted = watchedList.concat(unwatchedList);

        _.each(sorted, function(movie) {
            var a = document.createElement('a');
            var linkText = document.createTextNode(movie[0]);
            a.appendChild(linkText);
            a.title = movie[0];
            a.href = movie[1];
            a.target ="imdb";
            var li = document.createElement('li');
            li.appendChild(a);
            if(movie.length > 2) {
                var dateEl = document.createElement('span');
                var date = document.createTextNode(' —  ' + movie[2]);
                dateEl.appendChild(date);
                li.appendChild(dateEl);
            }
            if(movie.length > 3) {
                var stars = ' — ';
                for(var i = 0; i < movie[3]; i++) {
                     stars += '★';
                }
                for(var i = 0; i < 5 - movie[3]; i++) {
                    stars += '☆';
                }
                var starsEl = document.createTextNode(stars);

                li.appendChild(starsEl);
            }
            if(movie.length > 2) {
                watched.appendChild(li);
            } else {
                list.appendChild(li);
            }
        });

    };

    // Load movies and init
    $(d).ready(function() {
        $.getJSON('movies/movies.json', function(response) {
            var movies = _.map(response,function(movieData, movie) {
                if(_.isUndefined(movieData.watchDate)) {
                    return [movie, movieData.url];
                }
                return [movie, movieData.url, movieData.watchDate];
            });
            init(movies);
        });
    });

})(window, document);
