# 
FROM gentoo/portage:latest as portage
LABEL maintainer="Stephen Checkoway <s@pahtak.org>"
FROM gentoo/stage3-amd64:latest
COPY --from=portage /usr/portage /usr/portage
RUN emerge dev-libs/libxml2 dev-lang/ruby \
	&& gem install bundler \
	&& rm -rf /usr/portage \
	&& useradd -m -s /bin/bash user
USER user
WORKDIR /home/user
ENTRYPOINT ["/bin/bash", "-c", "bundle install --path vendor/bundle && exec bundle exec rake -- \"$@\""]
