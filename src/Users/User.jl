using Discourse

function get_user(username::String)
    """
        Get User information for a specific user.
        ARGS:
            username::String -> username to return
        RETURNS:
            user_info::Dictionary
    """
    return _get("/users/$(username).json")["user"]
    
end