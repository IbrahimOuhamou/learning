
@zig {
    if(logged_in) {
        @layout account/info(user_object: .user_object)
    } else {
        <p>please consider logging in</p>
    }
}

