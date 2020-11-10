#!/bin/bash
RCCL_INSTALL=../../build/release
EXE=$PWD/HelloRccl
LDPATH=$LD_LIBRARY_PATH:$RCCL_INSTALL

echo "Single process - With clique-based kernels:"
RCCL_CLIQUE_ALLREDUCE_BYTE_LIMIT=1073741824 RCCL_FORCE_ENABLE_CLIQUE=1 NCCL_DEBUG=INFO RCCL_ENABLE_CLIQUE=1 LD_LIBRARY_PATH=$LDPATH $EXE 4

echo "Single process - Without clique-based kernels:"
NCCL_DEBUG=INFO LD_LIBRARY_PATH=$LDPATH $EXE 4

echo "With clique-based kernels:"
RCCL_CLIQUE_ALLREDUCE_BYTE_LIMIT=1073741824 RCCL_FORCE_ENABLE_CLIQUE=1 NCCL_DEBUG=INFO RCCL_ENABLE_CLIQUE=1 NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 0 &
RCCL_CLIQUE_ALLREDUCE_BYTE_LIMIT=1073741824 RCCL_FORCE_ENABLE_CLIQUE=1 NCCL_DEBUG=INFO RCCL_ENABLE_CLIQUE=1 NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 1 &
RCCL_CLIQUE_ALLREDUCE_BYTE_LIMIT=1073741824 RCCL_FORCE_ENABLE_CLIQUE=1 NCCL_DEBUG=INFO RCCL_ENABLE_CLIQUE=1 NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 2 &
RCCL_CLIQUE_ALLREDUCE_BYTE_LIMIT=1073741824 RCCL_FORCE_ENABLE_CLIQUE=1 NCCL_DEBUG=INFO RCCL_ENABLE_CLIQUE=1 NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 3

echo "Without clique-based kernels:"
NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 0 &
NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 1 &
NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 2 &
NCCL_COMM_ID=$HOSTNAME:12345 LD_LIBRARY_PATH=$LDPATH $EXE 4 3
