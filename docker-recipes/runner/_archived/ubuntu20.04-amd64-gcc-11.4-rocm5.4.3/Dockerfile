FROM ecpe4s/ubuntu20.04-runner-x86_64-gcc-11.4:2023.08.01

RUN rm -f /usr/include/asm \
 && rm -f /usr/include/bits \
 && rm -f /usr/include/gnu \
 && rm -f /usr/include/sys \
 && wget https://repo.radeon.com/amdgpu-install/5.4.3/ubuntu/focal/amdgpu-install_5.4.50403-1_all.deb \
 && apt install -y ./amdgpu-install_5.4.50403-1_all.deb \
 && rm -f ./amdgpu-install_5.4.50403-1_all.deb \
 && echo 'deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/rocm-keyring.gpg] https://repo.radeon.com/amdgpu/5.4.3/ubuntu focal main' | tee /etc/apt/sources.list.d/rocm.list \
 && echo 'deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/rocm-keyring.gpg] https://repo.radeon.com/rocm/apt/5.4.3 focal main' | tee /etc/apt/sources.list.d/rocm.list \
 && apt update -y \
 && amdgpu-install -y --usecase=rocm,hip,hiplibsdk,mllib,mlsdk --rocmrelease=5.4.3 --no-dkms \
 && apt clean -y \
 && echo /opt/rocm/lib > /etc/ld.so.conf.d/rocm.conf \
 && ldconfig -v

RUN rm /usr/bin/python \
 && ln -s /usr/bin/python3 /usr/bin/python

RUN echo /opt/rocm/lib > /etc/ld.so.conf.d/rocm.conf \
 && ldconfig -v

RUN updatedb