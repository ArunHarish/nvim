use std::time::Duration;
extern crate dbus;

use dbus::blocking::{ Connection, Proxy };
use dbus::{ arg, Message };

enum Theme {
    DARK,
    LIGHT,
}

pub struct OrgFreeDesktopPortalDesktop {
    pub sender: String,
    pub key: String,
    pub value: Variant<Box<dyn arg::RefArg>>,
}

impl arg::AppendAll for OrgFreeDesktopPortalDesktop {
    fn append(&self, i: &mut arg::IterAppend) {
        arg::RefArg::append(&self.sender, i);
    }
}

impl arg::ReadAll for OrgFreeDesktopPortalDesktop {
    fn read(i: &mut arg::Iter) -> Result<Self, arg::TypeMismatchError> {
        Ok(OrgFreeDesktopPortalDesktop {
            sender: i.read()?,
            key: i.read()?,
            value: i.read()?,
        })
    }
}

impl dbus::message::SignalArgs for OrgFreeDesktopPortalDesktop {
    const NAME: &'static str = "SettingChanged";
    const INTERFACE: &'static str = "org.freedesktop.portal.Settings";
}

fn signal_listen_freedesktop_theme() -> Result<bool, dbus::Error> {
    let connection = Connection::new_session()?;
    let proxy = connection.with_proxy("org.freedesktop.portal.Desktop", "/org/freedesktop/portal/desktop", Duration::from_millis(5000));

    let _ = proxy.match_signal(|h: OrgFreeDesktopPortalDesktop, _: &Connection, _: &Message| {
        if h.sender == "org.freedesktop.appearance" && h.key == "color-scheme" {
            println!("Sender {} {}", h.sender, h.key);
        }
        true
    });

    loop { connection.process(Duration::from_millis(1000))?; }
}

fn retrieve_freedesktop_theme() -> Result<Theme, dbus::Error> {
    let conn = Connection::new_session()?;
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

fn output_theme(theme: Theme) {
    match theme {
        Theme::DARK => {
            println!("dark");
        }
        Theme::LIGHT => {
            println!("light");
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    if std::env::consts::OS == "linux" {
        let theme = retrieve_freedesktop_theme()?;
        output_theme(theme);
        signal_listen_freedesktop_theme()?;
    } else if std::env::consts::OS == "macos" {
        output_theme(Theme::LIGHT);
    } else {
        output_theme(Theme::DARK);
    };

    Ok(())
}
