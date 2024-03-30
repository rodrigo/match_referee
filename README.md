# Match Referee

Match Referee is a rails project that uses sidekiq to process Quake logs and distribute then through API.

# Getting started
## Requirements
[docker compose](https://docs.docker.com/compose/install/)

## Installing
Run the follow command on the application folder:
`docker compose build`

## Testing
You can ran the rspec tests with the following command:
`docker compose run web bundle exec rspec`

# Utilization
## Consuming logs
The log files are stored on the [/log_files](/log_files) folder. Once the application is up, Sidekiq will schedule a `LogParserJob` for the next minute. This job iterate through all log files existing, persisting the relevant logs on database and excluding the files after that.
You can check if the job ran by looking for a similar message on your terminal:
![Screenshot from 2024-03-30 13-47-56](https://github.com/rodrigo/match_referee/assets/20539146/e2af7896-6e6f-4602-bf9e-f11b2092ca54)
Or you can check on the `/sidekiq` endopoint, the the "processed" jobs if there is already one job processed:
![Screenshot from 2024-03-30 13-52-23](https://github.com/rodrigo/match_referee/assets/20539146/bb97017d-0934-4528-a0da-616a174d1e07)

## API
With the app running, you can check the endpoint `/api-docs` to see the documentation of the api.
