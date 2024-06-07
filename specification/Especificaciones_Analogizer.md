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

## Interfaz Analogizer (desarrollo)
La primera modificación que hay que añadir al código del core original es habilitar el puerto de cartuchos de la Pocket. Para ello debemos editar el archivo `core.json` que se encuentra en la misma ubicación que el bitstream del core y establecer `"cartridge_adapter"` al valor `0`:

```
{
  "core": {
    "magic": "APF_VER_1",
    ...
        "framework": {
      "target_product": "Analogue Pocket",
      ...
         "hardware": {
           "link_port": false,
           "cartridge_adapter": 0
         },
```

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
)
``` 

Normalmente el módulo `openFPGA_Pocket_Analogizer`se instancia a un nivel mas bajo, donde se crea la instancia del módulo del core.
Lo único que se precisa es conectar las señales requiridas entre el core de la maquina que se va a ejecutar y la instancia del módulo de
Analogizer:

| SEÑAL                  | TIPO     | ANCHO | FUNCION                                                                                                      |
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
| conf_AB                | ENTRADA  | 1     | señal SNAC. Configuración A (=0) ó B (=1) para SNAC. Debe coincidir con posicion del interruptor A/B         |
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


Para que el usuario pueda modificar las opciones de Analogizer se establecen tres grupos de opciones. Estas opciones se establecen normalmente en el archivo `interact.js` que se encuentra en la misma ubicación que el bitstream del core. Esto puede cambiar en el caso de cores que tienen opciones diferentes en función del juego que se desea cargar:

```
{
  "interact": {
    "magic": "APF_VER_1",
    "variables": [
       {
        "name": "SNAC Adapter",
        "id": 43,
        "type": "list",
        "enabled": true,
        "persist": true,
        "address": "0xA0000000",
        "defaultval": "0x00",
        "mask": "0xFFFFFFE0",
        "options": [
            {
            "value": "0x00",
            "name": "None"
            },
            {
            "value": "0x01",
            "name": "DB15 Normal"
            },
            {
            "value": "0x02",
            "name": "NES"
            },
            {
            "value": "0x03",
            "name": "SNES"
            },
            {
            "value": "0x04",
            "name": "PCE 2BTN"
            },
            {
            "value": "0x05",
            "name": "PCE 6BTN"
            },
            {
            "value": "0x06",
            "name": "PCE Multitap"
            },
            {
              "value": "0x09",
              "name": "DB15 Fast"
            },
            {
              "value": "0x0B",
              "name": "SNES A,B<->X,Y"
            }
        ]
    },
    {
        "name": "SNAC Controller Assignment",
        "id": 44,
        "type": "list",
        "enabled": true,
        "persist": true,
        "address": "0xA0000000",
        "defaultval": "0x00",
        "mask": "0xFFFFFC3F",
        "options": [
            {
              "value": "0x0",
              "name": "SNAC -> P1"
            },
            {
              "value": "0x40",
              "name": "SNAC -> P2"
            },
            {
              "value": "0x80",
              "name": "SNAC P1,P2->P1,P2"
            },
            {
              "value": "0xC0",
              "name": "SNAC P1,P2->P2,P1"
            },
            {
              "value": "0x200",
              "name": "SNAC P1,P2->P3,P4"
            },
            {
              "value": "0x100",
              "name": "SNAC P1-P4->P1-P4"
            },
            {
              "value": "0x140",
              "name": "SNAC P1-P2->P1-P2"
            },
            {
              "value": "0x180",
              "name": "SNAC P1-P2->P3-P4"
            }
        ]
    },
    {
        "name": "Analogizer Video Out",
        "id": 45,
        "type": "list",
        "enabled": true,
        "persist": true,
        "address": "0xA0000000",
        "defaultval": "0x0",
        "mask": "0xFFFFC3FF",
        "options": [
            {
              "value": "0x0",
              "name": "RGBS"
            },
            {
              "value": "0x0400",
              "name": "RGsB"
            },
            {
              "value": "0x0800",
              "name": "YPbPr"
            },
            {
              "value": "0x0C00",
              "name": "Y/C NTSC"
            },
            {
              "value": "0x1400",
              "name": "Scandoubler RGBHV"
            },
            {
              "value": "0x2000",
              "name": "RGBS,Pocket OFF"
            },
            {
              "value": "0x2400",
              "name": "RGsB,Pocket OFF"
            },
            {
              "value": "0x2800",
              "name": "YPbPr,Pocket OFF"
            },            {
              "value": "0x2C00",
              "name": "Y/C NTSC,Pocket OFF"
            },
            {
              "value": "0x3400",
              "name": "Scandoubler,Pocket OFF"
            }
        ]
    },
    ...
        ],
    "messages": []
  }
}
```

De forma esquematizada estas serían las diferentes opciones que se pueden seleccionar para Analogizer:

```
  SNAC Adapter
    |                            FUNCTION                    VALUE (hex) WIDTH ADDRESS    MASK       MASKED VALUE
    +----------- None            disables SNAC interface     0x0         5     0xA0000000 0xFFFFFFE0 0x00        
    +----------- DB15 Normal     1/2 players                 0x1         5     0xA0000000 0xFFFFFFE0 0x01        
    +----------- NES             1/2 players                 0x2         5     0xA0000000 0xFFFFFFE0 0x02        
    +----------- SNES            1/2 players                 0x3         5     0xA0000000 0xFFFFFFE0 0x03         
    +----------- PCE 2BTN        1 player                    0x4         5     0xA0000000 0xFFFFFFE0 0x04         
    +----------- PCE 6BTN        1 player                    0x5         5     0xA0000000 0xFFFFFFE0 0x05         
    +----------- PCE Multitap    allows 4 players            0x6         5     0xA0000000 0xFFFFFFE0 0x06         
    +----------- DB15 Fast       uses faster sampling        0x9         5     0xA0000000 0xFFFFFFE0 0x09         
    +----------- SNES A,B<->X,Y  swap A,B X,Y buttons        0xB         5     0xA0000000 0xFFFFFFE0 0x0B         
``` 

```
  SNAC Controller Assignment 
    |                              FUNCTION                                       VALUE (hex) WIDTH ADDRESS    MASK       MASKED VALUE
    +----------- SNAC -> P1        SNAC controller to P1                          0x0         4     0xA0000000 0xFFFFFC3F 0x000                 
    +----------- SNAC -> P2        SNAC controller to P2                          0x1         4     0xA0000000 0xFFFFFC3F 0x040           
    +----------- SNAC P1,P2->P1,P2 SNAC cont1,cont2 to P1,P2                      0x2         4     0xA0000000 0xFFFFFC3F 0x080           
    +----------- SNAC P1,P2->P2,P1 SNAC cont1,cont2 to P2,P1                      0x3         4     0xA0000000 0xFFFFFC3F 0x0C0           
    +----------- SNAC P1,P2->P3,P4 SNAC cont1,cont2 to P3,P4 (only for 4P cores)  0x8         4     0xA0000000 0xFFFFFC3F 0x200           
    +----------- SNAC P1-P4->P1-P4 SNAC cont1-cont4 to P1-P4 (only for 4P cores)  0x9         4     0xA0000000 0xFFFFFC3F 0x100           
    +----------- SNAC P1-P2->P1-P2 SNAC cont1-cont2 to P1-P2 (only for 4P cores)  0xA         4     0xA0000000 0xFFFFFC3F 0x140           
    +----------- SNAC P1-P2->P3-P4 SNAC cont1-cont2 to P3-P4 (only for 4P cores)  0xB         4     0xA0000000 0xFFFFFC3F 0x180                     
```

```
  Analogizer Video Out
    |                                   FUNCTION                    VALUE (hex) WIDTH ADDRESS    MASK       MASKED VALUE 
    +----------- RGBS                   idem                        0x0         4     0xA0000000 0xFFFFC3FF 0x0000       
    +----------- RGsB                   idem                        0x1         4     0xA0000000 0xFFFFC3FF 0x0400       
    +----------- YPbPr                  idem                        0x2         4     0xA0000000 0xFFFFC3FF 0x0800       
    +----------- Y/C NTSC               idem                        0x3         4     0xA0000000 0xFFFFC3FF 0x0C00       
    +----------- Y/C PAL                idem                        0x4         4     0xA0000000 0xFFFFC3FF 0x1000       
    +----------- Scandoubler RGBHV      idem                        0x5         4     0xA0000000 0xFFFFC3FF 0x1400       
    +----------- RGBS,Pocket OFF        idem, blanks Pocket screen  0x8         4     0xA0000000 0xFFFFC3FF 0x2000       
    +----------- RGsB,Pocket OFF        idem, blanks Pocket screen  0x9         4     0xA0000000 0xFFFFC3FF 0x2400       
    +----------- YPbPr,Pocket OFF       idem, blanks Pocket screen  0xA         4     0xA0000000 0xFFFFC3FF 0x2800       
    +----------- Y/C NTSC,Pocket OFF    idem, blanks Pocket screen  0xB         4     0xA0000000 0xFFFFC3FF 0x2C00       
    +----------- Y/C PAL,Pocket OFF     idem, blanks Pocket screen  0xC         4     0xA0000000 0xFFFFC3FF 0x3000       
    +----------- Scandoubler,Pocket OFF idem, blanks Pocket screen  0xD         4     0xA0000000 0xFFFFC3FF 0x3400         
```


Hay que seleccionar un rango de direcciones del bridge en el framework de la Pocket, en el ejemplo se ha reservado la dirección 0xA0000000 para Analogizer.
La interacción en el código queda a elección del desarrollador, en este ejemplo quedaría así:

```
  // for bridge write data, we just broadcast it to all bus devices
  // for bridge read data, we have to mux it
  // add your own devices here
  always @(*) begin
    casex (bridge_addr)
      default: begin
        bridge_rd_data <= 0;
      end
      32'h2xxxxxxx: begin
        bridge_rd_data <= sd_read_data;
      end
      32'hA0000000: begin //Analogizer settings
        bridge_rd_data <= {18'h0,analogizer_settings};
      end
      32'hF8xxxxxx: begin
        bridge_rd_data <= cmd_bridge_rd_data;
      end
    endcase
  end
```

```
 always @(posedge clk_74a) begin
    if (reset_delay > 0) begin
      reset_delay <= reset_delay - 1;
    end

    if (bridge_wr) begin
      casex (bridge_addr)
        32'h0: begin
          ioctl_download <= bridge_wr_data[0];
        end
        32'h4: begin
          save_download <= bridge_wr_data[0];
        end
        ...
        /*[ANALOGIZER_HOOK_BEGIN]*/
		32'hA0000000: analogizer_settings  <=  bridge_wr_data[13:0];
	    /*[ANALOGIZER_HOOK_END]*/
        ...
      endcase
    end
  end
```


Puede ser necesario sincronizar la lectura de las opciones, al utilizar dominios de reloj diferentes:

```
  /*[ANALOGIZER_HOOK_BEGIN]*/
  //Pocket Menu settings
  reg [13:0] analogizer_settings = 0;
  wire [13:0] analogizer_settings_s;

  synch_3 #(.WIDTH(14)) sync_analogizer(analogizer_settings, analogizer_settings_s, clk_sys_42_95);

  always @(*) begin
    snac_game_cont_type   = analogizer_settings_s[4:0];
    snac_cont_assignment  = analogizer_settings_s[9:6];
    analogizer_video_type = analogizer_settings_s[13:10];
  end
  /*[ANALOGIZER_HOOK_END]*/
```

