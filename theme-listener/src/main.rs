use std::time::Duration;
extern crate dbus;

use dbus::arg::{ RefArg, Variant };
use dbus::blocking::{ Connection, Proxy };
use dbus::{ arg, Message };

pub struct OrgFreeDesktopPortalDesktop {
    pub sender: String,
    pub key: String,
    pub value: Variant<Box<dyn RefArg>>,
}

impl arg::AppendAll for OrgFreeDesktopPortalDesktop {
    fn append(&self, i: &mut arg::IterAppend) {
        RefArg::append(&self.sender, i);
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
            let theme = h.value.as_i64();
            try_output_theme(theme);
        }
        true
    });

    loop { connection.process(Duration::from_millis(1000))?; }
}

fn retrieve_freedesktop_theme() -> Result<bool, dbus::Error> {
    let conn = Connection::new_session()?;
    let proxy = Proxy::new("org.freedesktop.portal.Desktop", "/org/freedesktop/portal/desktop", Duration::from_millis(5000), &conn);
    let result: (Variant<Box<dyn RefArg>>,) = proxy.method_call("org.freedesktop.portal.Settings", "Read", ("org.freedesktop.appearance", "color-scheme",))?;

    let theme = result.0.0.as_i64();
    try_output_theme(theme);
    Ok(true)
}

fn try_output_theme(theme_value: Option<i64>) {
    if let Some(value) = theme_value {
        if value == 1 {
            println!("dark");
        } else {
            println!("light");
        }
    } else {
        panic!("Unable to retrieve appearance information");
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    if std::env::consts::OS == "linux" {
        retrieve_freedesktop_theme()?;
        signal_listen_freedesktop_theme()?;
    } else if std::env::consts::OS == "macos" {
        try_output_theme(Some(1));
    } else {
        try_output_theme(Some(1));
    };

    Ok(())
}
