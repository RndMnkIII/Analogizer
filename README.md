# Analogizer-FPGA
![Analogizer Logo](https://github.com/RndMnkIII/Analogizer/blob/main/img/logo_Analogizer-FPGA.png)
Tienda Online: https://www.analogizer-fpga.com

[English Version](https://github.com/RndMnkIII/Analogizer/blob/main/README_en.md)

Adaptador para el sistema FPGA portatil Analogue Pocket que utiliza el puerto de expansión de cartuchos para generar salida de vídeo analogico RGB (18bit) Sync a través de un puerto VGA y conectar mandos de juegos nativos de diferentes tipos (DB15, NES, SNES, PCEngine) utilizando
la interfaz SNAC7 mediante un conector USB3.

## Especificaciones:
https://github.com/RndMnkIII/Analogizer/blob/main/specification/Especificaciones_Analogizer.md


## NUEVO: Analogizer R2 (Mejorado):
![ANALOGIZER R2](https://github.com/RndMnkIII/Analogizer/blob/main/img/1711795943821.jpg)
![ANALOGIZER R2](https://github.com/RndMnkIII/Analogizer/blob/main/img/1712216898707.jpg)
* Incluye soporte para SOG (SYNC ON GREEN), incluye un interruptor para activar/desactivar dicha función:

![SOG](https://github.com/RndMnkIII/Analogizer/blob/main/img/SOG.jpg)

* Hay que habilitar salida RGsB o YPbPr en el menú de los cores adaptados para usar Analogizer:
  
![video options](https://github.com/RndMnkIII/Analogizer/blob/main/img/ypbpr_video_options.jpg) 

* Permite conectar el adaptador a una TV CRT o de otro tipo que tenga entrada de video por componentes (ver foto):
  
![Component Video](https://github.com/RndMnkIII/Analogizer/blob/main/img/entrada_video_componentes.jpg) 

 Y puedes usar un cable de este tipo (VGA to component video):
 
![VGA to Component Video Cable](https://github.com/RndMnkIII/Analogizer/blob/main/img/VGA_TO_COMPONENT_VIDEO_CABLE.png).

* Nuevo diseño de carcasa con dos opciones de pestañas (para Pocket sin protector de pantalla de cristal templado o para Pocket con protector de pantalla de cristal templado).


Para salida de video Y/C necesitas seleccionar en el menú de la Pocket: `Analogizer Video Out > Y/C NTSC` or `Analogizer Video Out > Y/C NTSC,Pocket OFF`. En algunos cores puedes
modificar el valor del acumulador de fase con los deslizadores  `Chroma Add` and `Chroma Multiply` ajustando el valor entre 0 y 31. Normalmente no es necesario modificar estos valores.

Para salida de video Scandoubler SVGA necesitas seleccionar en el menú de la Pocket: `Analogizer Video Out > Scandoubler RGBHV`.

Necesitas conectar un adaptador Y/C activo al puerto VGA de Analogizer (la alimentación de 5v la proporciona el pin 9 del puerto VGA). Recomiendo uno de estos adaptadores (activos):
* [MiSTerAddons - Active Y/C Adapter](https://misteraddons.com/collections/parts/products/yc-active-encoder-board/)
* [MikeS11 Active VGA to Composite / S-Video](https://ultimatemister.com/product/mikes11-active-composite-svideo/)
* [Active VGA->Composite/S-Video adapter](https://antoniovillena.com/product/mikes1-vga-composite-adapter/)

Utilizar otro tipo de adaptador Y/C que no se haya probado con Analogizer no recibirá soporte oficial.

## ¿Qué necesitas para utilizarlo?

 En esta tabla se establece el tipo de cable y/o adaptador necesario en función del tipo de salida de video:
 
 | SEÑAL DE VIDEO  | CABLE Y/O ADAPTADOR                | COMENTARIOS                                                                                                                           |
 | :-------------: | :--------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------: |
 | RGBS            | VGA TO SCART                       | Hay modelos especificos que incorporan tambien el conector de audio de tipo jack. Ver repositorio principal para mas información.     |
 | RGBS            | VGA TO BNC                         | Para modelos de CRT con entradas de tipo BNC. Normalmente se trata de pantallas de gama profesional de tipo PVM.                      |
 | RGsB            | VGA TO SCART                       | Parecido a YPbPr pero usa canales RGB con el sync en el canal G. Necesita Analogizer R2 con interruptor SOG (posicion ON)             | 
 | RGsB            | VGA TO component                   | Parecido a YPbPr pero usa canales RGB con el sync en el canal G. Necesita Analogizer R2 con interruptor SOG (posicion ON)             | 
 | YPbPr           | VGA TO component                   | esta cable tiene 3 cables RCA en el otro extremo. Requiere el uso de Analogizer R2 con interruptor SOG (posicion ON)                  |
 | Y/C             | Active Y/C adapter + cable         | Cable SVideo con conector MiniDIN4 o cable de video compuesto con conector RCA.                                                       |
 | RGBHV           | VGA                                | Cable VGA para conectar directamente a un monitor de este tipo.                                                                       |
 
Si tu intención es usar la salida analógica de video, debes tener un dispositivo que pueda visualizar dicha señal de vídeo tal una una TV CRT con entrada SCART, o convertirla a otro formato utilizando
un conversor como el OSSC o Retrotink. Un cable conversor de VGA a SCART.
Se recomienda usar este cable con el Analogizer debido a que está verificado que toma los +5V del pin 9 del conector VGA y se los pasa al pin 16 del conector SCART e incluye una resistencia de 470 Ohm en la señal CSYNC (recomiendo leer este articulo antes de comprar ningún cable https://www.retrorgb.com/beware-of-mister-scart-cables.html):
![VGAtoSCARTcable](https://github.com/RndMnkIII/Analogizer/blob/main/img/cable_vga_scart_manuferhi.PNG)

https://manuferhi.com/p/cable-rgb-scart-for-mister-mist-sidi-and-n-go

Si quieres conectarlo a un monitor arcade vas a necesitar un cable VGA con conector doble hembra o gender changer y un adaptador VGA JAMMA para conectar a un monitor Arcade.
El adaptador permite sacar señal nativa del core RGB sync, pero no te puedo decir todas las posibilidades para conectar a toda la infinidad de dispositivos que admiten este tipo de señal.
Para utilizar un mando nativo DB15, NES, SNES o PCEngine vas a necesitar el correspondiente adaptador SNAC tanto de tipo un solo mando como en configuración split para dos mandos. Estos los puedes
adquirir en diversos sitios pero deben de ser de los que usan conector USB3. Necesitaras un cable USB3 de tipo extender o bien macho-macho (si utilizas los adaptadores SNAC de Antonio Villena).
* https://manuferhi.com/p/cable-rgb-scart-for-mister-mist-sidi-and-n-go
* https://antoniovillena.com/product/splitter-for-official-mister/
* https://manuferhi.com/p/snac-adapter-for-mister
* https://ultimatemister.com/product/snac-db15-neogeo/

En resumen vas a necesitar:
* Un adaptador de corriente USB C que suministre alimentación de +5V al Analogizer a traver del conector lateral. Cualquier adaptador de los utilizados para cargar un teléfono moderno te puede servir o el mismo adaptador que incluye la Pocket.
* Un cable de video. Ya sea un cable adaptador VGA a SCART (recomendado), a un cable VGA que se conecte a un adaptador JAMMA para utilizarlo en un mueble arcade. Incluye un cable de audio que se pueden conectar al conector de auriculares de la Pocket de 3.5mm para sacar el audio a través de la TV.
* Si quieres utilizar SNAC: uno o dos mandos de tipo DB15, NES, SNES o PCENGINE 2btn, 6btn y/o MultiTap de PCEngine y su adaptador SNAC7 con conector USB3 correspondiente. Si es  del tipo de los de Antonio Villena además un cable USB3 tipo A (macho-macho, de tipo cruzado). Para el resto de adaptadores se utiliza un cable USB3 tipo A extensor (hembra-macho, sin cruzar). La longitud de los cables: algo entre 0.5 y 1.5m.
* Para usar los mandos PCEngine con el Analogizer es necesario utilizar adicionalmente un arnés que modifica el cableado USB3 y que se conecta entre el adaptador SNAC de PCengine y el Analogizer.

He dejado un esquema y un diseño de placa para fabricar el arnés o puedes comprarlo en la tienda online:
![Analogizer PCEngine Cable HarnessB](https://github.com/RndMnkIII/Analogizer/blob/main/img/PCENGINE_CABLE_HARNESS.jpg)
![Analogizer PCEngine Cable Harness connecting](https://github.com/RndMnkIII/Analogizer/blob/main/img/como_conectar_cable_harness.jpg)
[PCB Design](https://oshwlab.com/rndmnkiv/pcengine_cable_harness_snac)

## Lista de controladores nativos soportados por Analogizer (requiere del adaptador SNAC7 correspondiente):
* DB15: mandos nativos de NeoGeo y mandos arcade con hasta 6 botones de acción siguiendo esquema de conexión DB15:
  
![SNAC DB15 AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_DB15_Antonio_Villena.jpg)
![SNAC DB15 UM](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_DB15_Splitter_UltimateMister.png)

* NES: mando nativo de la consola NES.
  
![SNAC NES AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_NES_Splitter_Antonio_Villena.jpg)

* SNES: mando nativo de la consola SNES.
  
![SNAC NES AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/ultimate_mister_snes_snac.png)

* PCENGINE 2btn: mando nativo de dos botones de la consola TurboGrafx/PCEngine (requiere de arnés específico para su uso con el Analogizer).
* PCENGINE 6btn: mando nativo de seis botones de la consola TurboGrafx/PCEngine (requiere de arnés específico para su uso con el Analogizer).
* PCENGINE Multitap: adaptador multitap de 5 puertos. Solo admite mandos de 2 botones (requiere de arnés específico para su uso con el Analogizer).
  
![SNAC NES AV](https://github.com/RndMnkIII/Analogizer/blob/main/img/SNAC_PCEngine_Antonio_Villena.jpg)

He creado este documento donde iré añadiendo los dispositivos probados por los usuarios y su grado de compatibilidad:
https://docs.google.com/spreadsheets/d/10iuDrmut3mm6FIIGvGas8eOBX_8D-Txi52ibHLDFC5w/edit?usp=sharing

## ¿Cómo utilizarlo?
DESCARGO DE RESPONSABILIDAD: No me hago responsable del uso que hagas del adaptador y de los posibles daños que pueda producir por el mal uso o conexión de adaptadores o mandos no soportados. El adaptador está diseñado para ajustar de forma óptima con una configuración estandar de Pocket sin uso de protectores de pantalla u otros accesorios que puedan alterar el grosor u otras dimensiones de la consola. Voy a ofrecer una versión alternativa del adaptador con una carcasa adaptada a una lámina de cristal templado de 0.3mm, no me puedo hacer cargo de realizar ajustes más específicos debido a la gran variedad y grosores para este tipo de accesorios para la Pocket, es responsabilidad del usuario valorar esto antes de adquirir el Analogizer, dependiendo del diseño y grosor del protector de pantalla, podría provocar que el Adaptador no pueda ajustar de forma óptima o que no encaje de ninguna forma.

![WARNING](https://github.com/RndMnkIII/Analogizer/blob/main/img/WARNING_HQ.png)

### ¿Como conectar el Analogizer?
1. Insertar el Analogizer como se ve en la imagen, haciendo coincidir el extremo del cartucho con el puerto de cartuchos de la Analogue Pocket. Debe quedar encajado completamenta y sin que quede torcido. Los anclajes de la parte delantera deben encajar en el borde superior de la Pocket:
![CARTRIDGE_PORT](https://github.com/RndMnkIII/Analogizer/blob/main/img/1710557132168.jpg)
![INSERT1](https://github.com/RndMnkIII/Analogizer/blob/main/img/INSERT1.jpg)
![INSERT2](https://github.com/RndMnkIII/Analogizer/blob/main/img/INSERT2.jpg)

2. Asegurarse el interruptor de configuración de dispositivo SNAC esta en la posición A:
![AB_SW](https://github.com/RndMnkIII/Analogizer/blob/main/img/ANALOGIZER_SWITCH_AB.jpg)

3. Conectar el conector VGA del cable adaptador de VGA a SCART (ver sección ¿Qué necesitas para utilizarlo? ) al puerto VGA del Analogizer.
4. Conectar el cable del adaptador SNAC elegido para el tipo de mando que queremos usar (DB15, NES, SNES, PCENGINE, PCENGINE MULTITAP) al puerto SNAC. Previamente habremos conectado el mando de juegos al adaptador SNAC correspondiente:
![FRONT](https://github.com/RndMnkIII/Analogizer/blob/main/img/ANALOGIZER_FRONT_SIDE.jpg)
   
5. Conectar el conector jack de 3.5mm del cable adaptador de VGA a SCART al puerto de auriculares de la Analogue Pocket:
![AB_SW](https://github.com/RndMnkIII/Analogizer/blob/main/img/audio_jack.png)

6. Conectar fuente de alimentación USB C de 5V al puerto de alimentación +5V del Analogizer (puedes usar cualquier adaptador de corriente de un teléfono con puerto USB C o el mismo adaptador de la Analogue Pocket):
![PWR](https://github.com/RndMnkIII/Analogizer/blob/main/img/ANALOGIZER_USB_C_PWR.jpg)  
   
7.  Encender la Analogue Pocket y cargar algún core OpenFPGA con soporte para el Analogizer.
8.  Realizar ajustes específicos del core para el Analogizer: elegir tipo de mando nativo conectado, que tipo de controlador vamos a usar para cada jugador (SNAC o mandos de juegos de la Pocket), velocidad de muestreo de los mandos,...

## JT Cores
Para usar los cores JT de @Jotego con soporte para Analogizer, consulte las instrucciones aquí:
https://github.com/jotego/jtbin/wiki/Analogue-Pocket-Cores#using-analogizer-with-jt-cores

Creé un ejecutable de Windows desde la herramienta de secuencia de comandos Python para generar el archivo `crtcfg.bin` para configurar los núcleos @Jotego JT para Analogizer que se puede ejecutar como herramienta de línea de comandos independiente:
https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/jt-crtcfg.exe

Como usar la herramienta de configuración y donde copiar el archivo `crtcfg.bin`:
![How to execute the tool](https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/how_to_use1.PNG)
![The generated crtcfg.bin file](https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/how_to_use2.PNG)
![Where to copy](https://github.com/RndMnkIII/Analogizer/blob/main/JT_cores_configurator/how_to_use3.PNG)

Tambien puedes usar la herramienta PUpdate de Matt Pannella para configurar Analogizer para los cores JT, comprueba el lanzamiento mas reciente en su repositorio GitHub:
https://github.com/mattpannella/pupdate/releases

Otra novedad para los cores JT es la forman en la que se configuran los mandos. Se pueden usar hasta cuatro mandos/controles de juegos de forma simultánea. Para detectar los mandos y en orden en el que se utilizan se emplea el siguiente sistema: la primera pulsación de un botón en un mando que se detecte tras iniciarse el core hará que se mando se asigne al jugador 1, la pulsación de otro botón en otro mando asignará ese mando al jugador 2, y así hasta un máximo de 4 mandos para 4 jugadores. Se pueden mezclar mandos SNAC soportados por Analogizer utilizando el adaptador SNAC correspondiente para el tipo de mando, los controles de la propia Pocket y los mandos que se conecten a través del Dock.

Puedes apoyar el excelente trabajo de @Jotego aquí:
https://www.patreon.com/jotego

## Lista de cores con soporte para el Analogizer
Busca aquí https://openfpga-cores-inventory.github.io/analogue-pocket/ el término "ANALOGIZER".

## Agradecimientos
Quiero agradecer la ayuda y apoyo recibidos de las siguientes personas y grupos en relación con este proyecto:
* @Jotego por aplicar todo su buen hacer y conocimientos para hacer posible que todos sus cores funcionen con Analogizer
* @Denymetanol por su incansable ayuda y consejos y por dar un toque de estilismo al logo del Analogizer.
* Al grupo de Telegram Analogue POCKET Español por sus comentarios, apoyo y sugerencias cerveceras.
* A todos los que de algún modo me han mostrado apoyo y me han animado a seguir con este proyecto.

## Reconocimientos
La interfaz de código Analogizer-FPGA emplea el siguiente código de manera total o parcial de otros proyectos:
* La salida de video Y/C NTSC/PAL para SVideo y video compuesto está basado en el proyecto MiSTerFPGA_YC_Encoder de Mike Simone:
  [https://github.com/MikeS11/MiSTerFPGA_YC_Encode](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)
  
* La salida de video YPbPr está basado en el módulo `vga_out.sv` del proyecto MiSTer FPGA:
  [Template_MiSTer/sys/vga_out.sv](https://github.com/MiSTer-devel/Template_MiSTer/blob/master/sys/vga_out.sv)
  
* La salida de video scandoubler RGBHV está basada en el módulo `scandoubler.v` y el módulo `scanlines.v`del proyecto MiSTer FPGA:
  [Template_MiSTer/sys/scandoubler.v](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)
  [https://github.com/MiSTer-devel/Template_MiSTer/blob/master/sys/scanlines.v](https://github.com/MikeS11/MiSTerFPGA_YC_Encoder)
