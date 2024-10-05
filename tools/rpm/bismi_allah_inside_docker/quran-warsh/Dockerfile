# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed rassoul Allah

FROM fedora

RUN echo 'Y' | dnf install zig CSFML-devel

COPY ./rpmbuild rpmbuild
# COPY quran-warsh-1.0.0.tar.gz rpmbuild/SOURCES

RUN rpmbuild -ba rpmbuild/SPECS/quran-warsh.spec 

CMD ["echo", "thanks to Allah"]

