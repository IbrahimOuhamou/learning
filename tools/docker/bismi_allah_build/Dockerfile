# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed rassoul Allah

FROM fedora

RUN echo 'Y' | dnf install zig

COPY src/bismi_allah.zig ./bismi_allah.zig

RUN zig build-exe bismi_allah.zig

CMD ["echo", "alhamdo li Allah"]

# RUN dnf install 
