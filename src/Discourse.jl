module Discourse

using HTTP, Dates, JSON, CodecZlib

include("exceptions.jl")

# HTTP verbs to be used as non string literals
DELETE = "DELETE"
GET = "GET"
POST = "POST"
PUT = "PUT"

# utility function
function convert_HTTP_Response_To_JSON(response)
    compressed = HTTP.payload(response);

    decompressed = transcode(GzipDecompressor, compressed);

    json = JSON.parse(IOBuffer(decompressed))

    return json
end

struct Ds
    """
    Initialize the client
    Args:
        host: full domain name including scheme for the Discourse API
        api_username: username to connect with
        api_key: API key to connect with
        timeout: optional timeout for the request (in seconds)
    Returns:
    """
    host
    api_username
    api_key
end

function user(username::String)
    """
    Get a single user by username.
    """
    r = HTTP.request(GET, "/users/$(username).json")
    json_obj = conver
    for (k, v) in 

end



end # module
