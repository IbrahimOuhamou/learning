@zig {
    if(zmpl.get("logged_in").?.boolean.value) {
        @partial account/info(id: .id, name: .name, email: .email)
        <p>bismi Allah</p>
    } else {
        <p>
            @partial link(href: "/account/login", text: "please consider logging in")
        </p>
    }
}

