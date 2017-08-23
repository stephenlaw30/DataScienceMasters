"""
JSON objects (like dictionaries in Python) can have elements that are arrays (Python lists), another JSON object

These objects all can be nested w/in each other (objects can have fields whose values are JSON objects + 
array elements can be other arrays, objects, or individual values

Different items can have different fields (i.e. record certifications can have multipliers (4x platinum) or not (gold)

JSON data is usually encountered via a WEB SERVICE which is a database we can access via a HTTP requests + a query

Queries are formulated as URLs with a base URL (musicbrainz in this case) + specified entities for specific data we want 
back (artist in this case), with some additional parameters for which features/metadata we want


"""
import json
import requests

# get URL to web service that grants access to its music data 
BASE_URL = "http://musicbrainz.org/ws/2/"
# get artist metadata (type of data/entity)
ARTIST_URL = BASE_URL + "artist/"


# QUERY PARAMETERS are given to the requests.get() function as a dictionary
# This variable contains some starter parameters.
query_type = {  "simple": {},
                "atr": {"inc": "aliases+tags+ratings"},
                "aliases": {"inc": "aliases"},
                "releases": {"inc": "releases"}}

# need unique identifier of artist to get their data
def query_site(url, params, uid="", fmt="json"):
    """
    This is the main function for making queries to the musicbrainz API which should return a JSON document.
    """
    params["fmt"] = fmt
    r = requests.get(url + uid, params=params)
    print "requesting", r.url

    if r.status_code == requests.codes.ok:
        return r.json()
    else:
        r.raise_for_status()


def query_by_name(url, params, name):
    """
    Adds artist name to the query parameters before making an API call to query_site()
    """
    params["query"] = "artist:" + name
    return query_site(url, params)


def pretty_print(data, indent=4):
    """
    After we get our output, we can use this function to format it to be more
    readable.
    """
    if type(data) == dict:
        print json.dumps(data, indent=indent, sort_keys=True)
    else:
        print data


def main():
    """
    Below is an example investigation to help you get started in your
    exploration. Modify the function calls and indexing below to answer the
    questions on the next quiz.

    HINT: Note how the output we get from the site is a multi-level JSON
    document, so try making print statements to step through the structure one
    level at a time or copy the output to a separate output file. Experimenting
    and iteration will be key to understand the structure of the data!
    """

    # Query for information in the database about bands named Nirvana
    results = query_by_name(ARTIST_URL, query_type["simple"], "Nirvana")
    pretty_print(results)

    # Isolate information from the 4th band returned (index 3)
    print "\nARTIST:"
    pretty_print(results["artists"][3])

    # Query for releases from that band using the artist_id
    artist_id = results["artists"][3]["id"]
    artist_data = query_site(ARTIST_URL, query_type["releases"], artist_id)
    releases = artist_data["releases"]

    # Print information about releases from the selected band
    print "\nONE RELEASE:"
    pretty_print(releases[0], indent=2)

    release_titles = [r["title"] for r in releases]
    print "\nALL TITLES:"
    for t in release_titles:
        print t

if __name__ == '__main__':
    main()