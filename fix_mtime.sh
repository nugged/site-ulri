#!/bin/bash
SELFDIR="$(dirname $0)"
SITEMAP="$SELFDIR/docs/sitemap.xml"

if [ ! -e "$SITEMAP" ]; then
    echo "Error: $SITEMAP does not exist"
    exit 1
fi

do_touch() {
    local URL="$1"
    local FILE="${2:-$URL}"

    echo -n "Processing $FILE: "

    # Parse the lastmod from the XML file
    LASTMOD=$(xmlstarlet sel -N x="http://www.sitemaps.org/schemas/sitemap/0.9" -t -v "//x:url[x:loc='https://perlkohacon.fi/$URL']/x:lastmod" $SITEMAP)
    # Check if LASTMOD is a valid date string
    if [ -z "$LASTMOD" ] && [[ ! $LASTMOD =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\+[0-9]{2}:[0-9]{2}$ ]]; then
        echo "Error: LASTMOD is not a valid date string: $LASTMOD"
        exit 1
    fi

    # Convert the timestamp to the format required by touch
    # Check if gdate is available
    if command -v gdate >/dev/null 2>&1; then
        TIMESTAMP=$(gdate -d"$LASTMOD" +"%Y%m%d%H%M.%S")
    elif [[ "$(uname)" == "Darwin" ]]; then
        # MacOS date command
        TIMESTAMP=$(date -j -f "%Y-%m-%dT%H:%M:%S%z" "$LASTMOD" +"%Y%m%d%H%M.%S")
    else
        # Assume Linux date command
        TIMESTAMP=$(date -d"$LASTMOD" +"%Y%m%d%H%M.%S")
    fi

    echo "touched $LASTMOD / $TIMESTAMP"

    # Update the timestamp of the file
    touch -t $TIMESTAMP "$SELFDIR/$FILE"
}

do_touch Perl-and-Koha-conference-Schedule.html
do_touch Hotels_and_Appartments.html
# and for massive index.html files:
for i in "$SELFDIR/"*/index.html; do
    do_touch "$(basename $(dirname "$i"))/" "$(basename $(dirname "$i"))/index.html"
done


