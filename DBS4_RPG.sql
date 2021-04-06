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

CREATE TABLE "characters" (
  "id" bigint,
  "user_id" bigint,
  "char_type" bigint,
  "xp" bigint,
  "level" bigint,
  "hpmax" bigint,
  "atk" bigint,
  "def" bigint
);

CREATE TABLE "friends_table" (
  "id" bigint,
  "user1" uuid,
  "user2" uuid
);

CREATE TABLE "friends_pending" (
  "id" bigint,
  "sender" uuid,
  "receiver" uuid,
  "status" tinyint
);

CREATE TABLE "user_team_table" (
  "id" bigint,
  "user_id" bigint,
  "team_id" bigint
);

CREATE TABLE "teams" (
  "id" bigint
);

CREATE TABLE "quests" (
  "id" bigint,
  "quest_required" bigint,
  "level_required" bigint
);

CREATE TABLE "monster_types" (
  "id" bigint,
  "levelmin" bigint,
  "levelmax" bigint,
  "quest_required" bigint,
  "monster_slain_required" bigint,
  "hpmax" bigint,
  "atk" bigint,
  "def" bigint,
  "xp_drop" bigint
);

CREATE TABLE "chat_log_users" (
  "id" bigint,
  "sender" bigint,
  "receiver" bigint,
  "message" varchar,
  "created_at" timestamp
);

CREATE TABLE "chat_log_teams" (
  "id" bigint,
  "sender" bigint,
  "team" bigint,
  "message" varchar,
  "created_at" timestamp
);

CREATE TABLE "ignore_list" (
  "id" bigint,
  "user_blocker" bigint,
  "user_blocked" bigint
);

CREATE TABLE "skills" (
  "id" bigint,
  "lvl_required" bigint,
  "skill_required" bigint
);

CREATE TABLE "class1_level_stat_increments" (
  "level" bigint,
  "hp_inc" bigint,
  "atk_inc" bigint,
  "def_inc" bigint
);

CREATE TABLE "items" (
  "id" bigint,
  "slot" bigint,
  "hp" bigint,
  "atk" bigint,
  "def" bigint
);

CREATE TABLE "monsters_item_drops" (
  "id" bigint,
  "monster" bigint,
  "item" bigint,
  "base_chance" double
);
