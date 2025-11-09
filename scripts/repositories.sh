#!/usr/bin/env bash

REPOSITORIES_RECENT=(
    "fsferrara/machines"
    "fsferrara/brain"
    "fsferrara/fsferrara.github.io"
    "fsferrara/sandbox"
    "fsferrara/fsferrara"
)

REPOSITORIES_ACTIVE=(
    "${REPOSITORIES_RECENT[@]}"
    "fsferrara/knowledge-worker-copilot-template"
    "fsferrara/modern-unix"
    "fsferrara/gha-learning"
    "fsferrara/private"
    "fsferrara/bricobravo-app"
    "fsferrara/tradurreantico-web"
    "fsferrara/tradurreantico-box"
)

REPOSITORIES_ARCHIVE=(
    "fsferrara/docusaurus-blog"
    "fsferrara/venere"
    "fsferrara/u-box"
    "fsferrara/heat"
    "fsferrara/machine-learning-coursera"
    "fsferrara/octopress-blog"
    "fsferrara/from-rest-to-graphql-meetup"
    "fsferrara/Greenhouses"
    "fsferrara/legacy-address-book"
    "fsferrara/wally"
    "fsferrara/fantacalcio"
    "fsferrara/turing-machines"
    "fsferrara/mpv955"
    "fsferrara/etna"
    "fsferrara/videoshots"
    "fsferrara/tableaux"
    "fsferrara/maruzzella"
    "fsferrara/strizza-paroline"
    "fsferrara/connect-four"
)

REPOSITORIES_ALL=("${REPOSITORIES_ACTIVE[@]}" "${REPOSITORIES_ARCHIVE[@]}")

