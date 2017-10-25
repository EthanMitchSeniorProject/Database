-- Schema.sql defines the tables necessary for storing the soccer statistics
-- Tables must be dropped in reverse order to ensure integrity of foreign keys
-- Tables defined with primary key and, if necessary, foreign key constraints
-- Varchar lengths are all estimates of how long particular strings may be

drop table player_game;
drop table event;
drop table game;
drop table player;

-- Player table
create table player
(
    id integer PRIMARY KEY,
    name varchar(30),
    year varchar(10),
    position varchar(15),
    games_played integer,
    games_started integer,
    points integer,
    shots integer,
    shots_on_goal integer,
    yellow_cards integer,
    red_cards integer
);

-- Game table
create table game
(
    id integer PRIMARY KEY,
    home_team varchar(30),
    away_team varchar(30)
);

-- Event table
-- Events are connected to a specific game
-- Many events to one game (Many-to-One relationship)
create table event
(
    id integer PRIMARY KEY,
    game_id integer,
    team_name varchar(30),
    time_of_event varchar(5),
    description_event varchar(60),
    FOREIGN KEY (game_id) REFERENCES game(id)
);

-- Player_game table
-- This table is needed for looking at recent player trends
-- This connects a specific player to a specific game
-- Many players to many games (Many-to-Many relationship)
create table player_game
(
    player_id integer,
    game_id integer,
    goals integer,
    assists integer,
    starts bit,
    PRIMARY KEY (player_id, game_id),
    FOREIGN KEY (player_id) REFERENCES player(id),
    FOREIGN KEY (game_id) REFERENCES game(id)
);
