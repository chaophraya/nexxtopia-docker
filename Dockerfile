FROM node:6

MAINTAINER Yuthasak Tanruengsri<yuthasak.tanruengsri@zalando.de>

# Add scm-source script and generated scm-source.json
ADD scm-source.json /scm-source.json

RUN mkdir -p /opt/nexxtopia/storage

WORKDIR /opt/sinopia

# Install sinopia and necessary tools
RUN npm install nexxtopia --production

# Set default registry
RUN npm set registry http://localhost:4873/

# Add default config
ADD config.yaml /opt/nexxtopia/config.yaml

# Start the application
CMD ["/opt/nexxtopia/node_modules/nexxtopia/bin/nexxtopia"]

EXPOSE 4873

VOLUME /opt/nexxtopia/storage
