#![feature(exitcode_exit_method)]

use std::process::ExitCode;

#[tokio::main]
async fn main() {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        eprintln!("ERROR: getters takes exactly one argument, the URL.");
        ExitCode::FAILURE.exit_process();
    }
    let url = args.get(1).unwrap();

    let client = reqwest::Client::new();
    match client.get(url).send().await {
        Ok(_) => ExitCode::SUCCESS.exit_process(),
        Err(_) => ExitCode::FAILURE.exit_process(),
    };
}
