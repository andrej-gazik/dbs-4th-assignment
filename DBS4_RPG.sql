DROP TABLE IF EXISTS "classes" CASCADE;
DROP TABLE IF EXISTS "characters" CASCADE ;
DROP TABLE IF EXISTS "chat_log_teams" CASCADE;
DROP TABLE IF EXISTS "chat_log_users" CASCADE;
DROP TABLE IF EXISTS "level_stat_increments" CASCADE;
DROP TABLE IF EXISTS "friends_pending" CASCADE ;
DROP TABLE IF EXISTS "friends_table" CASCADE;
DROP TABLE IF EXISTS "ignore_list" CASCADE;
DROP TABLE IF EXISTS "item_types" CASCADE;
DROP TABLE IF EXISTS "item_instances" CASCADE;
DROP TABLE IF EXISTS "levels" CASCADE;
DROP TABLE IF EXISTS "level_entities" CASCADE;
DROP TABLE IF EXISTS "monster_types" CASCADE;
DROP TABLE IF EXISTS "monsters_item_drops" CASCADE;
DROP TABLE IF EXISTS "quest_types" CASCADE;
DROP TABLE IF EXISTS "quest_instances" CASCADE;
DROP TABLE IF EXISTS "skill_types" CASCADE;
DROP TABLE IF EXISTS "skill_instances" CASCADE;
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


CREATE TABLE "item_types" (
    "id" bigint PRIMARY KEY,
    "slot" bigint,
    "hp" bigint,
    "atk" bigint,
    "def" bigint,
    "range" bigint,
    "cool_down" bigint
);

CREATE TABLE "item_instances" (
    "id" bigint PRIMARY KEY,
    "item_type" bigint,
    "level_required" int,

    CONSTRAINT fk_item_instances
        FOREIGN KEY(item_type)
        REFERENCES item_types(id)
);

CREATE TABLE "skill_types" (
    "id" bigint PRIMARY KEY,
    "lvl_required" bigint,
    "skill_required" bigint,

    CONSTRAINT fk_skills
        FOREIGN KEY(skill_required)
        REFERENCES skill_types(id)
);

CREATE TABLE "classes" (
    "id" bigint PRIMARY KEY,
    "canon_name" varchar(100),
    "starting_skill1" bigint,
    "starting_skill2" bigint,
    "starting_skill3" bigint,
    "starting_atk" bigint,
    "starting_def" bigint,
    "starting_hp" bigint,

    CONSTRAINT fk_classes
        FOREIGN KEY(starting_skill1)
        REFERENCES skill_types(id),
        FOREIGN KEY(starting_skill2)
        REFERENCES skill_types(id),
        FOREIGN KEY(starting_skill3)
        REFERENCES skill_types(id)
);

CREATE TABLE "skill_instances" (
    "id" bigint PRIMARY KEY,
    "skill_type" bigint,
    "skill_lvl" int,
    "owner" bigint,

    CONSTRAINT fk_skill_instances
        FOREIGN KEY(skill_type)
        REFERENCES skill_types(id)
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
    "item_weapon" bigint,
    "item_def" bigint,
    "item_artifact" bigint,
    "item_inv1" bigint,
    "item_inv2" bigint,
    "item_inv3" bigint,
    "item_inv4" bigint,
    "item_inv5" bigint,
    "item_inv6" bigint,
    "item_inv7" bigint,
    "item_inv8" bigint,
    "skill_equipped1" bigint,
    "skill_equipped2" bigint,
    "skill_equipped3" bigint,

    CONSTRAINT fk_characters
        FOREIGN KEY(user_id)
        REFERENCES users(user_id),
        FOREIGN KEY(class_id)
        REFERENCES classes(id),
        FOREIGN KEY(item_weapon)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_def)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_artifact)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv1)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv2)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv3)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv4)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv5)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv6)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv7)
        REFERENCES item_instances(id),
        FOREIGN KEY(item_inv8)
        REFERENCES item_instances(id),
        FOREIGN KEY(skill_equipped1)
        REFERENCES skill_instances(id),
        FOREIGN KEY(skill_equipped2)
        REFERENCES skill_instances(id),
        FOREIGN KEY(skill_equipped3)
        REFERENCES skill_instances(id)
);

ALTER TABLE "skill_instances"
    ADD
    FOREIGN KEY(owner)
    REFERENCES characters(id);

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
    "id" bigint PRIMARY KEY,
    "creator" bigint,
    "chat_id" bigint,
    "name" varchar(100),

    CONSTRAINT fk_teams
        FOREIGN KEY(creator)
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

ALTER TABLE "teams"
    ADD FOREIGN KEY(chat_id)
    REFERENCES chat_log_teams(id);

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

CREATE TABLE "levels" (
    "id" bigint PRIMARY KEY

);

CREATE TABLE "quest_types" (
    "id" bigint PRIMARY KEY,
    "canon_name" varchar(100),
    "description" varchar(10000),
    "quest_required" bigint,
    "level_required" bigint,
    "map_to_visit" bigint,
    "monsters_to_kill_type" bigint,
    "monsters_to_kill_count" bigint,

    CONSTRAINT fk_quests
        FOREIGN KEY(quest_required)
        REFERENCES quest_types(id),
        FOREIGN KEY(map_to_visit)
        REFERENCES levels(id)
);

CREATE TABLE "quest_instances" (
    "id" bigint PRIMARY KEY,
    "quest_type" bigint,
    "progress" bigint,
    "owner" bigint,

    CONSTRAINT fk_quest_instances
        FOREIGN KEY(quest_type)
        REFERENCES quest_types(id),
        FOREIGN KEY(owner)
        REFERENCES characters(id)
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
        REFERENCES quest_types(id),
        FOREIGN KEY(monster_slain_required)
        REFERENCES monster_types(id)
);

ALTER TABLE "quest_types"
    ADD FOREIGN KEY(monsters_to_kill_type)
    REFERENCES monster_types(id);

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

CREATE TABLE "monsters_item_drops" (
    "id" bigint PRIMARY KEY,
    "monster" bigint,
    "item" bigint,
    "base_chance" float,

    CONSTRAINT fk_monsters_item_drops
        FOREIGN KEY(item)
        REFERENCES item_types(id),
        FOREIGN KEY(monster)
        REFERENCES monster_types(id)
);



CREATE TABLE "level_entities" (
    "id" bigint PRIMARY KEY,
    "x" bigint,
    "y" bigint,
    "char" bigint,
    "enemy" bigint,
    "item" bigint,
    "obstacle" bigint,
    "level" bigint,

    CONSTRAINT fk_level_ent
        FOREIGN KEY(level)
        REFERENCES levels(id)
)