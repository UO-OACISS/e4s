FROM ecpe4s/ubuntu22.04-runner-amd64-gcc-11.4:2025.03.01

# https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html
RUN rm -f /usr/include/asm \
 && rm -f /usr/include/bits \
 && rm -f /usr/include/gnu \
 && rm -f /usr/include/sys \
 && apt update -y \
 && apt install -y python3-setuptools python3-wheel libpython3.10 \
 && wget -q https://repo.radeon.com/amdgpu-install/6.3.3/ubuntu/jammy/amdgpu-install_6.3.60303-1_all.deb \
 && apt install -y ./amdgpu-install_6.3.60303-1_all.deb \
 && rm -f ./amdgpu-install_6.3.60303-1_all.deb \
 && amdgpu-install -y --usecase=rocm,rocmdev,hip,hiplibsdk,mllib,mlsdk --rocmrelease=6.3.3 --no-dkms \
 && apt clean -y

RUN apt update -y \
 && apt install -y rocm-llvm-dev6.3.3 \
 && apt clean -y

RUN echo /opt/rocm/lib > /etc/ld.so.conf.d/rocm.conf \
 && ldconfig -v

RUN echo export PATH=/opt/rocm/bin:'$PATH' >> /etc/bash.bashrc
ENV PATH=/opt/rocm/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/rocm/lib:$PATH

RUN updatedb
