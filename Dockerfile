# named portage image#
FROM gentoo/portage:latest as portage
FROM gentoo/stage3:latest

COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

# configure portage
RUN echo -e '\n\
# custom\n\
MAKEOPTS="-j10"\n\
EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --jobs=10 --load-average=8"\n\
GENTOO_MIRRORS="https://mirror.bytemark.co.uk/gentoo/"' >> /etc/portage/make.conf && \
# install crossdev and distcc
	emerge --quiet	app-editors/vim \
			sys-devel/crossdev \
			sys-devel/distcc && \
                	rm -rf /usr/portage/distfiles/*
