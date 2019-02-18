psql -U postgres -d postgres -c "create role chef with login password 'admin';"
psql -U postgres -d postgres -c "create database super_chef owner chef;"

psql -U chef super_chef -d super_chef -c "create role accountant with login password 'admin';"
psql -U chef super_chef -d super_chef -c "create role manager with login password 'admin';"

psql -U postgres super_chef < ./super-chef-dump.sql