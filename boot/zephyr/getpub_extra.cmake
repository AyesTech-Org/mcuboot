# Copyright (c) 2026 AyesTech
# SPDX-License-Identifier: Apache-2.0
#
# imgtool getpub for an extra key of CONFIG_BOOT_SIGNATURE_KEY_FILE_EXTRA, with
# the C symbols renamed (ecdsa_pub_key -> ecdsa_pub_key_<n>) so that several
# keys can be linked into one image.
#   cmake -DPYTHON=... -DIMGTOOL=... -DKEY=... -DSUFFIX=_1 -DOUT=... -P getpub_extra.cmake

execute_process(
  COMMAND ${PYTHON} ${IMGTOOL} getpub -k ${KEY}
  OUTPUT_VARIABLE pubkey
  RESULT_VARIABLE rc
)
if(NOT rc EQUAL 0)
  message(FATAL_ERROR "imgtool getpub failed for ${KEY} (${rc})")
endif()
string(REGEX REPLACE "([a-z0-9]+)_pub_key" "\1_pub_key${SUFFIX}" pubkey "${pubkey}")
file(WRITE ${OUT} "${pubkey}")
