# Play-BTc
Play "Binary Time constant" Sound on the Apple II

The _BTc Sound Compression Algorithm_ is decribed on https://www.romanblack.com/btc_alg.htm. On https://www.romanblack.com/picsound.htm there's the _BTc Sound Encoder 3.0_.

Play-BTc plays .btc files created by the BTc Sound Encoder on the Apple II. However, certain settings in the BTc Sound Encoder are necessary:
* The __Algorithm__ needs to be set to __1 bit__.
* The __Frequency__ needs to be __33000Hz__ (use _Resample .WAV_ if necessary).
* The number of __Samples__ mustn't exeed __362500__ (use _Trim .WAV_ if necessary).

To built Play-BTc:
* Get [cc65](http://cc65.github.io/cc65/)
* Enter `cl65 -C play-btc.cfg play-btc.s`

To run Play-BTc:
* Put _play-btc_ on a ProDOS disk as the BIN file __PLAY.BTC__ with start address __$800__ 
* Put _path_to_cc65/target/apple2/util/loader.system_ on the ProDOS disk as the SYS file __PLAY.BTC.SYSTEM__
* Run __PLAY.BTC.SYSTEM__

The player loop is based on cycle counting. The slowest loop variant is when the reader needs to switch from the current memory page to the next. 31 cycles is the fastest I could come up with for that variant. The two other variants (just using the next bit from the current byte, reading the next byte from the current page) are padded with unnecessary operations to use 31 cycles too. Given the CPU freqency of a stock Apple II these 31 cycles lead to the 33kHz.
