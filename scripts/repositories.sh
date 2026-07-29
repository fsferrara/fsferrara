#!/usr/bin/env bash

REPOSITORIES_RECENT=(
    "fsferrara/brain"
    "fsferrara/fsferrara.github.io"
    "fsferrara/fsferrara"
    "fsferrara/machines"
    "fsferrara/private"
)

REPOSITORIES_ACTIVE=(
    "${REPOSITORIES_RECENT[@]}"
    "fsferrara/agentic-engineering"
    "fsferrara/sandbox"
)

REPOSITORIES_ARCHIVE=(
    "fsferrara/pkm-agent-vault"
    "fsferrara/modern-unix"
    "fsferrara/gha-learning"
    "fsferrara/bricobravo-app"
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
    "fsferrara/tradurreantico-web"
    "fsferrara/tradurreantico-box"
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
