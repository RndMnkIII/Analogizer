# Analogizer
![Analogizer Logo]([http://url/to/img.png](https://github.com/RndMnkIII/Analogizer/blob/main/img/photo_5956438909166665243_y.jpg))
Adaptador para la consola FPGA portatil Analogue Pocket que utiliza el puerto de expansión de cartuchos para generar salida de vídeo analogico RGB666 Sync a través de un puerto VGA y conectar mandos de control nativos de diferentes tipos (DB15, NES, SNES, PCEngine) utilizando
la interfaz SNAC7 mediante un conector USB3.

# ¿Qué necesitas para utilizarlo?
Si tu intención es usar la salida analógica de video, debes tener un dispositivo que pueda visualizar dicha señal de vídeo tal una una TV CRT con entrada SCART, o convertirla a otro formato utilizando
un conversor como el OSSC o Retrotink. Un cable conversor de VGA a SCART.
Si quieres conectarlo a un monitor arcade vas a necesitar un cable VGA con conector doble hembra o gender changer y un adaptador VGA JAMMA para conectar a un monitor Arcade.
El adaptador permite sacar señal nativa del core RGB sync, pero no te puedo decir todas las posibilidades para conectar a toda la infinidad de dispositivos que admiten este tipo de señal.
Para utilizar un mando nativo DB15, NES, SNES o PCEngine vas a necesitar el correspondiente adaptador SNAC tanto de tipo un solo mando como en configuración split para dos mandos. Estos los puedes
adquirir en diversos sitios pero deben de ser de los que usan conector USB3. Necesitaras un cable USB3 de tipo extender o bien macho-macho (si utilizas los adaptadores SNAC de Antonio Villena).
* https://manuferhi.com/p/cable-rgb-scart-for-mister-mist-sidi-and-n-go
* https://antoniovillena.com/product/splitter-for-official-mister/
* https://manuferhi.com/p/snac-adapter-for-mister
* https://ultimatemister.com/product/snac-db15-neogeo/

# Lista de controladores nativos soportados por Analogizer (requiere del adaptador SNAC7 correspondiente):
* DB15: mandos nativos de NeoGeo y mandos arcade con hasta 6 botones de acción siguiendo esquema de conexión DB15.
* NES: mando nativo de la consola NES.
* SNES: mando nativo de la consola SNES.
* PCENGINE 2btn: mando nativo de dos botones de la consola TurboGrafx/PCEngine (requiere de arnés específico para su uso con el Analogizer).
* PCENGINE 6btn: mando nativo de seis botones de la consola TurboGrafx/PCEngine (requiere de arnés específico para su uso con el Analogizer).
* PCENGINE Multitap: adaptador multitap de 5 puertos. Solo admite mandos de 2 botones (requiere de arnés específico para su uso con el Analogizer).
* 
# Lista de cores con soporte para el Analogizer
* https://github.com/RndMnkIII/Analogizer-Pocket-Alpha-Mission