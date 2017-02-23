#!/usr/bin/env bats
# *-*- Mode: sh; sh-basic-offset: 8; indent-tabs-mode: nil -*-*

#  This file is part of cc-oci-runtime.
#
#  Copyright (C) 2016 Intel Corporation
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

#Based on docker commands

SRC="${BATS_TEST_DIRNAME}/../../lib/"

setup() {
	source $SRC/test-common.bash
	clean_docker_ps
	runtime_docker
}

@test "Inspect a container ip address" {
	$DOCKER_EXE run -ti -d --name container1 busybox
	$DOCKER_EXE inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container1
}

@test "Inspect a container with json format" {
	$DOCKER_EXE run -ti -d --name container2 busybox
	$DOCKER_EXE inspect --format='{{json .Config}}' container2
}

@test "Inspect a container to get instance's log path" {
	$DOCKER_EXE run -ti -d --name container3 busybox
	$DOCKER_EXE inspect --format='{{.LogPath}}' container3
}