FROM elixir:1.10.1
ENV MIX_ENV dev
ENV HOST_GALLERY_API=http://api-gallery:4000
ENV AWS_ACCESS_KEY_ID=You-Key
ENV AWS_SECRET_ACCESS_KEY=You-Secret
ENV BUCKET_NAME=criativoweb-bucket
WORKDIR /app
RUN mix local.hex --force && \
 mix archive.install hex phx_new 1.5.3 --force
COPY ./ /app
RUN mix deps.get
EXPOSE 4000
CMD [ "mix","phx.server"]