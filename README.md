docker build -t tretkow/vim .
docker run -it --name vim --rm -v $HOME:/home/dev/code tretkow/vim
