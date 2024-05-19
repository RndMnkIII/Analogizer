//This module encapsulates all Analogizer adapter signals
// Original work by @RndMnkIII. 
// Date: 04/2024 
// Release: 1.1

// *** Analogizer R.2 adapter ***
// * WHEN SOG SWITCH IS IN ON POSITION, OUTPUTS CSYNC ON G CHANNEL
// # WHEN YPbPr VIDEO OUTPUT IS SELECTED, Y->G, Pr->R, Pb->B
//Pin mappings:                                               VGA CONNECTOR                                                                                          USB3 TYPE A FEMALE CONNECTOR (SNAC)
//                        ______________________________________________________________________________________________________________________________________________________________________________________________________                             
//                       /                              VS  HS          R#  G*# B#                                                                  1      2       3       4      5       6       7       8       9              \
//                       |                              |   |           |   |   |                                                                 VBUS   D-      D+      GND     RX-     RX+     GND_D   TX-     TX+             |
//FUNCTION:              |                              |   |           |   |   |                                                                 +5V    OUT1    OUT2    GND     IO3     IN4     IO5     IO6     IN7             |
//                       |  A                           |   |           |   |   |                                                                          ^       ^              ^       |       ^       ^       |              |
//                       |  N             SOG           |   |           |   |   |                                                                          |       |              V       V       V       V       V              |
//                       |  A           -------         |   |           |   |   |                                                                                                                                                |                              
//                       |  O    OFF   |   S   |--GND   |   |         +------------+                                                                                                                                             |
//                       |  L          |   W   |        |   |   SYNC  |            |                                                                                                                                             |            
//  PIN DIR:             |  G          |   I   +--------------------->|            |---------------------------------------------------------------------------------------------------------+                                   |
//  ^ OUTPUT             |  I          |   T   |        |   |         |  RGB DAC   |                                                                                                         |                                   |
//  V INPUT              |  Z          |   C   |        |   |         |            |===================================================================++                                    |                                   |
//                       |  E    ON ===|   H   |--------+   |         +------------+                                                                   ||                                    |                                   |
//                       |  R           -------         |   |            ||  |   | /BLANK                                                              ||                                    |                                   |         
//                       |                              |   +--------+   ||  |   +------------------------------------------------------------------+  ||                                    |                                   |                                  |
//                       |  R                           +------+     |   ||  +===============================++                                     |  ||                                    |                                   |
//                       |  2                                  |     |   ||                                  ||                                     |  ||                                    |                                   |
//                       |     CONF.B        IO5V       ---    |     |   \\================================  \\================================     |  \\================================   VID               IO3^  IO6^         |  
//                       |     CONF.A   IN4  ---  IN7   IO3V   VS    HS    R0    R1    R2    R3    R4    R5    G0    G1    G2    G3    G4    G5   /BLK   B0    B1    B2    B3    B4    B5   CLK  OUT1   OUT2  IO5^  IO6V         |  
//                       |      __3.3V__ |___ | __ |_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____^__GND__    |                                
//POCKET                 |     /         V    V    V     V     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     ^     V       \   | 
//CARTRIDGE PIN #:       \____|     1    2    3    4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19    20    21    22    23    24    25    26    27    28    29    30    31   32  |___/
//                             \_________|____|____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_____|_______/
//Pocket Pin Name:                       |    |    |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     | 
//cart_tran_bank0[7] --------------------+    |    |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     | 
//cart_tran_bank0[6] -------------------------+    |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank0[5] ------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank0[4] ------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank3[0] ------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     | 
//cart_tran_bank3[1] ------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     
//cart_tran_bank3[2] ------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank3[3] ------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank3[4] ------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank3[5] ------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank3[6] ------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank3[7] ------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//------------------                                                                                           |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[0] ------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     
//cart_tran_bank2[1] ------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[2] ------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[3] ------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[4] ------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[5] ------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[6] ------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |     |
//cart_tran_bank2[7] ------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |     |                                   
//------------------                                                                                                                                           |     |     |     |     |     |     |     |     |     |
//cart_tran_bank1[0] ------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |     |
//cart_tran_bank1[1] ------------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |     |
//cart_tran_bank1[2] ------------------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |     |
//cart_tran_bank1[3] ------------------------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |     |
//cart_tran_bank1[4] ------------------------------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |     |
//cart_tran_bank1[5] ------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |     |
//cart_tran_bank1[6] ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     |     |     |
//cart_tran_bank1[7] ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     |     |
//cart_tran_pin30    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     | 
//cart_tran_pin31    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

//  SNAC ADAPTER:
//  ---------------
//         31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
//         -----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------
//        | D| D| D| D| D| D| D| D| X| X| X| X| X| X| X| X| X| X| 1| 1| 1| 1| 1| 1| 1| 1| X| 0| 0| 0| 0| 0| 
//         -----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------
//  MASK        F           F           F           F           F           F           E           0

// *** CONF. A *** 
// 0x00 None
// 0x01 DB15 Normal
// 0x02 NES
// 0x03 SNES
// 0x04 PCENGINE 2Btn
// 0x05 PCENGINE 6Btn
// 0x06 PCENGINE Multitap
// 0x07 
// 0x08 
// 0x09 DB15 Fast
// 0x0A
// 0x0B SNES A,B<->X,Y
// 0x0C
// 0x0D
// 0x0E
// 0x0F

// *** CONF. B ***
// 0x10 RESERVED FOR FUTURE USE
// ...  ...
// 0x1F RESERVED FOR FUTURE USE                                                                                


// SNAC CONTROLLER ASSIGNMENT:
// ---------------------------
//         31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
//        -----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------
//       | D| D| D| D| D| D| D| D| X| X| X| X| X| X| X| X| X| X| 1| 1| 1| 1| 0| 0| 0| 0| X| 1| 1| 1| 1| 1| 
//        -----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------
// MASK        F           F           F           F           F           C           3           F                                    
// 0x000 0x0 SNAC -> P1               
// 0x040 0x1 SNAC -> P2
// 0x080 0x2 SNAC P1,P2 -> P1,P2
// 0x0C0 0x3 SNAC P1,P2 -> P2,P1
// //For systems with 4 players
// 0x100 0x4 SNAC P1-P4 -> P1-P4
// 0x140 0X5 SNAC P1-P2 -> P3-P4
// 0x180 0X6 SNAC P3-P4 -> P1-P2
// 0x1C0 0X7 SNAC P1-P4 -> P4-P1

// ANALOGIZER VIDEO OUT:
// ------------------------
//         31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
//        -----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------
//       | D| D| D| D| D| D| D| D| X| X| X| X| X| X| X| X| X| X| 0| 0| 0| 0| 1| 1| 1| 1| 1| 1| 1| 1| 1| 1| 
//        -----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------
// MASK        F           F           F           F           C           3           F           F       

// 0x0000 0x0 RGBS
// 0x0400 0x1 RGsB **
// 0x0800 0x2 YPbPr **
// 0x0C00 0x3 Scandoubler *
// 0x1000 0x4
// 0x1400 0x5
// 0x1800 0x6
// 0x1C00 0x7
// 0x2000 0x8 RGBS,Pocket OFF
// 0x2400 0x9 RGsB,Pocket OFF **
// 0x2800 0xA YPbPr,Pocket OFF **
// 0x2C00 0xB Scandoubler,Pocket OFF *
// 0x3000 0xC
// 0x3400 0xD
// 0x3800 0xE
// 0x3C00 0xF

// * NOT IMPLEMENTED YET
// ** OPTIONS AVALAIBLE ONLY FOR R2 ANALOGIZER
// X BITS RESERVED FOR FUTURE USE
// D BITS RESERVED FOR DEBUGGING USE
`default_nettype none
`timescale 1ns / 1ps

module openFPGA_Pocket_Analogizer #(parameter MASTER_CLK_FREQ=50_000_000) (
	input wire i_clk,
    input wire i_rst,
	input wire i_ena,
	//Video interface
	input wire [3:0] analog_video_type,
	input wire [7:0] R,
	input wire [7:0] G,
	input wire [7:0] B,
	input wire BLANKn,
	input wire Hsync,
	input wire Vsync,
	input wire video_clk,
	//SNAC interface
    input wire conf_AB,              //0 conf. A(default), 1 conf. B (see graph above)
    input wire [4:0] game_cont_type, //0-15 Conf. A, 16-31 Conf. B
    //input wire [2:0] game_cont_sample_rate, //0 compatibility mode (slowest), 1 normal mode, 2 fast mode, 3 superfast mode
    output wire [15:0] p1_btn_state,
    output wire [15:0] p2_btn_state,
    output wire [15:0] p3_btn_state,
    output wire [15:0] p4_btn_state,
    output wire busy,   
	//Pocket Analogizer IO interface to the cartridge port
	inout   wire    [7:0]   cart_tran_bank2,
	output  wire            cart_tran_bank2_dir,
	inout   wire    [7:0]   cart_tran_bank3,
	output  wire            cart_tran_bank3_dir,
	inout   wire    [7:0]   cart_tran_bank1,
	output  wire            cart_tran_bank1_dir,
	inout   wire    [7:4]   cart_tran_bank0,
	output  wire            cart_tran_bank0_dir,
	inout   wire            cart_tran_pin30,
	output  wire            cart_tran_pin30_dir,
	output  wire            cart_pin30_pwroff_reset,
	inout   wire            cart_tran_pin31,
	output  wire            cart_tran_pin31_dir,
    //debug
    output wire o_stb
);
	wire [7:4] CART_BK0_OUT /* synthesis keep */;
    wire [7:4] CART_BK0_IN /* synthesis keep */;
    wire CART_BK0_DIR /* synthesis keep */; 
    wire [7:6] CART_BK1_OUT_P76 /* synthesis keep */;
    wire CART_PIN30_OUT /* synthesis keep */;
    wire CART_PIN30_IN /* synthesis keep */;
    wire CART_PIN30_DIR /* synthesis keep */; 
    wire CART_PIN31_OUT /* synthesis keep */;
    wire CART_PIN31_IN /* synthesis keep */;
    wire CART_PIN31_DIR /* synthesis keep */;

	openFPGA_Pocket_Analogizer_SNAC #(.MASTER_CLK_FREQ(MASTER_CLK_FREQ)) snac
	(
		.i_clk(i_clk),
		.i_rst(i_rst),
		.conf_AB(conf_AB),              //0 conf. A(default), 1 conf. B (see graph above)
		.game_cont_type(game_cont_type), //0-15 Conf. A, 16-31 Conf. B
		//.game_cont_sample_rate(game_cont_sample_rate), //0 compatibility mode (slowest), 1 normal mode, 2 fast mode, 3 superfast mode
		.p1_btn_state(p1_btn_state),
		.p2_btn_state(p2_btn_state),
		.p3_btn_state(p3_btn_state),
		.p4_btn_state(p4_btn_state),
		.busy(busy),    
		//SNAC Pocket cartridge port interface (see graph above)   
		.CART_BK0_OUT(CART_BK0_OUT),
		.CART_BK0_IN(CART_BK0_IN),
		.CART_BK0_DIR(CART_BK0_DIR), 
		.CART_BK1_OUT_P76(CART_BK1_OUT_P76),
		.CART_PIN30_OUT(CART_PIN30_OUT),
		.CART_PIN30_IN(CART_PIN30_IN),
		.CART_PIN30_DIR(CART_PIN30_DIR), 
		.CART_PIN31_OUT(CART_PIN31_OUT),
		.CART_PIN31_IN(CART_PIN31_IN),
		.CART_PIN31_DIR(CART_PIN31_DIR),
		//debug
    	.o_stb(o_stb)
	); 
	//Choose type of analog video type of signal
	reg [5:0] Rout, Gout, Bout;
	reg HsyncOut, VsyncOut, BLANKnOut;
	wire [7:0] Yout, PrOut, PbOut;
	always @(*) begin
		case(analog_video_type)
			4'h0, 4'h8: begin //RGBS
				Rout = R[7:2];
				Gout = G[7:2];
				Bout = B[7:2];
				HsyncOut = Hsync;
				VsyncOut = 1'b1;
				BLANKnOut = BLANKn;
			end
			4'h1, 4'h9: begin //RGsB
				Rout = R[7:2];
				Gout = G[7:2];
				Bout = B[7:2];
				HsyncOut = 1'b1;
				VsyncOut = Hsync; //to DAC SYNC pin, SWITCH SOG ON
				BLANKnOut = BLANKn;
			end
			4'h2, 4'hA: begin //YPbPr
				Rout = PrOut[7:2];
				Gout = Yout[7:2];
				Bout = PbOut[7:2];
				HsyncOut = 1'b1;
				VsyncOut = YPbPr_sync; //to DAC SYNC pin, SWITCH SOG ON
				BLANKnOut = 1'b1; // YPbPr_blank; //FIX with 1'b0 ???
			end
			default: begin
				Rout = R[7:2];
				Gout = G[7:2];
				Bout = B[7:2];
				HsyncOut = Hsync;
				VsyncOut = 1'b1;
				BLANKnOut = BLANKn;
			end
		endcase
	end

	wire YPbPr_sync, YPbPr_blank;
	vga_out ybpr_video
	(
		.clk(video_clk),
		.ypbpr_en((analog_video_type == 4'h2) || (analog_video_type == 4'hA)),

		.hsync(1'b0),
		.vsync(1'b0),
		.csync(Hsync),
		.de(BLANKn),

		.din({R,G,B}),
		.dout({PrOut,Yout,PbOut}),

		.hsync_o(),
		.vsync_o(),
		.csync_o(YPbPr_sync),
		.de_o(YPbPr_blank)
	);

	//infer tri-state buffers for cartridge data signals
	//BK0
	assign cart_tran_bank0         = i_rst | ~i_ena ? 4'hf : ((CART_BK0_DIR) ? CART_BK0_OUT : 4'hZ);     //on reset state set ouput value to 4'hf
	assign cart_tran_bank0_dir     = i_rst | ~i_ena ? 1'b1 : CART_BK0_DIR;                              //on reset state set pin dir to output
	assign CART_BK0_IN             = cart_tran_bank0;
	//BK3
	assign cart_tran_bank3         = i_rst | ~i_ena ? 8'hzz : {Rout[5:0],HsyncOut,VsyncOut};                          //on reset state set ouput value to 8'hZ
	assign cart_tran_bank3_dir     = i_rst | ~i_ena ? 1'b0  : 1'b1;                                     //on reset state set pin dir to input
	//BK2
	assign cart_tran_bank2         = i_rst | ~i_ena ? 8'hzz : {Bout[0],BLANKnOut,Gout[5:0]};                          //on reset state set ouput value to 8'hZ
	assign cart_tran_bank2_dir     = i_rst | ~i_ena ? 1'b0  : 1'b1;                                     //on reset state set pin dir to input
	//BK1
	assign cart_tran_bank1         = i_rst | ~i_ena ? 8'hzz : {CART_BK1_OUT_P76,video_clk,Bout[5:1]};      //on reset state set ouput value to 8'hZ
	assign cart_tran_bank1_dir     = i_rst | ~i_ena ? 1'b0  : 1'b1;                                     //on reset state set pin dir to input
	//PIN30
	assign cart_tran_pin30         = i_rst | ~i_ena ? 1'b0 : ((CART_PIN30_DIR) ? CART_PIN30_OUT : 1'bZ); //on reset state set ouput value to 4'hf
	assign cart_tran_pin30_dir     = i_rst | ~i_ena ? 1'bz : CART_PIN30_DIR;                              //on reset state set pin dir to output
	assign CART_PIN30_IN           = cart_tran_pin30;
	assign cart_pin30_pwroff_reset = i_rst | ~i_ena ? 1'b0 : 1'b1;                                      //1'b1 (GPIO USE)
	//PIN31
	assign cart_tran_pin31         = i_rst | ~i_ena ? 1'bz : ((CART_PIN31_DIR) ? CART_PIN31_OUT : 1'bZ); //on reset state set ouput value to 4'hf
	assign cart_tran_pin31_dir     = i_rst | ~i_ena ? 1'b0 : CART_PIN31_DIR;                            //on reset state set pin dir to input
	assign CART_PIN31_IN           = cart_tran_pin31;
endmodule