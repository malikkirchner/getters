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
