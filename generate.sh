set -euo pipefail

make_status() {
    URL="$1"
    echo "<p>Status of $URL: $(TIME="%e" time -o >(echo ", $(echo "scale=0; $(cat /dev/stdin) * 1000 / 1" | bc)ms") curl -s -o /dev/null -w "code %{http_code}" http://www.example.org/)</p>"
}

cat << EOF
<!DOCTYPE html>
<html>
    <head>
        <title>status checker</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    </head>
    <body>
        $(make_status https://google.com)
        $(make_status https://megahomyak.com)
        $(make_status https://example.com)
    </body>
</html>
EOF
