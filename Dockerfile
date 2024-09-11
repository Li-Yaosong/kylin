FROM liyaosong/debootstrap AS build

USER root
RUN debootstrap \
    --components main,universe,multiverse,restricted \
    --variant minbase \
    --exclude bash \
    --no-check-gpg 10.1 kylin-v10.1 http://archive.kylinos.cn/kylin/KYLIN-ALL gutsy

RUN chroot kylin-v10.1 apt-get update
RUN chroot kylin-v10.1 apt-get upgrade -y
RUN chroot kylin-v10.1 apt-get autoremove -y
RUN chroot kylin-v10.1 apt-get clean
RUN rm -rf \
    kylin-v10.1/var/lib/apt/lists/* \
    kylin-v10.1/tmp/* \
    kylin-v10.1/var/tmp/* \
    kylin-v10.1/root/.cache \
    kylin-v10.1/var/cache/apt/archives/*.deb \
    kylin-v10.1/var/cache/apt/*.bin \
    kylin-v10.1/var/lib/apt/lists/* \
    kylin-v10.1/usr/share/*/*/*/*.gz \
    kylin-v10.1/usr/share/*/*/*.gz \
    kylin-v10.1/usr/share/*/*.gz \
    kylin-v10.1/usr/share/doc/*/README* \
    kylin-v10.1/usr/share/doc/*/*.txt \
    kylin-v10.1/usr/share/locale/*/LC_MESSAGES/*.mo 


FROM scratch

LABEL maintainer="liyaosong <liyaosong1@qq.com>"
LABEL version=v10.1
LABEL description="kylin V10.1 SP1."

COPY --from=build /kylin-v10.1 /

CMD ["bash"]
