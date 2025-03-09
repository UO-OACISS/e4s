FROM ecpe4s/manylinux2014:2024.03.11

ENV BOOTSTRAP_DIR=/usr/local/spack-tools

COPY /spack.yaml /spack.yaml.pre
COPY /spack.lock /concretize.log /

RUN yum -y install gettext \
 && envsubst < spack.yaml.pre > spack.yaml \
 && rm spack.yaml.pre \
 && yum -y remove gettext

RUN export S=/tmp/spack \
 && git clone https://github.com/spack/spack $S \
 && git -C $S checkout 7e906ced75dead665048a254c0ca2f09205c9d47 \
 && . $S/share/spack/setup-env.sh \
 && export SPACK_DISABLE_LOCAL_CONFIG=1 \
 && spack config add 'config:build_stage:$spack/build_stage' \
 && spack config add "config:db_lock_timeout:120" \
 && spack config add "config:connect_timeout:60" \
 && spack mirror add bootstrap https://cache.e4s.io/spack-bootstrap \
 && spack buildcache keys -it \
 && spack -e . install --cache-only \ 
 && spack clean -a \
 && rm -rf $S spack.yaml spack.lock concretize.log .spack-env Makefile ~/.spack

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip

RUN echo export PATH=$BOOTSTRAP_DIR/view/bin:'${PATH}' >> /etc/bash.bashrc

ENV PATH=$BOOTSTRAP_DIR/view/bin:$PATH
