ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG COMPILER_FROM_SYSTEM
ARG COMPILER_FROM_SPACK
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG SPACK_ROOT

FROM ${BASE_IMAGE} as stage0

ARG BASE_IMAGE
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG SPACK_ROOT

COPY e4s.pub /
COPY spack.yaml /

RUN mkdir ${SPACK_ROOT} \
 && cd ${SPACK_ROOT} \
 && git init \
 && git remote add origin ${SPACK_REPO} \
 && git fetch origin ${SPACK_REPO_REF} \
 && git reset --hard FETCH_HEAD \
 && cd / \
 && . ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack gpg trust /e4s.pub \
 && spack -e . install --cache-only \
 && spack -e . install patchelf \
 && spack clean -a \
 && rm -rf /tmp/root/spack-stage

RUN . ${SPACK_ROOT}/share/spack/setup-env.sh \
 && echo '#!/bin/bash -e' > /entrypoint.sh \
 && spack env activate --sh -d . | sed '/SPACK_ENV/d' >> /entrypoint.sh \
 && echo exec \"'$@'\" >> /entrypoint.sh \
 && chmod +x /entrypoint.sh

FROM ${BASE_IMAGE}

ARG BASE_IMAGE
ARG BUILD_DATE
ARG BUILD_REPO
ARG BUILD_REPO_REF
ARG SPACK_REPO
ARG SPACK_REPO_REF
ARG COMPILER_FROM_SPACK
ARG COMPILER_FROM_SYSTEM

COPY --from=stage0 /opt/software /opt/software
COPY --from=stage0 /opt/view /opt/view
COPY --from=stage0 /entrypoint.sh /entrypoint.sh

LABEL io.e4s.runner.spack-repo=${SPACK_REPO}
LABEL io.e4s.runner.spack-repo-ref=${SPACK_REPO_REF}
LABEL io.e4s.runner.build-date=${BUILD_DATE}
LABEL io.e4s.runner.repo=${BUILD_REPO}
LABEL io.e4s.runner.repo-ref=${BUILD_REPO_REF}
LABEL io.e4s.runner.base-img=${BASE_IMAGE}
LABEL io.e4s.runner.compiler-from-spack=${COMPILER_FROM_SPACK}
LABEL io.e4s.runner.compiler-from-system=${COMPILER_FROM_SYSTEM}

CMD ["/bin/bash"]
ENTRYPOINT ["/entrypoint.sh"]
