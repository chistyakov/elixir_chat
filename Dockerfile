FROM bitwalker/alpine-elixir-phoenix:latest

EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod

COPY mix.exs ./
RUN mix do deps.get, deps.compile

COPY assets/package.json assets/package-lock.json assets/brunch-config.js assets/
RUN cd assets && \
    npm install && \
    npm run deploy

COPY . .

ENTRYPOINT ["./entrypoint.sh"]
