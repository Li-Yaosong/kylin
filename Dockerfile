FROM liyaosong/debootstrap AS build

USER root

RUN debootstrap --variant minbase \
    --no-check-gpg 10.1 \
    kylint-v10.1 \
    http://archive.kylinos.cn/kylin/KYLIN-ALL \
    gutsy

RUN chroot kylint-v10.1 apt-get update
RUN chroot kylint-v10.1 apt-get upgrade -y
RUN chroot kylint-v10.1 apt-get autoremove -y
RUN chroot kylint-v10.1 apt-get clean
RUN rm -rf \
    kylint-v10.1/var/lib/apt/lists/* \
    kylint-v10.1/tmp/* \
    kylint-v10.1/var/tmp/* \
    kylint-v10.1/root/.cache \
    kylint-v10.1/var/cache/apt/archives/*.deb \
    kylint-v10.1/var/cache/apt/*.bin \
    kylint-v10.1/var/lib/apt/lists/* \
    kylint-v10.1/usr/share/*/*/*/*.gz \
    kylint-v10.1/usr/share/*/*/*.gz \
    kylint-v10.1/usr/share/*/*.gz \
    kylint-v10.1/usr/share/doc/*/README* \
    kylint-v10.1/usr/share/doc/*/*.txt \
    kylint-v10.1/usr/share/locale/*/LC_MESSAGES/*.mo 


FROM scratch

LABEL maintainer="liyaosong <liyaosong1@qq.com>"
LABEL version=v10.1
LABEL description="kylin V10.1 SP1."

COPY --from=build /kylint-v10.1 /

CMD ["bash"]
