#![no_std]
#![no_main]

use ruduino::cores::current::port::B5 as LED_BUILTIN;
use ruduino::{delay::delay_ms, Pin};

#[no_mangle]
pub extern "C" fn main() {
    LED_BUILTIN::set_output();

    loop {
        // turn on, wait 1s
        LED_BUILTIN::set_high();
        delay_ms(1000);

        // turn off, wait 1s
        LED_BUILTIN::set_low();
        delay_ms(1000);
    }
}
