FROM elixir:1.10.1
ENV MIX_ENV dev
ENV HOST_GALLERY_API=http://api-gallery:4000
ENV AWS_ACCESS_KEY_ID=AKIAI6KGTDVSQKLPWBEQ
ENV AWS_SECRET_ACCESS_KEY=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
ENV BUCKET_NAME=criativoweb-bucket
WORKDIR /app
RUN mix local.hex --force && \
 mix archive.install hex phx_new 1.5.3 --force
COPY ./ /app
RUN mix deps.get
EXPOSE 4000
CMD [ "mix","phx.server"]