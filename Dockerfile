FROM elixir:1.6.2-slim

RUN apt-get update && apt-get -y install git
RUN mix local.hex --force
RUN mix local.rebar --force

WORKDIR /code

COPY ./mix.exs /code/

ENV MIX_ENV prod
RUN mix deps.get
RUN mix deps.compile

COPY . /code

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["run"]
