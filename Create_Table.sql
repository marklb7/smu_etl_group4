CREATE TABLE "lk_conference" (
    "id" SERIAL   NOT NULL,
    "conference_name" VARCHAR   NOT NULL,
    "last_updated" TIMESTAMP   NOT NULL,
    CONSTRAINT "pk_lk_conference" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "lk_division" (
    "id" SERIAL   NOT NULL,
    "conference_id" INT   NOT NULL,
    "division_name" VARCHAR   NOT NULL,
    "last_updated" TIMESTAMP   NOT NULL,
    CONSTRAINT "pk_lk_division" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "teams" (
    "id" SERIAL   NOT NULL,
    "team_abbr" VARCHAR   NOT NULL,
    "team_name" VARCHAR   NOT NULL,
    "year_founded" INT   NOT NULL,
    "city" VARCHAR   NOT NULL,
    "conference_id" INT   NOT NULL,
    "division_id" INT   NOT NULL,
    "last_updated" TIMESTAMP   NOT NULL,
    CONSTRAINT "pk_teams" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "player" (
    "id" SERIAL   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "team_id" INT   NOT NULL,
    "position" VARCHAR   NOT NULL,
    "last_updated" TIMESTAMP   NOT NULL,
    CONSTRAINT "pk_player" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "player_stats" (
    "id" SERIAL   NOT NULL,
    "player_id" INT   NOT NULL,
    "games_played" INT   NOT NULL,
    "goals" INT   NOT NULL,
    "assists" INT   NOT NULL,
    "points" INT   NOT NULL,
    "penalty_minutes" INT   NOT NULL,
    "last_updated" TIMESTAMP   NOT NULL,
    CONSTRAINT "pk_player_stats" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "lk_division" ADD CONSTRAINT "fk_lk_division_conference_id" FOREIGN KEY("conference_id")
REFERENCES "lk_conference" ("id");

ALTER TABLE "teams" ADD CONSTRAINT "fk_teams_conference_id" FOREIGN KEY("conference_id")
REFERENCES "lk_conference" ("id");

ALTER TABLE "teams" ADD CONSTRAINT "fk_teams_division_id" FOREIGN KEY("division_id")
REFERENCES "lk_division" ("id");

ALTER TABLE "player" ADD CONSTRAINT "fk_player_team_id" FOREIGN KEY("team_id")
REFERENCES "teams" ("id");

ALTER TABLE "player_stats" ADD CONSTRAINT "fk_player_stats_player_id" FOREIGN KEY("player_id")
REFERENCES "player" ("id");

