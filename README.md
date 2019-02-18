# Super-Chef

How to run DB in a container:

1) Clone this repo on your PC
2) Check that docker is already installing
3) RUN `cd Super-Chef/db/super-chef`
4) RUN `PORT=<your_free_port> sh install.sh` for preparing environment
5) RUN `docker exec -ti kobzar_psql_container sh -c "sh ./install_db.sh"` for deploying Super-Chef DB

Than you will be able to using this DB =)

How to uninstall it:

1) RUN `sh uninstall.sh`
