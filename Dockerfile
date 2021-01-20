FROM elixir:1.10.1
RUN mix local.hex --force && \
 mix archive.install hex phx_new 1.5.3 --force
# EXPOSE 400
# CMD ["mix", "phx.server"]