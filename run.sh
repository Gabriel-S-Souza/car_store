#!/bin/bash

# init api
git clone "https://github.com/Gabriel-S-Souza/car_store_api"
cd car_store_api
# init docker
docker-compose down
docker-compose build
docker-compose up -d

# config app
cd ..
flutter pub get
flutter run --dart-define-from-file=env.json

