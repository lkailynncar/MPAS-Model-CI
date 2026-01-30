#!/usr/bin/env bash
#
# Script to interrogate and display the runtime environment
# Used by CI workflows to log environment details for debugging
#

set -e

echo "=== Working Directory ==="
pwd
ls

echo ""
echo "=== Directory Structure ==="
find -type d

echo ""
echo "=== Environment Variables ==="
env

echo ""
echo "=== Container Configuration ==="
cat /container/config_env.sh 2>/dev/null || echo "No container config found"

echo ""
echo "=== Disk Space ==="
df -h

echo ""
echo "=== OS Release ==="
cat /etc/os-release 2>/dev/null || echo "No os-release file found"

echo ""
echo "=== System Information ==="
uname -a

echo ""
echo "=== CPU Information ==="
lscpu

echo ""
echo "=== GPU Information ==="
nvidia-smi 2>/dev/null || echo "No NVIDIA GPU detected"

echo ""
echo "================================================================"
echo "=== Compiler Environment ==="
echo "================================================================"
echo ""
echo "CC=${CC}"
echo "CXX=${CXX}"
echo "FC=${FC}"
echo "F77=${F77}"
echo ""
echo "CFLAGS=${CFLAGS}"
echo "CPPFLAGS=${CPPFLAGS}"
echo "CXXFLAGS=${CXXFLAGS}"
echo "FCFLAGS=${FCFLAGS}"
echo "F77FLAGS=${F77FLAGS}"

echo ""
echo "=== Conda ==="
which conda 2>/dev/null && conda --version || echo "No conda in this container"

echo ""
echo "=== MPI Compiler ==="
which mpicc 2>/dev/null || echo "mpicc not found in PATH"
mpicc --version 2>/dev/null || true

echo ""
echo "=== Fortran Compiler ==="
which "${FC:-gfortran}" 2>/dev/null || true
${FC:-gfortran} --version 2>/dev/null || true

echo ""
echo "================================================================"
echo "=== Environment interrogation complete ==="
echo "================================================================"
