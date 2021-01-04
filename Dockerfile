# 
FROM gentoo/portage:latest as portage
LABEL maintainer="Stephen Checkoway <s@pahtak.org>"
FROM gentoo/stage3-amd64:latest
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo
RUN emerge dev-libs/libxml2 dev-lang/ruby \
	&& gem install bundler \
	&& rm -rf /usr/portage \
	&& useradd -m -s /bin/bash user
USER user
WORKDIR /home/user
CMD ["/bin/bash"]
