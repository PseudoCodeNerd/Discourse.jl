using Discourse

function convert_HTTP_Response_To_JSON(response)

    compressed = HTTP.payload(response);
    decompressed = transcode(GzipDecompressor, compressed);
    json = JSON.parse(IOBuffer(decompressed))
    return json

end

function _get(path, kwargs...)
    """
        HTTP Helper function
        ARGS:
            path:
                kwargs:
        RETURNS:
    """
    return _request(GET, path, params=kwargs)

end

function _request(verb, path, params::Dict, files::Dict, data::Dict, json::Dict)
    """
        Executes HTTP request to API and handles response
        ARGS:
            verb: HTTP verb as string; defined in Discourse.jl
            path: path on Discourse API
            params: dict of parameters to include in API
        RETURNS:
            response_body_data::Dictionary / None::None
    """
    url = DiscourseClient.host + path
    headers = Dict(
        "Accept" => "application/json; charset=utf-8",
        "Api-key" => DiscourseClient.api_key,
        "Api-username" => DiscourseClient.api_username
    )
    
    # times we should retry request if rate limited.
    retry_count = 4
    # Extra time (on top of that required by API) to wait on a retry
    retry_backoff = 1

    while retry_count>=0
        r = HTTP.request(
            verb,
            url,
            allow_redirects=false,
            params=params,
            files=files,
            data=data,
            json=json,
            headers=headers,
            timeout=DiscourseClient.timeout
        )
        if r.status == 200
            break
        end
    end
    json_content = "application/json; charset=utf-8"
    content_type = r.headers["content_type"]
    decoded = r.json()
    return decoded
end