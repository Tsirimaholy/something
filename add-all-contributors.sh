#!/usr/bin/bash
# 'npx all-contributors check' will retrieve username of missing contributors
OUTPUT=$(npx all-contributors check)
UNECESSARYMSG="Missing contributors in .all-contributorsrc:"
# This is required to check if the previous cmd
# return all missing contrib or none was missed up
occurence=$(echo "$OUTPUT" | grep -c "$UNECESSARYMSG")

# check if someone is missing
if [[ $occurence -gt 0 ]]; then
    # delete unecessary msg and commas
    CONTRIBUTORS=$(echo "$OUTPUT" | sed -e "s/$UNECESSARYMSG//g" -e 's/,//g')
    echo "$UNECESSARYMSG."
    echo "I'll add them to list of contributors for you.😉"

    # add all missing contributors one by one to the list of contributors
    for PERSON in $CONTRIBUTORS; do
        echo adding @"$PERSON" to the list of contributors ...
        # the cmd that's will add the PERSON to the list of contributors
        # by default this person will be added to code as contribution
        npx all-contributors add "$PERSON" doc
    done
else
    echo "$OUTPUT"
fi