use std::process::ExitCode;

#[tokio::main]
async fn main() -> ExitCode {
    let args: Vec<String> = std::env::args().collect();
    if args.len() != 2 {
        eprintln!("ERROR: getters takes exactly one argument, the URL.");
        return ExitCode::FAILURE;
    }
    let url = args.get(1).unwrap();

    let client = reqwest::Client::new();
    match client.get(url).send().await {
        Ok(_) => ExitCode::SUCCESS,
        Err(_) => ExitCode::FAILURE,
    }
}
