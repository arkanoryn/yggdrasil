# Yggdrasil project - server
> The server will handle all backend operations: database connections, models changes, ...


## Foreword
This project is meant to be developed using **Vagrant**.
If you do not use the provided _Vagrant provision_, you are on your own would you have any version conflicts.

Please, read [Vagrant setup instructions]( ../vagrant.d/README.md ) to setup your development environment properly.


## Run the project
### Database configuration
If you are using the `Vagrant provision` given with this project, you should not have anything to do.

Otherwise, please make sure you adapt your database credentials with your own on: [apps/db/config/dev.exs](./apps/db/config/dev.exs)

### First time
```
$> cd root/server    # root is the root directory of this git repo
$> mix ecto.setup
```

`mix ecto.setup` will setup your database. Meaning it will:
* create the database
* create the tables
* populate the database with testing values (see [the seeds file](./apps/db/priv/repo/seeds.exs))


### Run the server

```
$> mix phoenix.server
```

You can also use `$> phoenix_server` which is an alias for `$> iex -S mix phoenix.server`.
Using `$> phoenix_server` allow you to run elixir commands on your console.


### Debugging
Here are the three functions I use most for debugging:

```
IO.puts str       # display str on std::out
IO.inspect obj    # display elements of a struct, map, list, ...
IEx.pry           # stop the execution at the given line
```

You restart the process of `IEx.pry` by running `respawn()` on the console.


## Accessing the website
The server is not a website. You can not access it with your browser.

You can make HTTP request, using HTTPoison, Curl or any other software on the following URL: `http://192.168.55.55:4000`.
You can modify this URL on the config from `root/server/apps/api`


## Architecture

### API
The API application is the entrypoint, also called endpoint, for the external world to access our datas.
It is an HTTP server using Phoenix Framework


### DB
DB is a interface.
It is not accessible from the outside. Apps under the umbrella (see elixir-umbrellas) can fetch or create data by calling it via messages.

The current way is to call:
`DB.Provider.Absence.reply/2` to access absences datas.


The Database is build using [GraphQL]( "graphql.org" ).
Visit the [learn section]( "graphql.org/learn" ) to know more about requests and answers.


### Business Logic
The application is cut in multiple applications.
Each applications, like `Absence`, will be responsible to handle one aspect of the Server Business Logic.
We expect it to handle his work well, by being fast, reliable, concurrent and consistent.


## Testing
Each part of the code should have its own testing suite. (_Author note: LoOl!_)
