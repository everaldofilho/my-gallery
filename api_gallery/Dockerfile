FROM elixir:1.10.1
ENV MIX_ENV dev
WORKDIR /app
RUN mix local.hex --force && \
 mix archive.install hex phx_new 1.5.3 --force
#teste
COPY ./ /app
RUN mix deps.get --quiet
RUN mix local.rebar --force
RUN mix setup
EXPOSE 4000
CMD ["mix", "phx.server"]