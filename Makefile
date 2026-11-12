# Every build goes through sccache: an uncached build is the slow path nobody measures. An
# exported RUSTC_WRAPPER (another sccache path) wins; without sccache, make stops.
RUSTC_WRAPPER ?= $(shell command -v sccache 2>/dev/null)
ifeq ($(strip $(RUSTC_WRAPPER)),)
$(error sccache not found: `cargo install sccache`)
endif
export RUSTC_WRAPPER
# No incremental cache under make: it is kept per crate and feature set, never collected, and
# sccache cannot cache it. rust-analyzer and a bare `cargo` keep theirs.
export CARGO_INCREMENTAL ?= 0

SHELL=/bin/bash
CARGO=cargo

all: deps build

.PHONY: deps
deps:
		${CARGO} fetch

.PHONY: clean
clean:
		rm -rf target/

.PHONY: fix
fix:
		${CARGO} fix --allow-dirty
		${CARGO} clippy --fix --allow-dirty
		${CARGO} fmt --all

.PHONY: format-fix
format-fix:
		${CARGO} fmt --all

.PHONY: format-check
format-check:
		${CARGO} fmt --check

.PHONY: build
build:
		time ${CARGO} build

.PHONY: build-release
build-release:
		time ${CARGO} build --release

.PHONY: test
test:
		time RUST_BACKTRACE=full ${CARGO} test -v -- --nocapture
