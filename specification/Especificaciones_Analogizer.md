# Especificaciones de Analogizer

## Fundamentos
 El fundamento del adaptador Analogizer es ampliar las posibilidades de la consola portatil Pocket de Analogue en dos aspectos fundamentales. Por un lado
 permitir obtener una salida de video analógica a partir de las señales de video que genera el core antes de ser adaptadas a las características
 de visualización de la Pocket. Esto implica usar la resolución, frecuencias de refresco, señales de sincronismo, etc del core original tal como fue
 implementado para replicar el sistema original. No se aplica preprocesado de ningún tipo más allá de adaptar ciertas señales para poder generar las
 diferentes salidas de video (RGBS,RGsB,YPbPr, Y/C,RGBHV). Esta señal de video será compatible con diferentes tipos de pantalla, el objetivo principal
 pantallas CRT con una frecuencia de funcionamiento de 15KHz y con diferentes tipos de entrada de video: SCART RGB, SCART SVideo, SCART Composite, video
 por componentes con YPbPr, SVideo, video compuesto. Además utilizando un módulo scandoubler se habre la posibilidad de visualizar el video utilizando
 monitores SVGA. Por otro lado se quiere añadir la posibilidad de utilizar mandos de juegos nativos con los cores de la Pocket. Esto se logra utilizando
 la base ya establecida de adaptadores SNAC oficiales para MiSTEr que utilizan el protocolo SNAC7 y conector USB 3 del tipo A. Analogizer en la actualidad
 ofrece soporte SNAC para 1/2 jugadores para los mandos de tipo NeoGeo DB15, NES, SNES. Adicionalmente ofrece soporte para 1 jugador para mandos PCEngine de
 2 y 6 botones. Este suporte se amplia a 4 jugadores utilizando el adaptador multitap de 5 jugadores de NEC. Para los mandos de tipo PCEngine y el multitap NEC
 es necesario utilizar un arnés de cableado entre el adaptador SNAC y el Analogizer debido a ciertas limitaciones del adaptador Analogizer (no tiene libertad
 para configurar las señales SNAC como de entrada o salida a nivel individual y ciertas señales tienen un configuración fija de salida o entrada) debidas a como
 funciona el puerto de expansión de cartuchos de la Pocket. El adaptador dispone de un switch lateral marcado con A/B, siendo la posición por defecto la A. Esto
 afecta a la disposicion de las señales para el puerto SNAC. Con la configuración A se da soporte a los tipos de mandos antes enumerados. La B se reserva para
 futuras ampliciones, por ejemplo para dar soporte a los mandos PSX. Toda esta funcionalidad consume recursos lógicos directamente de la FPGA Cyclone V de la Pocket
 que deben ser compartidos con la implementación del core en cuestión al que se le quiere añadir soporte.

## Señales de salida de video
 La principal utilidad de Analogizer es que permite obtener diferentes tipos de señales de video analógicas. Es fundamental implementar todas ellas, especialmente
 la salida Y/C para SVideo y video compuesto, teniendo en cuenta que la mayor parte de los dispositivos CRT TV de los que disponen los usuarios solo dispone de esta
 entradas de video, seguidos por los usuarios con TV con entrada de video por componentes y TV con entrada SCART. La salida SVGA se considera accesoria para usuarios
 que no disponen de pantallas de TV CRT pero si disponen de monitores de video SVGA.
 Por orden de calidad de salida de video en CRT se recomiendan: 
 * SCART RGB
 * Video por componentes YPbpr (requiere versión R2 de Analogizer con SOG)
 * Y/C SVideo
 * Y/C video compuesto
 * SVGA
  
## Adaptores SNAC para mandos
 La segunda funcionalidad en importancia que ofrece Analogizer es que permite usar adaptadores SNAC7 con conector USB 3 (tipo A) ya existentes en Analogizer con ciertas limitaciones.
 Este se traduce en que en la actualidad puedes utilizar mandos nativos que usen conectores Neogeo DB15, NES, SNES y PCEngine de 2 y 6 botones y el adaptador MultiTap NEC de 5 jugadores (actualmen
 te limitado a 4 jugadores por la interfaz de Analogizer). Dicho esto existen una infinidad de diseños que en la mayoría de los casos funcionarán sin problemas. En el README del repositorio principal de Analogizer se irán añadiendo los diferentes tipos de adaptadores compatibles con Analogizer, existen versiones tanto para 1 mando como para 2 mandos (DB15,NES,SNES). Para los mandos del tipo
 PCEngine se requiere además de un arnés de cableado especificamente creado para analogizer (está disponible a la venta en la tienda online de Analogizer y además el diseño del pcb es público para los usuarios interesados en construirlo ellos mismos). En un extremo se conecta al adaptador SNAC por un conector USB 3 hembra de tipo A y por el otro extremo se
 conecta a Analogizer con un conector USB 3 macho de tipo A. Se pueden usar cables extensores USB 3 hembra-macho a conveniencia de los usuarios y es el método de conexión recomendado para evitar
 excsivo estress de los conectores si se conectan todos estos adaptadores entre sí directamente.
 Hay que tener en cuenta que los adaptadores SNAC de tipo Blue212 usa dos placas (una de ellas es especifica del mando nativo y tiene el conector nativo pero no posee circuiteria propia). La otra placa es un diseño común para todos los mandos y se conecta directamente a la anterior, esta provee toda la electrónica para hacer la conversión de niveles de voltage entre las señales de los mandos
 y Analogizer. 

## Interfaz Analogizer
Como creador del Analogizer he desarrollado también una interfaz en Verilog que encapsula toda la funcionalidad en un único módulo que hay que instanciar.
Dicho modulo es el que conecta las diferentes partes implicadas para que funcione todo de manera correcta.
Este módulo se comunica con el adaptador directamente a través del puerto de expansión de cartuchos de la Pocket. Este puerto está disponible en el framework
de Analogue openFPGA para el desarrollador, utilizando las siguientes señales instanciadas en el módulo de mas alto nivel como sigue:
```
module apf_top (
...
        ///////////////////////////////////////////////////
        // cartridge interface
        // switches between 3.3v and 5v mechanically
        // output enable for multibit translators controlled by PIC32

        // GBA AD[15:8]
        inout   wire    [7:0]   cart_tran_bank2,
        output  wire            cart_tran_bank2_dir,

        // GBA AD[7:0]
        inout   wire    [7:0]   cart_tran_bank3,
        output  wire            cart_tran_bank3_dir,

        // GBA A[23:16]
        inout   wire    [7:0]   cart_tran_bank1,
        output  wire            cart_tran_bank1_dir,

        // GBA [7] PHI#
        // GBA [6] WR#
        // GBA [5] RD#
        // GBA [4] CS1#/CS#
        //     [3:0] unwired
        inout   wire    [7:4]   cart_tran_bank0,
        output  wire            cart_tran_bank0_dir,

        // GBA CS2#/RES#
        inout   wire            cart_tran_pin30,
        output  wire            cart_tran_pin30_dir,
        // when GBC cart is inserted, this signal when low or weak will pull GBC /RES low with a special circuit
        // the goal is that when unconfigured, the FPGA weak pullups won't interfere.
        // thus, if GBC cart is inserted, FPGA must drive this high in order to let the level translators
        // and general IO drive this pin.
        output  wire            cart_pin30_pwroff_reset,

        // GBA IRQ/DRQ
        inout   wire            cart_tran_pin31,
        output  wire            cart_tran_pin31_dir,
		...
``` 
Normalmente el módulo `openFPGA_Pocket_Analogizer`se instancia a un nivel mas bajo, donde se crea la instancia del módulo del core.
Lo único que se precisa es conectar las señales requiridas entre el core de la maquina que se va a ejecutar y la instancia del módulo de
Analogizer:

| SEÑAL                  | TIPO     | LONG  | FUNCION                                                                                                      |
| :--------------------: | :------: | :---: | :----------------------------------------------------------------------------------------------------------: |
| MASTER_CLK_FREQ        | PARAMETRO|       | Este parámetro se utiliza para calcular el delay en señales de temporización para los dispositivos SNAC      |
| i_clk                  | ENTRADA  | 1     | reloj principal. Puede ser el reloj maestro del core o el reloj de video.                                    |
| i_rst                  | ENTRADA  | 1     | señal de reset activa a alta. Reinicia la interfaz y mantiene el puerto de cartuchos en estado por defecto   |
| i_ena                  | ENTRADA  | 1     | señal de habilitacion. Si esta deshabilitada mantiene el puerto de cartuchos en el estado por defecto        |
| analog_video_type      | ENTRADA  | 4     | Selecciona la salida de video de Analogizer a través del puerto de salida de video                           |
| R                      | ENTRADA  | 8     | canal de color R. Internamente se reduce a los 6 bits de mayor peso                                          |
| G                      | ENTRADA  | 8     | canal de color G. Internamente se reduce a los 6 bits de mayor peso                                          |
| B                      | ENTRADA  | 8     | canal de color B. Internamente se reduce a los 6 bits de mayor peso                                          |
| HBlank                 | ENTRADA  | 1     | señal de blanking horizontal                                                                                 |
| VBlank                 | ENTRADA  | 1     | señal de blanking vertical                                                                                   |
| BLANKn                 | ENTRADA  | 1     | señal de blanking compuesto activa a baja (el ADV7123 la requiere para salida de video RGBS, RGsB)           |
| Hsync                  | ENTRADA  | 1     | señal de sincronismo horizontal                                                                              |
| Vsync                  | ENTRADA  | 1     | señal de sincronismo vertical                                                                                |
| Csync                  | ENTRADA  | 1     | señal de sincronismo compuesto. La generación de esta señal es específica de cada core                       |
| video_clk              | ENTRADA  | 1     | reloj de video para el ADV7123. Según el core esta señal puede ser la misma que i_clk u otra específica      |
| PALFLAG                | ENTRADA  | 1     | señal especifica Y/C. Permite adaptar SVideo y el video compuesto a PAL(=1) o a NTSC(=0)                     |
| MULFLAG                | ENTRADA  | 1     | señal especifica Y/C (DEBUG). Modifica la forma en la que se calcula el acumulador de fase (po defecto =0)   |
| CHROMA_ADD             | ENTRADA  | 5     | señal especifica Y/C (DEBUG). Permite ajustar el valor del acumulador de fase en la fase de desarrollo       |
| CHROMA_MULT            | ENTRADA  | 5     | señal especifica Y/C (DEBUG). Permite ajustar el valor del acumulador de fase en la fase de desarrollo       |
| CHROMA_MULT            | ENTRADA  | 5     | señal especifica Y/C (DEBUG). Permite ajustar el valor del acumulador de fase en la fase de desarrollo       |
| CHROMA_PHASE_INC       | ENTRADA  | 40    | señal especifica Y/C. Valor de incremento del acumulador de fase sintonizado para la frecuencia del core     |
| COLORBURST_RANGE       | ENTRADA  | 27    | señal especifica Y/C. Valor de color burst sintonizado para la frecuencia de video del core                  |
| ce_divider             | ENTRADA  | 3     | señal especifica Scandoubler RGBHV. Divisor del reloj de pixel. Usar valor que mejor ajuste la imagen        |
| conf_AB                | ENTRADA  | 3     | señal SNAC. Configuración A ó B para mandos de juegos SNAC. Debe coincidir con posicion del interruptor A/B  |
| game_cont_type         | ENTRADA  | 5     | señal SNAC. Especifica si no se usan mandos SNAC y si se usan de que tipo (Ver archivo interact.json)        |
| p1_btn_state           | SALIDA   | 16    | señal SNAC. Estado de los botones de mando SNAC para el player1 (ST,SEL,R3,L3,R2,L2,R1,L1,Y,X,B,A,R,L,D,U)   |
| p2_btn_state           | SALIDA   | 16    | señal SNAC. Estado de los botones de mando SNAC para el player2 (ST,SEL,R3,L3,R2,L2,R1,L1,Y,X,B,A,R,L,D,U)   |
| p3_btn_state           | SALIDA   | 16    | señal SNAC. Estado de los botones de mando SNAC para el player3 (ST,SEL,R3,L3,R2,L2,R1,L1,Y,X,B,A,R,L,D,U)   |
| p4_btn_state           | SALIDA   | 16    | señal SNAC. Estado de los botones de mando SNAC para el player4 (ST,SEL,R3,L3,R2,L2,R1,L1,Y,X,B,A,R,L,D,U)   |
| cart_tran_bank2        | E/S      | 8     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank2_dir    | SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank3        | E/S      | 8     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank3_dir    | SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank1        | E/S      | 8     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank1_dir    | SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank0        | E/S      | 4     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_bank0_dir    | SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_pin30        | E/S      | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_pin30_dir    | SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_pin30_pwroff_reset| SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_pin31        | E/S      | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| cart_tran_pin31_dir    | SALIDA   | 1     | interfaz con el puerto de cartuchos. Se conecta directamente a la señales del módulo de nivel superior       |
| o_stb                  | SALIDA   | 1     | signal used for debugging of the SNAC module in the development phase. Not necessary for normal use          |
