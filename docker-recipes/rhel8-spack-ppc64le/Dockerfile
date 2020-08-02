ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG SPACK_ROOT

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG SPACK_ROOT

COPY e4s.pub /

RUN mkdir ${SPACK_ROOT} \
 && cd ${SPACK_ROOT} \
 && git init \
 && git remote add origin ${SPACK_REPO} \
 && git fetch --depth=1 origin ${SPACK_REPO_REF} \
 && git reset --hard FETCH_HEAD \
 && cd / \
 && . ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack gpg trust /e4s.pub \
 && spack mirror add e4s https://cache.e4s.io/e4s \
 && sed -i '$ d' /entrypoint.sh \
 && echo ". ${SPACK_ROOT}/share/spack/setup-env.sh" >> /entrypoint.sh \
 && echo exec \"'$@'\" >> /entrypoint.sh

LABEL io.e4s.spack.spack-repo=${SPACK_REPO}
LABEL io.e4s.spack.spack-repo-ref=${SPACK_REPO_REF}
LABEL io.e4s.spack.build-date=${BUILD_DATE}
LABEL io.e4s.spack.repo=${BUILD_REPO}
LABEL io.e4s.spack.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.spack.base-img=${BASE_IMAG}
