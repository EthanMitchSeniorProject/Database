-- Schema.sql defines the tables necessary for storing the soccer statistics
-- Tables must be dropped in reverse order to ensure integrity of foreign keys
-- Tables defined with primary key and, if necessary, foreign key constraints
-- Varchar lengths are all estimates of how long particular strings may be

drop table player_game;
drop table event;
drop table game;
drop table player;
drop table team;

drop table vball_player_game;
drop table vball_play;
drop table vball_game;
drop table vball_player;
drop table vball_team;

-- Soccer Team table
create table team
(
    id integer PRIMARY KEY,
    school_name varchar(50)
);

-- Soccer Player table
create table player
(
    id integer PRIMARY KEY,
    team_id integer,
    name varchar(30),
    year varchar(10),
    position varchar(15),
    games_played integer,
    games_started integer,
    points integer,
    shots integer,
    shots_on_goal integer,
    yellow_cards integer,
    red_cards integer,
    FOREIGN KEY (team_id) REFERENCES team(id)
);

-- Soccer Game table
create table game
(
    id integer PRIMARY KEY,
    home_team integer,
    away_team integer,
    FOREIGN KEY (home_team) REFERENCES team(id),
    FOREIGN KEY (away_team) REFERENCES team(id)
);

-- Soccer Event table
-- Events are connected to a specific soccer game
-- Many events to one game (Many-to-One relationship)
create table event
(
    id integer PRIMARY KEY,
    game_id integer,
    team_id integer,
    time_of_event varchar(6),
    description_event varchar(100),
    FOREIGN KEY (game_id) REFERENCES game(id),
    FOREIGN KEY (team_id) REFERENCES team(id)
);

-- Soccer Player_game table
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

-- Volleyball Team table
create table vball_team
(
    id integer PRIMARY KEY,
    school_name varchar(50)
);

-- Volleyball Player table
create table vball_player
(
    id integer PRIMARY KEY,
    team_id integer,
    name varchar(30),
    year varchar(10),
    position varchar(6),
    matches_played integer,
    sets_played integer,
    kills integer,
    errors integer,
    attempts integer,
    hitting_perc float,
    assists integer,
    service_aces integer,
    digs integer,
    solo_blocks integer,
    block_assists integer,
    points integer,
    FOREIGN KEY (team_id) REFERENCES vball_team(id)
);

-- Volleyball Game table
create table vball_game
(
    id integer PRIMARY KEY,
    home_team integer,
    away_team integer,
    FOREIGN KEY (home_team) REFERENCES vball_team(id),
    FOREIGN KEY (away_team) REFERENCES vball_team(id)
);

-- Volleyball Play table
-- Plays are connected to a specific volleyball game
-- Many plays to one game (Many-to-One relationship)
create table vball_play
(
    id integer PRIMARY KEY,
    game_id integer,
    team_id integer,
    server_id integer,
    rotation integer,
    result varchar(60),
    actor_id integer,
    new_score varchar(10),
    FOREIGN KEY (game_id) REFERENCES vball_game(id),
    FOREIGN KEY (team_id) REFERENCES vball_team(id),
    FOREIGN KEY (server_id) REFERENCES vball_player(id),
    FOREIGN KEY (actor_id) REFERENCES vball_player(id)
);

-- Volleyball Player_game table
-- This connects a specific player to a specific volleyball game
-- Many players to many games (Many-to-Many relationship)
create table vball_player_game
(
    player_id integer,
    game_id integer,
    PRIMARY KEY(player_id, game_id),
    FOREIGN KEY (player_id) REFERENCES vball_player(id),
    FOREIGN KEY (game_id) REFERENCES vball_game(id)
);