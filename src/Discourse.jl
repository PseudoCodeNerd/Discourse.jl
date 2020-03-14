module Discourse

using HTTP, Dates, JSON, CodecZlib, Base64

# HTTP verbs to be used as non string literals
DELETE = "DELETE"
GET = "GET"
POST = "POST"
PUT = "PUT"

mutable struct DiscourseClient
    host::String
    api_username::String
    api_key::String
    timeout::Second
    function DiscourseClient(args...)
        new(host, api_username, api_key, timeout)
    end
end

include("utils/utils.jl")
export 
        convert_HTTP_Response_To_JSON
        _get
        _request
include("Categories/Categories.jl")
include("Users/User.jl")
export
        get_user        

end # module
