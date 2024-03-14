# Analogizer
![Analogizer Logo](https://github.com/RndMnkIII/Analogizer/blob/main/img/logo_resized_analogizer.jpg)

Adapter for the Analogue Pocket portable FPGA console that uses the cartridge expansion port to generate analog RGB666 Sync video output through a VGA port and connect native control controllers of different types (DB15, NES, SNES, PCEngine) using the SNAC7 interface via a USB3 connector.

# What do you need to use it?
If your intention is to use the analog video output, you must have a device that can display said video signal such as a CRT TV with SCART input, or convert it to another format using
a converter like OSSC or Retrotink. A VGA to SCART converter cable.
It is recommended to use this cable with the Analogizer because it is verified that it takes the +5V from pin 9 of the VGA connector and passes it to pin 16 of the SCART connector and includes a 470 Ohm resistor in the CSYNC signal:
![VGAtoSCARTcable](https://github.com/RndMnkIII/Analogizer/blob/main/img/cable_vga_scart_manuferhi.PNG)
If you want to connect it to an arcade monitor you will need a VGA cable with a double female connector or gender changer and a VGA JAMMA adapter to connect to an Arcade monitor.
The adapter allows you to output a native signal from the RGB sync core, but I can't tell you all the possibilities to connect to all the countless devices that support this type of signal.
To use a native DB15, NES, SNES or PCEngine controller you will need the corresponding SNAC adapter, both a single controller and a split configuration for two controllers. You can do these
You can buy them from various places but they must be ones that use a USB3 connector. You will need a USB3 extension or male-male cable (if you use Antonio Villena's SNAC adapters).
* https://manuferhi.com/p/cable-rgb-scart-for-mister-mist-sidi-and-n-go
* https://antoniovillena.com/product/splitter-for-official-mister/
* https://manuferhi.com/p/snac-adapter-for-mister
* https://ultimatemister.com/product/snac-db15-neogeo/

In summary you will need:
* A USB C power adapter that supplies +5V power to the Analogizer through the side connector. Any adapter used to charge a modern phone can work or the same adapter that the Pocket includes.
* A video cable. Either a VGA to SCART adapter cable (recommended), or a VGA cable that connects to a JAMMA adapter for use in an arcade cabinet. Includes an audio cable that can be connected to the Pocket's 3.5mm headphone jack to output audio through the TV.
* If you want to use SNAC: one or two DB15, NES, SNES or PCENGINE 2btn, 6btn and/or MultiTap type controllers from PCEngine and its SNAC7 adapter with corresponding USB3 connector. Yes, the Antonio Villena type also has a USB3 type A cable (male-male, crossed type). For the rest of the adapters, a USB3 type A extender cable (female-male, uncrossed) is used. The length of the cables: something between 0.5 and 1.5m.
* To use the PCEngine controls with the Analogizer it is necessary to additionally use a harness that modifies the USB3 wiring and connects between the PCengine SNAC adapter and the Analogizer. More details on this coming soon.
The wiring order would be as follows:
[[[SCHEMATIC GOES HERE]]]

# List of native drivers supported by Analogizer (requires the corresponding SNAC7 adapter):
* DB15: native NeoGeo controllers and arcade controllers with up to 6 action buttons following DB15 connection scheme.
* NES: native controller for the NES console.
* SNES: native controller of the SNES console.
* PCENGINE 2btn: native two-button controller for the TurboGrafx/PCEngine console (requires a specific harness for use with the Analogizer).
* PCENGINE 6btn: native six-button controller for the TurboGrafx/PCEngine console (requires a specific harness for use with the Analogizer).
* PCENGINE Multitap: 5-port multitap adapter. Only supports 2-button controls (requires a specific harness for use with the Analogizer).
  
# List of cores with Analogizer support
* https://github.com/RndMnkIII/Analogizer-Pocket-Alpha-Mission
* https://github.com/RndMnkIII/Analogizer_Mazamars312_Neogeo_0.8.1

# Thanks
I would like to acknowledge the help and support received from the following people and groups in relation to this project:
* @Denymetanol for his tireless help and advice and for giving a touch of style to the Analogizer logo.
* To the Telegram group Analogue POCKET Español for their comments, support and beer suggestions ;-).
* To everyone who in some way has shown me support and encouraged me to continue with this project.