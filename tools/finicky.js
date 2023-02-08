function openInFirefoxContainer(containerName, urlString) {
  return `ext+container:name=${containerName}&url=${encodeURIComponent(urlString)}`;
}

module.exports = {
    defaultBrowser: "Firefox",
    handlers: [
        { match: /heb.zoom.us\/.+login\?from/, browser: "Google Chrome" },
        { match: /zoom.us\/j\//, browser: "us.zoom.xos" },
    ],

    rewrite: [
        {
            match: /zoom.us\/s\//,
            url: ({ url }) => ({
                ...url,
                pathname: url.pathname.replace(/^\/s\//, "/j/"),
            }),
        },
/*
        {
            match: /zoom.us\/my\//,
            url: ({ url }) => https.get(
                url,
                ({ res }) => res.statusCode === 302
                    ? url
                    : res.headers.location
            ),
        },
 * */
    ]
}
