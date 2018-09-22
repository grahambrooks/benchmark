#![feature(plugin)]
#![plugin(rocket_codegen)]

extern crate rocket;
#[macro_use]
extern crate rocket_contrib;

use rocket_contrib::{Json, Value};
use std::collections::HashMap;
use std::vec::Vec;

#[get("/")]
fn framework() -> Json<Value> {
    let data: HashMap<&str, &str> =
        [("Hello", "World")]
            .iter().cloned().collect();
    Json(json!(data))
}

#[get("/")]
fn benchmark() -> Json<Value> {
    let mut vec = Vec::new();
    for i in 0..10000 {
        vec.push(format!("Index {}", i));
    }

    vec.truncate(10);
    let mut data = HashMap::new();
    data.insert("results", &vec);
    Json(json!(data))
}

fn main() {
    rocket::ignite()
        .mount("/framework", routes![framework])
        .mount("/benchmark", routes![benchmark])
        .launch();
}
