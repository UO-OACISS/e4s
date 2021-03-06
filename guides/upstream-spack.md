### Connect a New Spack to an Old Spack
#### How to use the features of a New Spack while keeping your favorite Old Spack packages
<br>

0. Start in $HOME
```
$> cd
```

1. Clone <b>New Spack</b>
```
$> git clone https://github.com/spack/spack.git
```

<br>

2. Launch <b>E4S Singularity Image</b>
```
$> singularity exec --nv e4s_ubuntu1804_gpu_ppc64le_1.1.simg /bin/bash
```

<br>

3. Get the <b>Old Spack</b> prefix:
```
Singularity> export OLD_SPACK_PREFIX=$SPACK_ROOT
```

<br>

4. Source the <b>setup script</b> for New Spack
```
Singularity> . spack/share/spack/setup-env.sh
```

<br>

5. <b>Connect</b> New Spack to Old Spack ( <i>upstreams: https://spack.readthedocs.io/en/latest/chain.html</i> )
```
Singularity> mkdir -p ~/.spack
Singularity> cat > ~/.spack/upstreams.yaml << EOF
upstreams:
  e4s:
    install_tree: $OLD_SPACK_PREFIX/opt/spack
EOF
```


<br>

You can now use all the features of New Spack while keeping your favorite Old Spack packages!
