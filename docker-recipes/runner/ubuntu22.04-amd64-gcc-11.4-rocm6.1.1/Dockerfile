FROM ecpe4s/ubuntu22.04-runner-amd64-gcc-11.4:2024.03.01

# https://rocm.docs.amd.com/en/latest/deploy/linux/installer/install.html
RUN rm -f /usr/include/asm \
 && rm -f /usr/include/bits \
 && rm -f /usr/include/gnu \
 && rm -f /usr/include/sys \
 && apt update -y \
 && wget -q https://repo.radeon.com/amdgpu-install/6.1.1/ubuntu/jammy/amdgpu-install_6.1.60101-1_all.deb \
 && apt install -y ./amdgpu-install_6.1.60101-1_all.deb \
 && rm -f ./amdgpu-install_6.1.60101-1_all.deb \
 && amdgpu-install -y --usecase=rocm,rocmdev,hip,hiplibsdk,mllib,mlsdk --rocmrelease=6.1.1 --no-dkms \
 && apt clean -y

RUN apt update -y \
 && apt install -y rocm-llvm-dev

RUN echo /opt/rocm/lib > /etc/ld.so.conf.d/rocm.conf \
 && ldconfig -v

RUN echo export PATH=/opt/rocm/bin:'$PATH' >> /etc/bash.bashrc
ENV PATH=/opt/rocm/bin:$PATH

RUN updatedb
