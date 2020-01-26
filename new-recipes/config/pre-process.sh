for f in etc-spack/* module-setup/* spack.yaml ; do
  if [ ! -f "${f}" ] ; then
    continue
  fi
  sed -i 's@!!TARGETARCH!!@'"${TARGETARCH}"'@' "${f}"
  sed -i 's/!!CORECOMPILER!!/'"${CORECOMPILER}"'/' "${f}"
  sed -i 's@!!RCFILE!!@'"${RCFILE}"'@' "${f}"
done
