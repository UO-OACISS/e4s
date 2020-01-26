FROM ecpe4s/centos7-x86_64:0.13.3-new

COPY /etc-spack/ /etc/spack

ARG E4S_MIRROR=https://instinct.nic.uoregon.edu:8083/e4s

COPY spack.yaml /base-env/
WORKDIR /base-env

RUN wget http://oaciss.uoregon.edu/e4s/e4s.pub \
 && spack gpg trust e4s.pub \
 && spack mirror add E4S ${E4S_MIRROR} \
 && spack install --cache-only gcc \
 && spack compiler add `spack location -i gcc` \
 && spack install --cache-only \
 && spack clean -a && rm -rf /tmp/root/spack-stage

COPY module-setup /module-setup
WORKDIR /module-setup

RUN ./setup.sh \
 && rm -rf /module-setup

WORKDIR /
