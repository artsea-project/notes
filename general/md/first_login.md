# First login mechanism ideas

## Frontend only site
We create a simple website that pulls the docker compose from some artifact from github CI or 
from a github raw link. The upstreamed docker compose contains a placeholder that 
should be replaced with a hash of the user's first password.

The user is presented with a nice UI with explanations and a password input field.

When the user enters the password and presses a "Generate" or whatever button,
the website hashses the password using some hashing function and replaces
the placeholder docker in the pulled docker compose.

Then the user can download the docker compose and proceed with instructions.

On further though I feel like this might sound good but be impossible to implement.
Assuming that we do not have a central hosting (which is the whole idea of this project),
the user would have to first upload a file to their chosen cloud provider and then run a command.
The command would be the same no matter what cloud provider would be chosen,
but the file upload workflow would change drastically.
A workflow that does not require the user to upload files for example by using some command like:
`curl github-raw-url | sh` would be easier to start.

Another downside I see is that in this scenario we are depended on that setup website working,
if it would not require a backend then hosting it on github pages is possible,
but it would still require some upkeep.

We could maybe adapt it to where the website would give a command like
`echo "password-hash > someTempFile && curl github-raw-url | sh`
So instead of generating docker compose, we would generate a command.

Upsides of the new approach:
1. The user starts in friendly UI
2. The user has to paste just one command in the terminal

The cloud setup is obviously still needed but it will be needed everywhere

Downsides:
1. Requires a central site, if it breaks the user wont be able to it
2. Loads of additional work and testing on making another website,
    it would be simpler but not easy.

## TUI

We still start with a command like
`curl github-raw-url | sh`
This would start some sort of TUI in the web terminal that would then ask for
the password and proceed with the setup.

Upsides:
1. Lack of a central site that would need to work for on boarding to start

Downsides:
1. TUI is less intuitive for a layperson
2. Most likely no mouse interactions, keyboard UI only
3. Simpler that a website, but it's still a UI that would require more testing

## CLI

We still start with a command like
`curl github-raw-url | sh`
But this time as one of the steps we do a simple
`echo "Enter your first password" && read ...`

Upsides:
1. Simple and fast to implement
2. No testing as there is nothing to break
3. No central site for the onboarding to start

Downsides:
1. This would probably look more intimidating to a layperson

## URL in CLI

We still start with a command like
`curl github-raw-url | sh`
At the end of the setup from the command we clear the screen an
display instructions and a first login URL with a long auth token,
so something like
`101.101.101:8080/first-login?auth=<insert a long random string here>`
Or a option with a domain if it exists for that IP

The user clicks or copies and opens the link and is presented with a friendly
first login page where they enter the password and proceed with the setup.

Upsides:
1. Stil one command
2. Friendly UI for the password part

Downsides:
1. Requires a lot of time to do and test
2. The user has to open some link from the cli




