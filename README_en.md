# Analogizer-FPGA
![Analogizer Logo](https://github.com/RndMnkIII/Analogizer/blob/main/img/logo_Analogizer-FPGA.png)
Online Store: https://www.analogizer-fpga.com

Adapter for the Analogue Pocket portable FPGA system that uses the cartridge expansion port to output analog RGB (18bit) Sync video through a VGA port using ADV7123 DAC and connect native game controllers of different types (DB15, NES, SNES, PCEngine) using the SNAC7 interface via USB 3 type A connector.

## Specifications:
https://github.com/RndMnkIII/Analogizer/blob/main/specification/Analogizer_specifications.md

## NEW: Analogizer R2 (Improved):
![ANALOGIZER R2](https://github.com/RndMnkIII/Analogizer/blob/main/img/1711795943821.jpg)
![ANALOGIZER R2](https://github.com/RndMnkIII/Analogizer/blob/main/img/1712216898707.jpg)
* Includes support for SOG (SYNC ON GREEN), includes a switch to activate/deactivate this function:

![SOG](https://github.com/RndMnkIII/Analogizer/blob/main/img/SOG.jpg)

 You must enable RGsB or YPbPr output in the core menu adapted to use Analogizer:

 ![video options](https://github.com/RndMnkIII/Analogizer/blob/main/img/ypbpr_video_options.jpg) 
 
 Allows you to connect the adapter to a CRT or other type of TV that has a component video input (see photo):
 ![Component Video](https://github.com/RndMnkIII/Analogizer/blob/main/img/entrada_video_componentes.jpg)

 And you can use a cable like this (VGA to component video):

![VGA to Component Video Cable](https://github.com/RndMnkIII/Analogizer/blob/main/img/VGA_TO_COMPONENT_VIDEO_CABLE.png).

* New case design with two tab options (for Pocket without tempered glass screen protector or for Pocket with tempered glass screen protector).
  
For output Y/C and composite video you need to select in Pocket's Menu: `Analogizer Video Out > Y/C NTSC` or `Analogizer Video Out > Y/C NTSC,Pocket OFF`. You can tune the phase accumulator
with `Chroma Add` and `Chroma Multiply` sliders adjusting values between 0 and 31. Normally it is not necessary to modify the value of these settings.

For output Scandoubler SVGA video you need to select in Pocket's Menu: `Analogizer Video Out > Scandoubler RGBHV`.

You will need to connect an active VGA to Y/C adapter to the VGA port (the 5V power is provided by VGA pin 9). I'll recomend one of these (active):
* [MiSTerAddons - Active Y/C Adapter](https://misteraddons.com/collections/parts/products/yc-active-encoder-board/)
* [MikeS11 Active VGA to Composite / S-Video](https://ultimatemister.com/product/mikes11-active-composite-svideo/)
* [Active VGA->Composite/S-Video adapter](https://antoniovillena.com/product/mikes1-vga-composite-adapter/)

Using another type of Y/C adapter not tested to be used with Analogizer will not receive official support.

## What do you need to use it?
 This table establishes the type of cable and/or adapter necessary depending on the type of video output:
 
 | VIDEO SIGNAL    | CABLE AND/OR ADAPTER               | COMMENTS                                                                                                                                |
 | :-------------: | :--------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------: |
 | RGBS            | VGA TO SCART                       | There are specific models that also incorporate a jack-type audio connector. See main repository for more information.                  |
 | RGBS            | VGA TO BNC                         | For CRT models with BNC type inputs. These are normally PVM type professional range screens.                                            |
 | RGsB            | VGA TO SCART                       | Similar to YPbPr but uses RGB channels with sync on G channel. Requires Analogizer R2 with SOG switch (ON position)                     |
 | RGsB            | VGA TO component                   | Similar to YPbPr but uses RGB channels with sync on G channel. Requires Analogizer R2 with SOG switch (ON position)                     |
 | YPbPr           | VGA TO component                   | This cable has 3 RCA cables on the other end. Requires the use of Analogizer R2 with SOG switch (ON position)                           |
 | Y/C             | Active Y/C adapter + cable         | SVideo cable with MiniDIN4 connector or composite video cable with RCA connector.                                                       |
 | RGBHV           | VGA                                | VGA cable to connect directly to a monitor of this type.                                                                                |

If your intention is to use the analog video output, you must have a device that can display said video signal such as a CRT TV with SCART input, or convert it to another format using
a converter like OSSC or Retrotink. A VGA to SCART converter cable.
It is recommended to use this cable with the Analogizer because it is verified that it takes the +5V from pin 9 of the VGA connector and passes it to pin 16 of the SCART connector and includes a 470 Ohm resistor in the CSYNC signal (I recomend to read this article before you buy any cable https://www.retrorgb.com/beware-of-mister-scart-cables.html):
![VGAtoSCARTcable](https://github.com/RndMnkIII/Analogizer/blob/main/img/cable_vga_scart_manuferhi.PNG)
If you want to connect it to an arcade monitor you will need a VGA cable with a double female connector or gender changer and a VGA JAMMA adapter to connect to an Arcade monitor.
The adapter allows you to output a native signal from the RGB sync core, but I can't tell you all the possibilities to connect to all the countless devices that support this type of signal.
To use a native DB15, NES, SNES or PCEngine controller you will need the corresponding SNAC adapter, both a single controller and a split configuration for two controllers. You can do these
You can buy them from various places but they must be ones that use a USB3 connector. You will need a USB3 extension or male-male cable (if you use Antonio Villena's SNAC adapters).
* https://manuferhi.com/p/cable-rgb-scart-for-mister-mist-sidi-and-n-go
* https://ultimatemister.com/product/rgb-scart-cable/
* https://antoniovillena.com/product/splitter-for-official-mister/
* https://manuferhi.com/p/snac-adapter-for-mister
* https://ultimatemister.com/product/snac-db15-neogeo/

In summary you will need:
* A USB C power adapter that supplies +5V power to the Analogizer through the side connector. Any adapter used to charge a modern phone can work or the same adapter that the Pocket includes.
* A video cable. Either a VGA to SCART adapter cable (recommended), or a VGA cable that connects to a JAMMA adapter for use in an arcade cabinet. Includes an audio cable that can be connected to the Pocket's 3.5mm headphone jack to output audio through the TV.
* If you want to use SNAC: one or two DB15, NES, SNES or PCENGINE 2btn, 6btn and/or MultiTap type controllers from PCEngine and its SNAC7 adapter with corresponding USB3 connector. Yes, the Antonio Villena type also has a USB3 type A cable (male-male, crossed type). For the rest of the adapters, a USB3 type A extender cable (female-male, uncrossed) is used. The length of the cables: something between 0.5 and 1.5m.
* To use the PCEngine controls with the Analogizer it is necessary to additionally use a harness that modifies the USB3 wiring and connects between the PCengine SNAC adapter and the Analogizer.

I have left a diagram and a plate design to make the harness or you can buy it in the online store:
![Analogizer PCEngine Cable HarnessB](https://github.com/RndMnkIII/Analogizer/blob/main/img/PCENGINE_CABLE_HARNESS.jpg)
![Analogizer PCEngine Cable Harness connecting](https://github.com/RndMnkIII/Analogizer/blob/main/img/como_conectar_cable_harness.jpg)
[PCB Design](https://oshwlab.com/rndmnkiv/pcengine_cable_harness_snac)

## List of native drivers supported by Analogizer (requires the corresponding SNAC7 adapter):
* DB15: native NeoGeo controllers and arcade controllers with up to 6 action buttons following DB15 connection scheme.

![SNAC DB15 AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_DB15_Antonio_Villena.jpg)
![SNAC DB15 UM](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_DB15_Splitter_UltimateMister.png)

* NES: native controller for the NES console.

![SNAC NES AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_NES_Splitter_Antonio_Villena.jpg)

* SNES: native controller of the SNES console.

![SNAC NES AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/ultimate_mister_snes_snac.png)

I have created this document where I will add the devices tested by users and their degree of compatibility:
https://docs.google.com/spreadsheets/d/10iuDrmut3mm6FIIGvGas8eOBX_8D-Txi52ibHLDFC5w/edit?usp=sharing

* PCENGINE 2btn: native two-button controller for the TurboGrafx/PCEngine console (requires a specific harness for use with the Analogizer).
* PCENGINE 6btn: native six-button controller for the TurboGrafx/PCEngine console (requires a specific harness for use with the Analogizer).
* PCENGINE Multitap: 5-port multitap adapter. Only supports 2-button controls (requires a specific harness for use with the Analogizer).
  
![SNAC PCENGINE AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_PCEngine_Antonio_Villena.jpg)

## How to use?
DISCLAIMER: I am not responsible for your use of the adapter and any possible damage that may occur due to misuse or connection of unsupported adapters or controls. The adapter is designed to fit optimally with a standard Pocket configuration without the use of screen protectors or other accessories that could alter the thickness or other dimensions of the console. I am going to offer an alternative version of the adapter with a case adapted to a 0.3mm tempered glass sheet, I cannot be responsible for making more specific adjustments due to the great variety and thicknesses for this type of accessories for the Pocket, it is the responsibility It is up to the user to consider this before purchasing the Analogizer, depending on the design and thickness of the screen protector, it could result in the Adapter not being able to fit optimally or not fitting at all.

![WARNING](https://github.com/RndMnkIII/Analogizer/blob/main/img/WARNING_HQ.png)

### How to connect the Analogizer?
1. Insert the Analogizer as seen in the image, matching the end of the cartridge with the cartridge port of the Analogue Pocket. It should fit completely and without being twisted. The anchors on the front must fit into the top edge of the Pocket:
![CARTRIDGE_PORT](https://github.com/RndMnkIII/Analogizer/blob/main/img/1710557132168.jpg)
![INSERT1](https://github.com/RndMnkIII/Analogizer/blob/main/img/INSERT1.jpg)
![INSERT2](https://github.com/RndMnkIII/Analogizer/blob/main/img/INSERT2.jpg)

2. Make sure the SNAC device configuration switch is in position A:
![AB_SW](https://github.com/RndMnkIII/Analogizer/blob/main/img/ANALOGIZER_SWITCH_AB.jpg)

3. Connect the VGA connector of the VGA to SCART adapter cable (see section What do you need to use it?) to the VGA port of the Analogizer.
4. Connect the SNAC adapter cable chosen for the type of controller we want to use (DB15, NES, SNES, PCENGINE, PCENGINE MULTITAP) to the SNAC port. Previously we will have connected the game controller to the corresponding SNAC adapter:
![FRONT](https://github.com/RndMnkIII/Analogizer/blob/main/img/ANALOGIZER_FRONT_SIDE.jpg)
   
5. Connect the 3.5mm jack connector of the VGA to SCART adapter cable to the headphone port of the Analogue Pocket:
![AB_SW](https://github.com/RndMnkIII/Analogizer/blob/main/img/audio_jack.png)
   
6. Connect a 5V USB C power supply to the +5V power port of the Analogizer (you can use any power adapter from a phone with a USB C port or the same adapter from the Analogue Pocket):
![PWR](https://github.com/RndMnkIII/Analogizer/blob/main/img/ANALOGIZER_USB_C_PWR.jpg)
   
7.  Turn on the Analogue Pocket and load an OpenFPGA core with support for the Analogizer.
8.  Make specific core settings for the Analogizer: choose the type of native controller connected, what type of controller we are going to use for each player (SNAC or Pocket game controllers), sampling rate of the controllers,...

## JT Cores
To use @Jotego JT cores with Analogizer support, see instructions here:
https://github.com/jotego/jtbin/wiki/Analogue-Pocket-Cores#using-analogizer-with-jt-cores

I've created a windows executable from the Python script tool to generate the `crtcfg.bin` file for configurate the @Jotego JT cores for Analogizer that can be executed as standalone command line tool:
https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/jt-crtcfg.exe

See how to use the tool and where is needed to copy the `crtcfg.bin`file:
![How to execute the tool](https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/how_to_use1.PNG)
![The generated crtcfg.bin file](https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/how_to_use2.PNG)
![Where to copy](https://github.com/RndMnkIII/Analogizer/blob/main/img/JT_cores_configurator/how_to_use3.PNG)

Another novelty for the JT Cores is the way in which the controls are configured. Up to four game controllers can be used simultaneously. To detect the controllers and in the order in which they are used, the following system is used: the first press of a button on a controller that is detected after starting the core will cause that controller to be assigned to player 1, the press of another button on another controller will assign that controller to player 2, and so on up to a maximum of 4 controllers for 4 players. You can mix SNAC controllers supported by Analogizer using the corresponding SNAC adapter for the type of controller, the controls on the Pocket itself, and the controllers that connect through the Dock.

You can support @Jotego excellent work here:
https://www.patreon.com/jotego

## List of cores with Analogizer support
Search here https://openfpga-cores-inventory.github.io/analogue-pocket/ for "ANALOGIZER".

## Thanks
I would like to acknowledge the help and support received from the following people and groups in relation to this project:
* @Denymetanol for his tireless help and advice and for giving a touch of style to the Analogizer logo.
* To the Telegram group Analogue POCKET Español for their comments, support and beer suggestions ;-).
* To everyone who in some way has shown me support and encouraged me to continue with this project.

## Acknowledge
The Analogizer-FPGA code interface uses the following code in whole or in part from other projects:
* The Y/C NTSC/PAL video output for SVideo and composite video is based on Mike Simone's MiSTerFPGA_YC_Encoder project:
 [https://github.com/MikeS11/MiSTerFPGA_YC_Encode](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)

* The YPbPr video output is based on the `vga_out.sv` module of the MiSTer FPGA project:
 [Template_MiSTer/sys/vga_out.sv](https://github.com/MiSTer-devel/Template_MiSTer/blob/master/sys/vga_out.sv)

* The scandoubler RGBHV video output is based on the `scandoubler.v` module and the `scanlines.v` module of the MiSTer FPGA project:
 [Template_MiSTer/sys/scandoubler.v](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)
 [https://github.com/MiSTer-devel/Template_MiSTer/blob/master/sys/scanlines.v](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)
