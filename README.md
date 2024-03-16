# Analogizer
![Analogizer Logo](https://github.com/RndMnkIII/Analogizer/blob/main/img/logo_resized_analogizer.jpg)

[English Version](https://github.com/RndMnkIII/Analogizer/blob/main/README_en.md)

Adaptador para la consola FPGA portatil Analogue Pocket que utiliza el puerto de expansión de cartuchos para generar salida de vídeo analogico RGB666 Sync a través de un puerto VGA y conectar mandos de control nativos de diferentes tipos (DB15, NES, SNES, PCEngine) utilizando
la interfaz SNAC7 mediante un conector USB3.

## ¿Qué necesitas para utilizarlo?
Si tu intención es usar la salida analógica de video, debes tener un dispositivo que pueda visualizar dicha señal de vídeo tal una una TV CRT con entrada SCART, o convertirla a otro formato utilizando
un conversor como el OSSC o Retrotink. Un cable conversor de VGA a SCART.
Se recomienda usar este cable con el Analogizer debido a que está verificado que toma los +5V del pin 9 del conector VGA y se los pasa al pin 16 del conector SCART e incluye una resistencia de 470 Ohm en la señal CSYNC:
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
* Si quieres utilizar SNAC: uno o dos mandos de tipo DB15, NES, SNES o PCENGINE 2btn, 6btn y/o MultiTap de PCEngine y su adaptador SNAC7 con conector USB3 correspondiente. Si el del tipo de los de Antonio Villena además un cable USB3 tipo A (macho-macho, de tipo cruzado). Para el resto de adaptadores se utiliza un cable USB3 tipo A extensor (hembra-macho, sin cruzar). La longitud de los cables: algo entre 0.5 y 1.5m.
* Para usar los mandos PCEngine con el Analogizer es necesario utilizar adicionalmente un arnés que modifica el cableado USB3 y que se conecta entre el adaptador SNAC de PCengine y el Analogizer. Mas detalles de esto próximamente.
El orden del cableado sería el siguiente:
![Analogizer PCEngine Cable Harness](https://github.com/RndMnkIII/Analogizer/blob/main/img/PCENGINE_SNAC_HARNESS.png)

He dejado un esquema y un diseño de placa para fabricar el arnés:
![Analogizer PCEngine Cable Harness 3D PCB](https://github.com/RndMnkIII/Analogizer/blob/main/img/3D_PCB_HARNESS.PNG)
[PCB Design](https://oshwlab.com/rndmnkiv/pcengine_cable_harness_snac)

## Lista de controladores nativos soportados por Analogizer (requiere del adaptador SNAC7 correspondiente):
* DB15: mandos nativos de NeoGeo y mandos arcade con hasta 6 botones de acción siguiendo esquema de conexión DB15.
* NES: mando nativo de la consola NES.
* SNES: mando nativo de la consola SNES.
* PCENGINE 2btn: mando nativo de dos botones de la consola TurboGrafx/PCEngine (requiere de arnés específico para su uso con el Analogizer).
* PCENGINE 6btn: mando nativo de seis botones de la consola TurboGrafx/PCEngine (requiere de arnés específico para su uso con el Analogizer).
* PCENGINE Multitap: adaptador multitap de 5 puertos. Solo admite mandos de 2 botones (requiere de arnés específico para su uso con el Analogizer).
  
## ¿Cómo utilizarlo?
AVISO: No me hago responsable del uso que hagas del adaptador y de los posibles daños que pueda producir por el mal uso o conexión de adaptadores o mandos no soportados.

![WARNING](https://github.com/RndMnkIII/Analogizer/blob/main/img/WARNING.png)

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


## Lista de cores con soporte para el Analogizer
* https://github.com/RndMnkIII/Analogizer-Pocket-Alpha-Mission
* https://github.com/RndMnkIII/Analogizer_Mazamars312_Neogeo_0.8.1

## Agradecimientos
Quiero agradecer la ayuda y apoyo recibidos de las siguientes personas y grupos en relación con este proyecto:
* @Denymetanol por su incansable ayuda y consejos y por dar un toque de estilismo al logo del Analogizer.
* Al grupo de Telegram Analogue POCKET Español por sus comentarios, apoyo y sugerencias cerveceras ;-).
* A todos los que de algún modo me han mostrado apoyo y me han animado a seguir con este proyecto.
