\set VERBOSITY terse

-- predictability
SET synchronous_commit = on;

DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (id int);

SELECT 'init' FROM pg_create_logical_replication_slot('regression_slot', 'wal2json');

-- Insert one row and check header

INSERT INTO tbl VALUES (1);
SELECT data FROM pg_logical_slot_get_changes('regression_slot', NULL, NULL, 'pretty-print', '1', 'include-message-header', '1');

SELECT 'stop' FROM pg_drop_replication_slot('regression_slot');

