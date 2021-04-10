DROP TABLE IF EXISTS "classes" CASCADE;
DROP TABLE IF EXISTS "characters" CASCADE ;
DROP TABLE IF EXISTS "chat_log_teams" CASCADE;
DROP TABLE IF EXISTS "chat_log_users" CASCADE;
DROP TABLE IF EXISTS "level_stat_increments" CASCADE;
DROP TABLE IF EXISTS "friends_pending" CASCADE ;
DROP TABLE IF EXISTS "friends_table" CASCADE;
DROP TABLE IF EXISTS "ignore_list" CASCADE;
DROP TABLE IF EXISTS "items" CASCADE;
DROP TABLE IF EXISTS "monster_types" CASCADE;
DROP TABLE IF EXISTS "monsters_item_drops" CASCADE;
DROP TABLE IF EXISTS "quests" CASCADE;
DROP TABLE IF EXISTS "skills" CASCADE;
DROP TABLE IF EXISTS "teams" CASCADE;
DROP TABLE IF EXISTS "char_team_table" CASCADE;
DROP TABLE IF EXISTS "users" CASCADE;


CREATE TABLE "users" (
    "user_id" uuid PRIMARY KEY,
    "user_email" varchar(128) UNIQUE,
    "user_name" varchar UNIQUE,
    "password_hash" varchar(32),
    "password_salt" varchar(32),
    "external_type" varchar(16),
    "external_facebook" varchar(64),
    "external_google" varchar(64)
);


CREATE TABLE "classes" (
    "id" bigint PRIMARY KEY,
    "canon_name" varchar(100)
);

CREATE TABLE "characters" (
    "id" bigint PRIMARY KEY,
    "user_id" uuid,
    "class_id" bigint,
    "xp" bigint,
    "level" bigint,
    "hp_max" bigint,
    "atk" bigint,
    "def" bigint,

    CONSTRAINT fk_characters
        FOREIGN KEY(user_id)
        REFERENCES users(user_id),
        FOREIGN KEY(class_id)
        REFERENCES classes(id)
);

CREATE TABLE "friends_table" (
    "id" bigint PRIMARY KEY,
    "char_id1" bigint,
    "char_id2" bigint,

    CONSTRAINT fk_friends_table
        FOREIGN KEY(char_id1)
        REFERENCES characters(id),
        FOREIGN KEY(char_id2)
        REFERENCES characters(id)
);

CREATE TABLE "friends_pending" (
    "id" bigint PRIMARY KEY,
    "sender" bigint,
    "receiver" bigint,
    "status" bigint,

   CONSTRAINT fk_friends_pending
        FOREIGN KEY(sender)
        REFERENCES characters(id),
        FOREIGN KEY(status)
        REFERENCES characters(id)
);

CREATE TABLE "teams" (
    "id" bigint PRIMARY KEY
);

CREATE TABLE "char_team_table" (
    "id" bigint PRIMARY KEY,
    "char_id" bigint,
    "team_id" bigint,

    CONSTRAINT fk_user_team_table
        FOREIGN KEY(char_id)
        REFERENCES characters(id),
        FOREIGN KEY(team_id)
        REFERENCES teams(id)
);


CREATE TABLE "quests" (
    "id" bigint PRIMARY KEY,
    "quest_required" bigint,
    "level_required" bigint,

    CONSTRAINT fk_quests
        FOREIGN KEY(quest_required)
        REFERENCES quests(id)
);

CREATE TABLE "monster_types" (
    "id" bigint PRIMARY KEY,
    "level_min" bigint,
    "level_max" bigint,
    "quest_required" bigint,
    "monster_slain_required" bigint,
    "hp_max" bigint,
    "atk" bigint,
    "def" bigint,
    "xp_drop" bigint,

     CONSTRAINT fk_monster_types
        FOREIGN KEY(quest_required)
        REFERENCES quests(id),
        FOREIGN KEY(monster_slain_required)
        REFERENCES monster_types(id)
);

CREATE TABLE "chat_log_users" (
    "id" bigint PRIMARY KEY,
    "sender" bigint,
    "receiver" bigint,
    "message" varchar,
    "created_at" timestamp,

    CONSTRAINT fk_chat_log_users
        FOREIGN KEY(sender)
        REFERENCES characters(id),
        FOREIGN KEY(receiver)
        REFERENCES characters(id)
);

CREATE TABLE "chat_log_teams" (
    "id" bigint PRIMARY KEY,
    "sender" bigint,
    "team" bigint,
    "message" varchar,
    "created_at" timestamp,

    CONSTRAINT fk_chat_log_teams
        FOREIGN KEY(sender)
        REFERENCES characters(id),
        FOREIGN KEY(team)
        REFERENCES teams(id)
);

CREATE TABLE "ignore_list" (
    "id" bigint PRIMARY KEY,
    "char_blocking" bigint,
    "char_blocked" bigint,

    CONSTRAINT fk_ignore_list
        FOREIGN KEY(char_blocking)
        REFERENCES characters(id),
        FOREIGN KEY(char_blocked)
        REFERENCES characters(id)
);

CREATE TABLE "skills" (
    "id" bigint PRIMARY KEY,
    "lvl_required" bigint,
    "skill_required" bigint,

    CONSTRAINT fk_skills
        FOREIGN KEY(skill_required)
        REFERENCES skills(id)
);

CREATE TABLE "level_stat_increments" (
    "level" bigint PRIMARY KEY,
    "class" bigint,
    "hp_inc" bigint,
    "atk_inc" bigint,
    "def_inc" bigint,

    CONSTRAINT fk_level_stat_inc
        FOREIGN KEY(class)
        REFERENCES classes(id)
);

CREATE TABLE "items" (
    "id" bigint PRIMARY KEY,
    "slot" bigint,
    "hp" bigint,
    "atk" bigint,
    "def" bigint
);

CREATE TABLE "monsters_item_drops" (
    "id" bigint PRIMARY KEY,
    "monster" bigint,
    "item" bigint,
    "base_chance" float,

    CONSTRAINT fk_monsters_item_drops
        FOREIGN KEY(item)
        REFERENCES items(id)
);
