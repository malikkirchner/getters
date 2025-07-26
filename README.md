# Getters

`getters` is a simple HTTP GET health check tool. It sends a GET request to a given URL and exits with a status code depending on the result. This makes it ideal for use in shell scripts and service monitoring.

## Build Instructions

This project is written in Rust and uses [Tokio](https://tokio.rs/) and [reqwest](https://docs.rs/reqwest/).

1. **Clone the repository:**

   ```bash
   git clone https://github.com/malikkirchner/getters.git
   cd getters
   ```

2. **Build the binary (debug mode):**

   ```bash
   cargo build
   ```

3. **(Optional) Build in release mode for a smaller, optimized binary:**

   ```bash
   cargo build --release
   ```

The resulting binary will be located in:

* `./target/debug/getters` (debug)
* `./target/release/getters` (release)

## Usage

```bash
getters <URL>
```

* **URL**: The full HTTP/HTTPS URL to send a GET request to.

The program will:

* Exit with **0 (success)** if the request completes successfully.
* Exit with **1 (failure)** if the request fails for any reason.

## Example

You can use `getters` in a shell script to check if a service is up:

```bash
getters https://google.com && echo "ok" || echo "kaputt"
```

* If the GET request succeeds:

  ```txt
  ok
  ```

* If the GET request fails:

  ```txt
  kaputt
  ```

## Notes

* Requires Rust nightly (uses `#![feature(exitcode_exit_method)]`).
* Built on top of async Rust using Tokio and reqwest.
* Perfect for Docker health checks, CI/CD pipelines, or lightweight uptime monitoring.
