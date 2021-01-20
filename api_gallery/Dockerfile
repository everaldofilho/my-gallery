FROM elixir:1.10.1
ENV MIX_ENV dev
WORKDIR /app
RUN mix local.hex --force && \
 mix archive.install hex phx_new 1.5.3 --force
COPY ./ /app
RUN mix deps.get
EXPOSE 400
CMD ["mix", "phx.server"]