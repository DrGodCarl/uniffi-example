use pure_rust;
use tiny_lib::TinyLibType;

uniffi::include_scaffolding!("rust");

pub fn hello_rust(_param: TinyLibType) {
    pure_rust::hello_rust();
}
