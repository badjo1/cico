CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar, "last_name" varchar, "email" varchar, "password_digest" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "remember_digest" varchar, "activation_digest" varchar, "activated" boolean DEFAULT 'f', "activated_at" datetime, "reset_digest" varchar, "reset_sent_at" datetime, "prefix" varchar);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE TABLE "spaces" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "venue_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_spaces_on_venue_id" ON "spaces" ("venue_id");
CREATE TABLE "space_entries" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "start_time" datetime, "end_time" datetime, "event_id" integer, "space_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_space_entries_on_event_id" ON "space_entries" ("event_id");
CREATE INDEX "index_space_entries_on_space_id" ON "space_entries" ("space_id");
CREATE TABLE "venues" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "venue_users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "venue_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "visit_on" datetime, "role" varchar DEFAULT 'user', "joined_in" datetime);
CREATE INDEX "index_venue_users_on_user_id" ON "venue_users" ("user_id");
CREATE INDEX "index_venue_users_on_venue_id" ON "venue_users" ("venue_id");
CREATE UNIQUE INDEX "index_venue_users_on_user_id_and_venue_id" ON "venue_users" ("user_id", "venue_id");
CREATE INDEX "index_venue_users_on_user_id_and_visit_on" ON "venue_users" ("user_id", "visit_on");
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "event_name" varchar, "venue_user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "event_type" varchar DEFAULT 'appointment' NOT NULL);
CREATE INDEX "index_events_on_venue_user_id" ON "events" ("venue_user_id");
INSERT INTO schema_migrations (version) VALUES ('20160603173809');

INSERT INTO schema_migrations (version) VALUES ('20160603175638');

INSERT INTO schema_migrations (version) VALUES ('20160605110105');

INSERT INTO schema_migrations (version) VALUES ('20160606085056');

INSERT INTO schema_migrations (version) VALUES ('20160606085201');

INSERT INTO schema_migrations (version) VALUES ('20160607083216');

INSERT INTO schema_migrations (version) VALUES ('20160608174420');

INSERT INTO schema_migrations (version) VALUES ('20160609200030');

INSERT INTO schema_migrations (version) VALUES ('20160612091904');

INSERT INTO schema_migrations (version) VALUES ('20160613111358');

INSERT INTO schema_migrations (version) VALUES ('20160613112116');

INSERT INTO schema_migrations (version) VALUES ('20160622132532');

INSERT INTO schema_migrations (version) VALUES ('20160630103223');

INSERT INTO schema_migrations (version) VALUES ('20160704214439');

INSERT INTO schema_migrations (version) VALUES ('20160704215354');

INSERT INTO schema_migrations (version) VALUES ('20160705204709');

INSERT INTO schema_migrations (version) VALUES ('20160717200752');

INSERT INTO schema_migrations (version) VALUES ('20170612152117');

INSERT INTO schema_migrations (version) VALUES ('20170613105105');

