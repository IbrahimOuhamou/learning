#bash

#بسم الله الرحمن الرحيم
#la ilaha illa Allah Mohammed rassoul Allah
docker build . -t bismi_allah_build_in_container
docker create --name bismi_allah_build_in_container bismi_allah_build_in_container
docker cp bismi_allah_build_in_container:bismi_allah ./bismi_allah
docker rm -f bismi_allah_build_in_container
