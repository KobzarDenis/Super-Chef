docker build --tag=kobzar_psql_img ./docker

docker run --name=kobzar_psql_container -p $PORT:5432 -d kobzar_psql_img
