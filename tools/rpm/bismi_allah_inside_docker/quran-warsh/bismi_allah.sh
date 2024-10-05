# bash

# ti is planned to be ran in CI/CD
# so we should make sure we can automate it
# alhamdo li Allah

# mkdir quran-warsh-1.0.0
# mv|cp src build* quran-warsh-1.0.0
# tar -czf quran-warsh-1.0.0.tar.gz quran-warsh-1.0.0

mkdir packages
docker build . -t bismi_allah_build_rpm
docker create --name bismi_allah_build_rpm bismi_allah_build_rpm
docker cp bismi_allah_build_rpm:/results/* packages/
docker rm -f bismi_allah_build_rpm

