#!/bin/bash

set -euo pipefail

make_status() {
    url="$1"
    read http_code time_total <<< $(curl -s -o /dev/null -w "%{http_code} %{time_total}" "$url")
    echo "<p>Status of $url: code $http_code, $(echo "scale=0; $time_total * 1000 / 1" | bc)ms</p>"
}

cat << EOF
<!DOCTYPE html>
<html>
    <head>
        <title>Service Statuses</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    </head>
    <body>
        <p>Last updated $(LANG=en date --utc)</p>
        $(make_status https://google.com)
        $(make_status https://megahomyak.com)
        $(make_status https://example.com)
    </body>
</html>
EOF
