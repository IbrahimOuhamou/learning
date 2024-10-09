# bash

# ti is planned to be ran in CI/CD
# so we should make sure we can automate it
# alhamdo li Allah

echo "بسم الله الرحمن الرحيم"

echo "mkdir quran-warsh-1.0.0"
mkdir quran-warsh-1.0.0
echo "cp -r src build.zig* quran-warsh-1.0.0"
cp -r src build.zig* quran-warsh-1.0.0
echo "tar -czf quran-warsh-1.0.0.tar.gz quran-warsh-1.0.0"
tar -czf quran-warsh-1.0.0.tar.gz quran-warsh-1.0.0

echo "mkdir packages"
mkdir packages

echo "docker build . -t bismi_allah_build_rpm"
docker build . -f Dockerfile_rpm -t bismi_allah_build_rpm --build-arg VERSION=1.0.0
echo "docker create --name bismi_allah_build_rpm bismi_allah_build_rpm"
docker create --name bismi_allah_build_rpm bismi_allah_build_rpm
echo "docker cp bismi_allah_build_rpm:/root/rpmbuild/RPMS/x86_64/* packages/"
docker cp bismi_allah_build_rpm:/root/rpmbuild/RPMS/x86_64 packages/
# echo "docker rm -f bismi_allah_build_rpm"
# docker rm -f bismi_allah_build_rpm

