module MovieList exposing (movies)

import Movie exposing (Movie, WatchState(..))
import Genre
import Time.Date exposing (date)


movies : List Movie
movies =
    [ { title = "Spring"
      , url = "http://www.imdb.com/title/tt3395184"
      , img = "spring.jpg"
      , year = 2014
      , runtime = 109
      , genres = [ "comedy", "horror", "romance" ]
      , watched = Watched (date 2017 10 5)
      , nsfw = True
      }
    , { title = "Cool Hand Luke"
      , url = "http://www.imdb.com/title/tt0061512"
      , img = "cool-hand-luke.jpg"
      , year = 1967
      , runtime = 126
      , genres = [ "crime", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Hidden"
      , url = "http://www.imdb.com/title/tt0093185/"
      , img = "the-hidden.jpg"
      , year = 1987
      , runtime = 96
      , genres = [ "action", "crime", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Tombstone"
      , url = "http://www.imdb.com/title/tt0108358/"
      , img = "tombstone.jpg"
      , year = 1993
      , runtime = 130
      , genres = [ "action", "drama", "history", "western" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Collateral"
      , url = "http://www.imdb.com/title/tt0369339/"
      , img = "collateral.jpg"
      , year = 2004
      , runtime = 120
      , genres = [ "crime", "drama", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Roman Holiday"
      , url = "http://www.imdb.com/title/tt0046250/"
      , img = "roman-holiday.jpg"
      , year = 1953
      , runtime = 118
      , genres = [ "comedy", "romance" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Magnificent Seven"
      , url = "http://www.imdb.com/title/tt0054047/"
      , img = "the-magnificent-seven.jpg"
      , year = 1960
      , runtime = 128
      , genres = [ "action", "adventure", "western" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Sanjuro"
      , url = "http://www.imdb.com/title/tt0056443/"
      , img = "sanjuro.jpg"
      , year = 1962
      , runtime = 96
      , genres = [ "action", "drama", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Birds"
      , url = "http://www.imdb.com/title/tt0056869/"
      , img = "the-birds.jpg"
      , year = 1963
      , runtime = 119
      , genres = [ "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb"
      , url = "http://www.imdb.com/title/tt0057012/"
      , img = "dr-strangelove.jpg"
      , year = 1964
      , runtime = 95
      , genres = [ "comedy", "war" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "A Clockwork Orange"
      , url = "http://www.imdb.com/title/tt0066921/"
      , img = "clockwork-orange.jpg"
      , year = 1971
      , runtime = 136
      , genres = [ "crime", "drama", "sci-fi" ]
      , watched = Unwatched
      , nsfw = True
      }
    , { title = "The Andromeda Strain"
      , url = "http://www.imdb.com/title/tt0066769/"
      , img = "andromeda-strain.jpg"
      , year = 1971
      , runtime = 131
      , genres = [ "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Enter the Dragon"
      , url = "http://www.imdb.com/title/tt0070034/"
      , img = "enter-the-dragon.jpg"
      , year = 1973
      , runtime = 102
      , genres = [ "action", "crime", "drama" ]
      , watched = Watched (date 2017 11 30)
      , nsfw = False
      }
    , { title = "The Sting"
      , url = "http://www.imdb.com/title/tt0070735/"
      , img = "the-sting.jpg"
      , year = 1973
      , runtime = 129
      , genres = [ "comedy", "crime", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Westworld"
      , url = "http://www.imdb.com/title/tt0070909/"
      , img = "westworld.jpg"
      , year = 1973
      , runtime = 88
      , genres = [ "action", "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Death Race 2000"
      , url = "http://www.imdb.com/title/tt0072856/"
      , img = "death-race-2000.jpg"
      , year = 1975
      , runtime = 80
      , genres = [ "action", "comedy", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Monty Python and the Holy Grail"
      , url = "http://www.imdb.com/title/tt0071853/"
      , img = "monty-pythond-holy-grail.jpg"
      , year = 1975
      , runtime = 91
      , genres = [ "adventure", "comedy", "fantasy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Jerk"
      , url = "http://www.imdb.com/title/tt0079367/"
      , img = "the-jerk.jpg"
      , year = 1979
      , runtime = 94
      , genres = [ "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Super Fuzz"
      , url = "http://www.imdb.com/title/tt0082924/"
      , img = "super-fuzz.jpg"
      , year = 1980
      , runtime = 97
      , genres = [ "action", "comedy", "fantasy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Natural"
      , url = "http://www.imdb.com/title/tt0087781/"
      , img = "the-natural.jpg"
      , year = 1984
      , runtime = 138
      , genres = [ "drama", "sport" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Adventures of Buckaroo Banzai Across the 8th Dimension"
      , url = "http://www.imdb.com/title/tt0086856/"
      , year = 1984
      , img = "buckaroo-banzai.jpg"
      , runtime = 103
      , genres = [ "adventure", "comedy", "romance" ]
      , watched = Watched (date 2015 5 20)
      , nsfw = False
      }
    , { title = "Better Off Dead…"
      , url = "http://www.imdb.com/title/tt0088794/"
      , img = "better-off-dead.jpg"
      , year = 1985
      , runtime = 97
      , genres = [ "comedy", "romance" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Brazil"
      , url = "http://www.imdb.com/title/tt0088846/"
      , img = "brazil.jpg"
      , year = 1985
      , runtime = 132
      , genres = [ "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Last Dragon"
      , url = "http://www.imdb.com/title/tt0089461/"
      , img = "the-last-dragon.jpg"
      , year = 1985
      , runtime = 109
      , genres = [ "action", "comedy", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Spies Like Us"
      , url = "http://www.imdb.com/title/tt0090056/"
      , img = "spies-like-us.jpg"
      , year = 1985
      , runtime = 102
      , genres = [ "adventure", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Big Trouble in Little China"
      , url = "http://www.imdb.com/title/tt0090728/"
      , img = "big-trouble-little-china.jpg"
      , year = 1986
      , runtime = 99
      , genres = [ "action", "adventure", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Golden Child"
      , url = "http://www.imdb.com/title/tt0091129/"
      , img = "the-golden-child.jpg"
      , year = 1986
      , runtime = 94
      , genres = [ "action", "adventure", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Evil Dead II"
      , url = "http://www.imdb.com/title/tt0092991/"
      , img = "evil-dead-2.jpg"
      , year = 1987
      , runtime = 84
      , genres = [ "comedy", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Raising Arizona"
      , url = "http://www.imdb.com/title/tt0093822/"
      , img = "raising-arizona.jpg"
      , year = 1987
      , runtime = 94
      , genres = [ "comedy", "crime", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Akira"
      , url = "http://www.imdb.com/title/tt0094625/"
      , img = "akira.jpg"
      , year = 1988
      , runtime = 124
      , genres = [ "animation", "action", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Serpent and the Rainbow"
      , url = "http://www.imdb.com/title/tt0096071/"
      , img = "serpent-rainbow.jpg"
      , year = 1988
      , runtime = 98
      , genres = [ "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "They Live"
      , url = "http://www.imdb.com/title/tt0096256/"
      , img = "they-live.jpg"
      , year = 1988
      , runtime = 93
      , genres = [ "action", "horror", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Willow"
      , url = "http://www.imdb.com/title/tt0096446/"
      , img = "willow.jpg"
      , year = 1988
      , runtime = 126
      , genres = [ "action", "adventure", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "UHF"
      , url = "http://www.imdb.com/title/tt0098546/"
      , img = "uhf.jpg"
      , year = 1989
      , runtime = 97
      , genres = [ "comedy" ]
      , watched = Watched (date 2016 1 14)
      , nsfw = False
      }
    , { title = "Nothing But Trouble"
      , url = "http://www.imdb.com/title/tt0102558/"
      , img = "nothing-but-trouble.jpg"
      , year = 1991
      , runtime = 94
      , genres = [ "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Army of Darkness"
      , url = "http://www.imdb.com/title/tt0106308/"
      , img = "army-of-darkness.jpg"
      , year = 1992
      , runtime = 81
      , genres = [ "comedy", "fantasy", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Captain Ron"
      , url = "http://www.imdb.com/title/tt0103924/"
      , img = "captain-ron.jpg"
      , year = 1992
      , runtime = 90
      , genres = [ "adventure", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Meteor Man"
      , url = "http://www.imdb.com/title/tt0107563/"
      , img = "meteor-man.jpg"
      , year = 1993
      , runtime = 100
      , genres = [ "action", "comedy", "fantasy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Stargate"
      , url = "http://www.imdb.com/title/tt0111282/"
      , img = "stargate.jpg"
      , year = 1994
      , runtime = 121
      , genres = [ "action", "adventure", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Congo"
      , url = "http://www.imdb.com/title/tt0112715/"
      , img = "congo.jpg"
      , year = 1995
      , runtime = 109
      , genres = [ "action", "adventure", "mystery" ]
      , watched = Watched (date 2016 7 28)
      , nsfw = False
      }
    , { title = "Twelve Monkeys"
      , url = "http://www.imdb.com/title/tt0114746/"
      , img = "12-monkeys.jpg"
      , year = 1995
      , runtime = 129
      , genres = [ "mystery", "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Usual Suspects"
      , url = "http://www.imdb.com/title/tt0114814/"
      , img = "usual-suspects.jpg"
      , year = 1995
      , runtime = 106
      , genres = [ "crime", "drama", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Breakdown"
      , url = "http://www.imdb.com/title/tt0118771/"
      , img = "breakdown.jpg"
      , year = 1997
      , runtime = 93
      , genres = [ "crime", "drama", "mystery" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Contact"
      , url = "http://www.imdb.com/title/tt0118884/"
      , img = "contact.jpg"
      , year = 1997
      , runtime = 150
      , genres = [ "drama", "mystery", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "L.A. Confidential"
      , url = "http://www.imdb.com/title/tt0119488/"
      , img = "l-a-confidential.jpg"
      , year = 1997
      , runtime = 138
      , genres = [ "crime", "drama", "mystery" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Suicide Kings"
      , url = "http://www.imdb.com/title/tt0120241/"
      , img = "suicide-kings.jpg"
      , year = 1997
      , runtime = 106
      , genres = [ "comedy", "drama", "mystery" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Dark City"
      , url = "http://www.imdb.com/title/tt0118929/"
      , img = "dark-city.jpg"
      , year = 1998
      , runtime = 100
      , genres = [ "drama", "fantasy", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Fallen"
      , url = "http://www.imdb.com/title/tt0119099/"
      , img = "fallen.jpg"
      , year = 1998
      , runtime = 124
      , genres = [ "action", "crime", "drama", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Negotiator"
      , url = "http://www.imdb.com/title/tt0120768/"
      , img = "negotiater.jpg"
      , year = 1998
      , runtime = 140
      , genres = [ "action", "crime", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Ronin"
      , url = "http://www.imdb.com/title/tt0122690/"
      , img = "ronin.jpg"
      , year = 1998
      , runtime = 122
      , genres = [ "action", "adventure", "crime" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Rushmore"
      , url = "http://www.imdb.com/title/tt0128445/"
      , img = "rushmore.jpg"
      , year = 1998
      , runtime = 93
      , genres = [ "comedy", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "What Dreams May Come"
      , url = "http://www.imdb.com/title/tt0120889/"
      , img = "what-dreams-may-come.jpg"
      , year = 1998
      , runtime = 113
      , genres = [ "drama", "fantasy", "romance" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Who Am I?"
      , url = "http://www.imdb.com/title/tt0127357/"
      , img = "who-am-i.jpg"
      , year = 1998
      , runtime = 108
      , genres = [ "action", "adventure", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Being John Malkovich"
      , url = "http://www.imdb.com/title/tt0120601/"
      , img = "malkovich.jpg"
      , year = 1999
      , runtime = 112
      , genres = [ "comedy", "drama", "fantasy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Boondock Saints"
      , url = "http://www.imdb.com/title/tt0144117/"
      , img = "boondock-saints.jpg"
      , year = 1999
      , runtime = 108
      , genres = [ "action", "crime", "thriller" ]
      , watched = Unwatched
      , nsfw = True
      }
    , { title = "Finding Forrester"
      , url = "http://www.imdb.com/title/tt0181536/"
      , img = "finding-forrester.jpg"
      , year = 2000
      , runtime = 136
      , genres = [ "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Men of Honor"
      , url = "http://www.imdb.com/title/tt0203019/"
      , img = "men-of-honor.jpg"
      , year = 2000
      , runtime = 129
      , genres = [ "biography", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Sexy Beast"
      , url = "http://www.imdb.com/title/tt0203119/"
      , year = 2000
      , img = "sexy-beast.jpg"
      , runtime = 89
      , genres = [ "crime", "thriller" ]
      , watched = Watched (date 2015 9 3)
      , nsfw = False
      }
    , { title = "Snatch."
      , url = "http://www.imdb.com/title/tt0208092/"
      , img = "snatch.jpg"
      , year = 2000
      , runtime = 102
      , genres = [ "comedy", "crime" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Frailty"
      , url = "http://www.imdb.com/title/tt0264616/"
      , img = "fraility.jpg"
      , year = 2001
      , runtime = 100
      , genres = [ "crime", "drama", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "K-Pax"
      , url = "http://www.imdb.com/title/tt0272152/"
      , img = "kpax.jpg"
      , year = 2001
      , runtime = 120
      , genres = [ "drama", "sci-fi" ]
      , watched = Watched (date 2016 9 30)
      , nsfw = False
      }
    , { title = "Mulholland Drive"
      , url = "http://www.imdb.com/title/tt0166924/"
      , img = "mulholland-drive.jpg"
      , year = 2001
      , runtime = 147
      , genres = [ "drama", "mystery", "thriller", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Death to Smoochy"
      , url = "http://www.imdb.com/title/tt0266452/"
      , year = 2002
      , img = "death-to-smoochy.jpg"
      , runtime = 109
      , genres = [ "comedy", "crime", "drama" ]
      , watched = Watched (date 2014 10 10)
      , nsfw = False
      }
    , { title = "Equilibrium"
      , url = "http://www.imdb.com/title/tt0238380/"
      , img = "equilibrium.jpg"
      , year = 2002
      , runtime = 107
      , genres = [ "action", "drama", "sci-fi" ]
      , watched = Watched (date 2016 4 27)
      , nsfw = False
      }
    , { title = "Gangs of New York"
      , url = "http://www.imdb.com/title/tt0217505/"
      , img = "gangs-new-york.jpg"
      , year = 2002
      , runtime = 167
      , genres = [ "crime", "drama", "history" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Pianist"
      , url = "http://www.imdb.com/title/tt0253474/"
      , img = "pianist.jpg"
      , year = 2002
      , runtime = 150
      , genres = [ "biography", "drama", "war" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Open Water"
      , url = "http://www.imdb.com/title/tt0374102/"
      , img = "open-water.jpg"
      , year = 2003
      , runtime = 79
      , genres = [ "biography", "drama", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Ong-bak"
      , url = "http://www.imdb.com/title/tt0368909/"
      , year = 2003
      , img = "ong-bak.jpg"
      , runtime = 105
      , genres = [ "action", "thriller" ]
      , watched = Watched (date 2014 12 5)
      , nsfw = False
      }
    , { title = "Primer"
      , url = "http://www.imdb.com/title/tt0390384/"
      , img = "primer.jpg"
      , year = 2004
      , runtime = 77
      , genres = [ "drama", "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Æon Flux"
      , url = "http://www.imdb.com/title/tt0402022/"
      , img = "aeon-flux.jpg"
      , year = 2005
      , runtime = 93
      , genres = [ "action", "sci-fi" ]
      , watched = Watched (date 2018 2 22)
      , nsfw = False
      }
    , { title = "The Descent"
      , url = "http://www.imdb.com/title/tt0435625/"
      , img = "descent.jpg"
      , year = 2005
      , runtime = 99
      , genres = [ "adventure", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Derailed"
      , url = "http://www.imdb.com/title/tt0398017/"
      , img = "derailed.jpg"
      , year = 2005
      , runtime = 108
      , genres = [ "drama", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Brick"
      , url = "http://www.imdb.com/title/tt0393109/"
      , img = "brick.jpg"
      , year = 2005
      , runtime = 110
      , genres = [ "crime", "drama", "mystery" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Lucky Number Slevin"
      , url = "http://www.imdb.com/title/tt0425210/"
      , img = "lucky-number-slevin.jpg"
      , year = 2006
      , runtime = 110
      , genres = [ "crime", "drama", "mystery" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Prestige"
      , url = "http://www.imdb.com/title/tt0482571/"
      , img = "prestige.jpg"
      , year = 2006
      , runtime = 130
      , genres = [ "drama", "mystery", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Stranger Than Fiction"
      , url = "http://www.imdb.com/title/tt0420223/"
      , img = "stranger-than-fiction.jpg"
      , year = 2006
      , runtime = 113
      , genres = [ "comedy", "drama", "fantasy" ]
      , watched = Watched (date 2017 10 26)
      , nsfw = False
      }
    , { title = "Hot Fuzz"
      , url = "http://www.imdb.com/title/tt0425112/"
      , img = "hot-fuzz.jpg"
      , year = 2007
      , runtime = 121
      , genres = [ "action", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "I Am Legend (Director’s Cut)"
      , url = "http://www.imdb.com/title/tt0480249/"
      , img = "i-am-legend.jpg"
      , year = 2007
      , runtime = 101
      , genres = [ "drama", "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Mongol: The Rise of Genghis Khan"
      , url = "http://www.imdb.com/title/tt0416044/"
      , img = "mongol.jpg"
      , year = 2007
      , runtime = 126
      , genres = [ "adventure", "biography", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Timecrimes"
      , url = "http://www.imdb.com/title/tt0480669/"
      , img = "timecrimes.jpg"
      , year = 2007
      , runtime = 92
      , genres = [ "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Shoot 'Em Up"
      , url = "http://www.imdb.com/title/tt0465602/"
      , img = "shoot-em-up.jpg"
      , year = 2007
      , runtime = 86
      , genres = [ "action", "comedy", "crime" ]
      , watched = Watched (date 2014 11 21)
      , nsfw = False
      }
    , { title = "The Brothers Bloom"
      , url = "http://www.imdb.com/title/tt0844286/"
      , img = "brothers-bloom.jpg"
      , year = 2008
      , runtime = 114
      , genres = [ "adventure", "comedy", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "In Bruges"
      , url = "http://www.imdb.com/title/tt0780536/"
      , img = "in-bruges.jpg"
      , year = 2008
      , runtime = 107
      , genres = [ "comedy", "crime", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "It Might Get Loud"
      , url = "http://www.imdb.com/title/tt1229360/"
      , img = "it-might-get-loud.jpg"
      , year = 2008
      , runtime = 98
      , genres = [ "documentary", "music" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Let the Right One In"
      , url = "http://www.imdb.com/title/tt1139797/"
      , img = "let-the-right-one-in.jpg"
      , year = 2008
      , runtime = 115
      , genres = [ "drama", "horror", "romance" ]
      , watched = Watched (date 2016 10 27)
      , nsfw = False
      }
    , { title = "Synecdoche New York"
      , url = "http://www.imdb.com/title/tt0383028/"
      , img = "synecdoche-new-york.jpg"
      , year = 2008
      , runtime = 124
      , genres = [ "comedy", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Case 39"
      , url = "http://www.imdb.com/title/tt0795351/"
      , year = 2009
      , img = "case-39.jpg"
      , runtime = 109
      , genres = [ "horror", "mystery", "thriller" ]
      , watched = Watched (date 2014 12 18)
      , nsfw = False
      }
    , { title = "Dead Snow"
      , url = "http://www.imdb.com/title/tt1278340/"
      , img = "dead-snow.jpg"
      , year = 2009
      , runtime = 91
      , genres = [ "comedy", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Wild Hunt"
      , url = "http://www.imdb.com/title/tt1493886"
      , img = "the-wild-hunt.jpg"
      , year = 2009
      , runtime = 96
      , genres = [ "drama", "thriller", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Zombieland"
      , url = "http://www.imdb.com/title/tt1156398/"
      , year = 2009
      , img = "zombieland.jpg"
      , runtime = 88
      , genres = [ "adventure", "comedy", "horror" ]
      , watched = Watched (date 2014 10 24)
      , nsfw = False
      }
    , { title = "Babies"
      , url = "http://www.imdb.com/title/tt1020938/"
      , img = "babies.jpg"
      , year = 2010
      , runtime = 79
      , genres = [ "documentary" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Tucker and Dale vs. Evil"
      , url = "http://www.imdb.com/title/tt1465522/"
      , img = "tucker-and-dale.jpg"
      , year = 2010
      , runtime = 89
      , genres = [ "comedy", "horror" ]
      , watched = Watched (date 2017 8 31)
      , nsfw = False
      }
    , { title = "Sanctum"
      , url = "http://www.imdb.com/title/tt0881320/"
      , year = 2011
      , img = "sanctum.jpg"
      , runtime = 108
      , genres = [ "adventure", "drama", "thriller" ]
      , watched = Watched (date 2014 11 7)
      , nsfw = False
      }
    , { title = "The Adjustment Bureau"
      , url = "http://www.imdb.com/title/tt1385826/"
      , img = "adjustment-bureau.jpg"
      , year = 2011
      , runtime = 106
      , genres = [ "romance", "sci-fi", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Argo"
      , url = "http://www.imdb.com/title/tt1024648/"
      , img = "argo.jpg"
      , year = 2012
      , runtime = 120
      , genres = [ "drama", "history", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Cabin in the Woods"
      , url = "http://www.imdb.com/title/tt1259521/"
      , img = "cabin-in-the-woods.jpg"
      , year = 2012
      , runtime = 95
      , genres = [ "horror", "mystery", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Iron Sky"
      , url = "http://www.imdb.com/title/tt1034314/"
      , img = "iron-sky.jpg"
      , year = 2012
      , runtime = 93
      , genres = [ "action", "comedy", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Life of Pi"
      , url = "http://www.imdb.com/title/tt0454876/"
      , img = "life-of-pi.jpg"
      , year = 2012
      , runtime = 127
      , genres = [ "adventure", "drama", "fantasy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Safety Not Guaranteed"
      , url = "http://www.imdb.com/title/tt1862079/"
      , year = 2012
      , img = "safety-not-guaranteed.jpg"
      , runtime = 86
      , genres = [ "comedy", "drama", "romance" ]
      , watched = Watched (date 2015 6 18)
      , nsfw = False
      }
    , { title = "Upstream Color"
      , url = "http://www.imdb.com/title/tt2084989/"
      , img = "upstream-color.jpg"
      , year = 2013
      , runtime = 96
      , genres = [ "drama", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Way Way Back"
      , url = "http://www.imdb.com/title/tt1727388/"
      , img = "way-way-back.jpg"
      , year = 2013
      , runtime = 103
      , genres = [ "comedy", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Whiplash"
      , url = "http://www.imdb.com/title/tt2582802/"
      , img = "whiplash.jpg"
      , year = 2014
      , runtime = 107
      , genres = [ "drama", "music" ]
      , watched = Watched (date 2015 9 24)
      , nsfw = False
      }
    , { title = "The Conjuring"
      , url = "http://www.imdb.com/title/tt1457767/"
      , img = "the-conjuring.jpg"
      , year = 2014
      , runtime = 112
      , genres = [ "horror" ]
      , watched = Watched (date 2015 10 22)
      , nsfw = False
      }
    , { title = "Parallels"
      , url = "http://www.imdb.com/title/tt3479316/"
      , img = "Parallels.jpg"
      , year = 2015
      , runtime = 83
      , genres = [ "action", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Repo Man"
      , url = "http://www.imdb.com/title/tt0087995/"
      , img = "repo-man.jpg"
      , year = 1984
      , runtime = 93
      , genres = [ "comedy", "crime", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "It's a Mad, Mad, Mad, Mad World"
      , url = "http://www.imdb.com/title/tt0057193/"
      , img = "mad-mad-world.jpg"
      , year = 1963
      , runtime = 205
      , genres = [ "action", "adventure", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "John Wick"
      , url = "http://www.imdb.com/title/tt2911666/"
      , img = "john-wick.jpg"
      , year = 2014
      , runtime = 101
      , genres = [ "action", "crime", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "10 Cloverfield Lane"
      , url = "http://www.imdb.com/title/tt1179933/"
      , img = "10-cloverfield-lane.jpg"
      , year = 2016
      , runtime = 104
      , genres = [ "drama", "horror", "mystery" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Hell or High Water"
      , url = "http://www.imdb.com/title/tt2582782/"
      , img = "hell-or-high-water.jpg"
      , year = 2016
      , runtime = 102
      , genres = [ "drama", "crime", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Eternal Sunshine of the Spotless Mind"
      , url = "http://www.imdb.com/title/tt0338013/"
      , img = "eternal-sunshine.jpg"
      , year = 2004
      , runtime = 108
      , genres = [ "drama", "romance", "sci-fi" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Gladiator"
      , url = "http://www.imdb.com/title/tt0172495/"
      , img = "gladiator.jpg"
      , year = 2000
      , runtime = 155
      , genres = [ "drama", "action", "adventure" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Psycho"
      , url = "http://www.imdb.com/title/tt0054215/"
      , img = "psycho.jpg"
      , year = 1960
      , runtime = 109
      , genres = [ "horror", "mystery", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Earth Girls Are Easy"
      , url = "http://www.imdb.com/title/tt0097257/"
      , img = "earth-girls.jpg"
      , year = 1988
      , runtime = 100
      , genres = [ "comedy", "musical", "romance" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Tapeheads"
      , url = "http://www.imdb.com/title/tt0096223/"
      , img = "tapeheads.jpg"
      , year = 1988
      , runtime = 93
      , genres = [ "music", "comedy" ]
      , watched = Watched (date 2018 1 25)
      , nsfw = False
      }
    , { title = "Boyhood"
      , url = "http://www.imdb.com/title/tt1065073/"
      , img = "boyhood.jpg"
      , year = 2014
      , runtime = 165
      , genres = [ "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Road Within"
      , url = "http://www.imdb.com/title/tt2962876/"
      , img = "road-within.jpg"
      , year = 2014
      , runtime = 100
      , genres = [ "drama", "comedy" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Son of Rambow"
      , url = "http://www.imdb.com/title/tt0845046/"
      , img = "son-of-rambow.jpg"
      , year = 2007
      , runtime = 95
      , genres = [ "comedy", "adventure" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "My Blue Heaven"
      , url = "http://www.imdb.com/title/tt0100212/"
      , img = "my-blue-heaven.jpg"
      , year = 1990
      , runtime = 97
      , genres = [ "comedy", "action" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Dudes & Dragons"
      , url = "http://www.imdb.com/title/tt2170369/"
      , img = "dudes-dragons.jpg"
      , year = 2015
      , runtime = 122
      , genres = [ "comedy", "adventure" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Hors De Prix"
      , url = "https://www.imdb.com/title/tt0482088/"
      , img = "horsdeprix.jpg"
      , year = 2006
      , runtime = 106
      , genres = [ "comedy", "romance" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "The Raid"
      , url = "https://www.imdb.com/title/tt1899353/"
      , img = "the-raid.jpg"
      , year = 2011
      , runtime = 101
      , genres = [ "action", "thriller" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Ip Man"
      , url = "https://www.imdb.com/title/tt1220719/"
      , img = "ip-man.jpg"
      , year = 2008
      , runtime = 106
      , genres = [ "action", "biography", "drama" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Bubba Ho Tep"
      , url = "https://www.imdb.com/title/tt0281686/"
      , img = "bubba-ho-tep.jpg"
      , year = 2002
      , runtime = 92
      , genres = [ "comedy", "fantasy", "horror" ]
      , watched = Unwatched
      , nsfw = False
      }
    , { title = "Time Bandits"
      , url = "https://www.imdb.com/title/tt0081633/"
      , img = "time-bandits.jpg"
      , year = 1981
      , runtime = 110
      , genres = [ "comedy", "fantasy", "adventure" ]
      , watched = Unwatched
      , nsfw = False
      }
    ]
        |> List.map (\m -> { m | genres = Genre.fromFlatList m.genres })
