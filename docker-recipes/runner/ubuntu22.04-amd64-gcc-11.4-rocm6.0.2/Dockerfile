FROM ecpe4s/ubuntu22.04-runner-amd64-gcc-11.4:2024.03.01

# https://rocm.docs.amd.com/en/latest/deploy/linux/installer/install.html
RUN rm -f /usr/include/asm \
 && rm -f /usr/include/bits \
 && rm -f /usr/include/gnu \
 && rm -f /usr/include/sys \
 && apt update -y \
 && wget -q https://repo.radeon.com/amdgpu-install/6.0.2/ubuntu/jammy/amdgpu-install_6.0.60002-1_all.deb \
 && apt install -y ./amdgpu-install_6.0.60002-1_all.deb \
 && rm -f ./amdgpu-install_6.0.60002-1_all.deb \
 && amdgpu-install -y --usecase=rocm,hip,hiplibsdk,mllib,mlsdk --rocmrelease=6.0.2 --no-dkms \
 && apt clean -y

RUN echo /opt/rocm/lib > /etc/ld.so.conf.d/rocm.conf \
 && ldconfig -v

RUN updatedb
