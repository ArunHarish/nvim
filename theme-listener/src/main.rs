use std::time::Duration;
extern crate dbus;

use dbus::blocking::{ Connection, Proxy };
use dbus::arg;

enum Theme {
    DARK,
    LIGHT,
}

fn retrieve_freedesktop_theme(conn: Connection) -> Result<Theme, dbus::Error> {
    let proxy = Proxy::new("org.freedesktop.portal.Desktop", "/org/freedesktop/portal/desktop", Duration::from_millis(5000), &conn);
    let result: (arg::Variant<Box<dyn arg::RefArg>>,) = proxy.method_call("org.freedesktop.portal.Settings", "Read", ("org.freedesktop.appearance", "color-scheme",))?;

    let theme_value = result.0.0.as_i64();
    if let Some(value) = theme_value {
        if value == 1 {
            Ok(Theme::DARK)
        } else {
            Ok(Theme::LIGHT)
        }
    } else {
        panic!("Unable to retrieve appearance information");
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let theme: Theme = if std::env::consts::OS == "linux" {
        let conn = Connection::new_session()?;
        retrieve_freedesktop_theme(conn)?
    } else if std::env::consts::OS == "macos" {
        Theme::LIGHT
    } else {
        Theme::LIGHT
    };

    match theme {
        Theme::DARK => {
            println!("dark");
        },
        Theme::LIGHT => {
            println!("light");
        }
    }

    Ok(())
}
