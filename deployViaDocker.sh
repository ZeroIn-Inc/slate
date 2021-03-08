docker run --rm --name slate -v $(pwd)/source:/srv/slate/source -v $(pwd)/build:/srv/slate/build slatedocs/slate build
./deploy.sh --push-only
