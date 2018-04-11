#!/bin/bash

xhost +

			# --rm \
docker run --interactive \
			--tty \
			--env DISPLAY=unix${DISPLAY} \
			--volume /tmp/.X11-unix:/tmp/.X11-unix \
			--volume ~/projects:/projects \
			--name intellij \
			intellij