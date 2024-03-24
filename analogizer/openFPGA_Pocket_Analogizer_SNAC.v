//This module encapsulates all Analogizer adapter SNAC controllers
// Original work by @RndMnkIII. 
// Date: 01/2024 
// Release: 1.0

// *** Analogizer R.1 adapter ***
//SNAC mappings:
//USB 3 Type A connector   ______________________________________________________________________________________                             
//PIN_NUMBER:             /           1      2       3       4       5       6       7       8       9           \
//PIN_NAME:              |             VBUS   D-      D+      GND     RX-     RX+     GND_D   TX-     TX+         |
//FUNCTION:              |             +5V    OUT1    OUT2    GND     IO3     IN4     IO5     IO6     IN7         |
//                       |  A                   ^       ^              ^       |       ^       ^       |          |
//                       |  N                   |       |              |       |    +--|-------|-------+          |
//                       |  A       +-----------|-------|--------------|-------+    |  |       +----------------+ |                              
//                       |  L       |         +-|-------|--------------|------------+  +--------+               | |            
//                       |  O       |         | |       |              |      +------------+    |               | |
//                       |  G       |         | |       |              |   +->| B        B |----|------+        | |
//                       |  I       |         | |       |              +---|->| CONF. SW.  |<---+      |        | |
//                       |  Z       |         | |   +---|-------<----------|<-| A        A |<----+     |        | |
//                       |  E       |         | |   |   |                  |  +------------+     |     |        | |
//                       |  R       |         | |   |   |             +-->-+------>--------->----+     |        | |         
//                       |         I|        I| |   |   +-------+     |                                |        | |
//                       |  R      N|        N| +---------+     |    B|A     B OUT                     |        | |
//                       |  1      4|   I    7|  IO3| OUT1| OUT2|  IO3|IO5  +-----------------------------------+ |
//                       |          |   O   IN|    A|     |O    |O   O|O    |A IN                      |          |  
//                       |         I|   5+----|-----|-----|U----|U---U|U ---|--------------------------+          |  
//                       |      ___N|___B|IN__|___IN|_____|T____|T___T|T____|_____                                |  
//POCKET                 |     /    V    V    V     V     ^     ^     ^     V     \                               |    
//CARTRIDGE PIN #:        \___|     2    3    4     5 ... 28    29    30    31     |_____________________________/
//                             \____|____|____|_____|_____|_____|_____|_____|_____/
//Pocket Pin Name:                  |    |    |     |     |     |     |     |
//cart_tran_bank0[7] ---------------+    |    |     |     |     |     |     | cart_tran_bank0_dir=1'b0; //input
//cart_tran_bank0[6] --------------------+    |     |     |     |     |     |
//cart_tran_bank0[5] -------------------------+     |     |     |     |     |
//cart_tran_bank0[4] -------------------------------+     |     |     |     |
//cart_tran_bank1[6] -------------------------------------+     |     |     | cart_tran_bank1_dir=1'b1 //output
//cart_tran_bank1[7] -------------------------------------------+     |     |
//cart_tran_pin30    -------------------------------------------------+     | cart_tran_pin30_dir=1'b1, cart_pin30_pwroff_reset=1'b1 (GPIO USE)
//cart_tran_pin31    -------------------------------------------------------+ cart_tran_pin31_dir=1'b0 / 1'b1 
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------++------------------
//                                                      C O N F I G U R A T I O N   A                                                                                || CONFIGURATION  B
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------++------------------
//     DEV TYPE          0                   1                    2                   3                   4                     5                 6                  || 16         
//     PIN_NAME         SNAC DISABLED        DB15		          NES                 SNES                PCENGINE(2BTN)        PCENGINE(6BTN)    PCENGINE(MULTITAP) || PSX
//USB3       SNAC                                                                                                                                                    || [NOT IMPLEMENTED]
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------||------------------
//VBUS 		 	                             +5V                  +5V                 +5V                 +5V                   +5V               +5V                || +5V                 
//D-		 OUT1      	                     CLK(O)               CLK_1(O)            CLK_1(O)            CLR(O)(*)             CLR(O)(*)         CLR(O)(*)          || AT1(O)     
//D+		 OUT2      	                     LAT(O)               LAT(O)              LAT(O)              SEL(O)(*)             SEL(O)(*)         SEL(O)(*)          || AT2(O)     
//GND 		 	                             GND                  GND                 GND                 GND                   GND               GND                || GND     
//RX-		  IO3                            DAT(I)               D0_1(I)             D0_1(I)             D2 (I)(*)             D2 (I)(*)         D2 (I)(*)          || CLK(O)          +
//RX+		  IN4                                                 D4_2(I)             IO_2(I)             D0 (I)(*)             D0 (I)(*)         D0 (I)(*)          || DAT(I)      
//GND_DRAIN	  IO5                                                 CLK_2(O)            CLK_2(O)                                                                       || ACK(I)          +
//TX-		  IO6                            DAT(I)(1)            D3_2(I)             D3_2(I)             D1 (I)(*)             D1 (I)(*)         D1 (I)(*)          || CMD(O)          +    
//TX+		  IN7                            D0_2(I)              D0_2(I)             D3 (I)(*)           D3 (I)(*)             D3 (I)(*)         D3 (I)(*)          || IRQ10(I)      
//
//(1) Alternate output of DAT (for male-to-male extension cables which cross Tx,Rx lines)

//(*) Needs a specific cable harness for use MiSTer SNAC adapter with the Pocket:
//  SNAC      PCENGINE     POCKET
// ADAPTER    FUNCTION     SNAC
//   D-    -> D0       ->  RX+    IN4
//   D+    -> D1       ->  TX-    IO6 (IN)
//   RX-   -> D2       ->  RX-    IO3 (IN)
//   RX+   -> CLR      ->  D-     OUT1
//   GND_D -> D3       ->  TX+    IN7 
//   TX-   -> SEL      ->  D+     OUT2
`default_nettype none
`timescale 1ns / 1ps

module openFPGA_Pocket_Analogizer_SNAC #(parameter MASTER_CLK_FREQ=50_000_000)
(
    input wire i_clk, //Core Master Freq.
    input wire i_rst, //Core general reset
    input wire conf_AB, //0 conf. A(default), 1 conf. B (see graph above)
    input wire [4:0] game_cont_type, //0-15 Conf. A, 16-31 Conf. B
    input wire [2:0] game_cont_sample_rate, //0 compatibility mode (slowest), 1 normal mode, 2 fast mode, 3 superfast mode
    output reg [15:0] p1_btn_state,
    output reg [15:0] p2_btn_state,
    output reg busy,    
    //SNAC Pocket cartridge port interface (see graph above)   
    output reg [7:4] CART_BK0_OUT,
    input  wire [7:4] CART_BK0_IN,
    output reg CART_BK0_DIR, 
    output reg [7:6] CART_BK1_OUT_P76,
    output reg CART_PIN30_OUT,
    input  wire CART_PIN30_IN,
    output reg CART_PIN30_DIR, 
    output reg CART_PIN31_OUT,
    input  wire CART_PIN31_IN,
    output reg CART_PIN31_DIR,
    //debug
    output wire o_stb

); 
    //
    reg SNAC_OUT1 /* synthesis preserve */; //cart_tran_bank1[6]                                           D-
    reg SNAC_OUT2 /* synthesis preserve */; //cart_tran_bank1[7]                                           D+
    reg SNAC_IO3_A /* synthesis preserve */;//Conf.A: cart_tran_bank0[4] (in),  Conf.B: pin30(out)         RX- 
    reg SNAC_IO3_B /* synthesis preserve */;//Conf.A: cart_tran_bank0[4] (in),  Conf.B: pin30(out)         RX-
    reg SNAC_IN4 /* synthesis preserve */;  //cart_tran_bank0[7]                                           RX+
    wire SNAC_IO5_A /* synthesis preserve */;//Conf.A: pin30(out),               Conf.B: cart_tran_bank1[6] GND_D
    reg SNAC_IO5_B /* synthesis preserve */;//Conf.A: pin30(out),               Conf.B: cart_tran_bank1[6] GND_D
    reg SNAC_IO6_A /* synthesis preserve */;//Conf.A: pin31(in),                Conf.B: pin31(out)         TX-
    reg SNAC_IO6_B /* synthesis preserve */;//Conf.A: pin31(in),                Conf.B: pin31(out)         TX-
    reg SNAC_IN7 /* synthesis preserve */;   //cart_tran_bank0[5]                                          TX+
    
    //calculate step sizes for fract clock enables
    localparam pce_compat_polling_freq    =  20_000; //  20_000 / 5 =   4K samples/sec PCE
    localparam pce_normal_polling_freq    =  40_000; //  40_000 / 5 =   8K samples/sec PCE
    localparam pce_fast_polling_freq      =  80_000; //  80_000 / 5 =  16K samples/sec PCE
    localparam pce_very_fast_polling_freq = 100_000; // 100_000 / 5 =  20K samples/sec PCE

    localparam Compat_60Hz_polling_freq        =   1_080; //  
    localparam Compat_120Hz_polling_freq        =  2_160; //  
    localparam snes_compat_polling_freq        =   20_000; //                                           20_000 / 18 =  1.11K samples/sec NES/SNES
    localparam serlatch_compat_polling_freq    =   100_000; //  100_000 / 25 =  4K samples/sec DB15    100_000 / 18 =  5.55K samples/sec NES/SNES
    localparam serlatch_normal_polling_freq    =   200_000; //  200_000 / 25 =  8K samples/sec DB15    200_000 / 18 = 11.11K samples/sec NES/SNES
    localparam serlatch_fast_polling_freq      =   400_000; //  400_000 / 25 = 16K samples/sec DB15    400_000 / 18 = 22.22K samples/sec NES/SNES
    localparam serlatch_very_fast_polling_freq = 1_000_000; //1_000_000 / 25 = 32K samples/sec DB15  1_000_000 / 18 = 55.55K samples/sec NES/SNES


    //the FSM is clocked 2x the polling freq.
    localparam [32:0] MAX_INT = 33'h0ffffffff;
    localparam [64:0] pce_compat_pstep_ = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * pce_compat_polling_freq * 2) / 1000;
    localparam [32:0] pce_compat_pstep  = pce_compat_pstep_[32:0];
    localparam [64:0] pce_normal_pstep_ = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * pce_normal_polling_freq * 2) / 1000;
    localparam [32:0] pce_normal_pstep  = pce_normal_pstep_[32:0];
    localparam [64:0] pce_fast_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) *pce_fast_polling_freq * 2) / 1000;
    localparam [32:0] pce_fast_pstep    = pce_fast_pstep_[32:0];
    localparam [64:0] pce_very_fast_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) *pce_very_fast_polling_freq * 2) / 1000;
    localparam [32:0] pce_very_fast_pstep    = pce_very_fast_pstep_[32:0];

    localparam [64:0] serlatch_compat_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * serlatch_compat_polling_freq * 2) / 1000;
    localparam [32:0] serlatch_compat_pstep    = serlatch_compat_pstep_[32:0];
    localparam [64:0] serlatch_normal_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * serlatch_normal_polling_freq * 2) / 1000;
    localparam [32:0] serlatch_normal_pstep    = serlatch_normal_pstep_[32:0];
    localparam [64:0] serlatch_fast_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * serlatch_fast_polling_freq * 2) / 1000;
    localparam [32:0] serlatch_fast_pstep    = serlatch_fast_pstep_[32:0];
    localparam [64:0] serlatch_very_fast_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * serlatch_very_fast_polling_freq * 2) / 1000;
    localparam [32:0] serlatch_very_fast_pstep    = serlatch_very_fast_pstep_[32:0];
    
    localparam [64:0] snes_compat_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * snes_compat_polling_freq  * 2) / 1000;
    localparam [32:0] snes_compat_pstep    = snes_compat_pstep_[32:0];

    localparam [64:0] Compat_60Hz_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * Compat_60Hz_polling_freq  * 2) / 1000;
    localparam [32:0] Compat_60Hz_pstep    = Compat_60Hz_pstep_[32:0];
    localparam [64:0] Compat_120Hz_pstep_   = ((MAX_INT / (MASTER_CLK_FREQ / 1000)) * Compat_120Hz_polling_freq  * 2) / 1000;
    localparam [32:0] Compat_120Hz_pstep    = Compat_120Hz_pstep_[32:0];
    
    //Supported game controller types
    localparam GC_DISABLED = 5'd0;
    localparam GC_DB15 = 5'd1;
    localparam GC_NES = 5'd2;
    localparam GC_SNES = 5'd3;
    localparam GC_PCE_2BTN = 5'd4;
    localparam GC_PCE_6BTN = 5'd5;
    localparam GC_PCE_MULTITAP = 5'd6;
    //parameter GC_PSX= 5'd16;

    //Configuration:
    localparam CONF_A = 1'b0;
    localparam CONF_B = 1'b1;

    reg conf_AB_r;
    reg [4:0] game_cont_type_r;
    reg [2:0] game_cont_sample_rate_r;
    reg [32:0] strobe_step_size;
    reg reset_on_change;

    always @(posedge i_clk) begin
        //register SNAC settings
        conf_AB_r <= conf_AB;
        game_cont_type_r <= game_cont_type;
        game_cont_sample_rate_r <= game_cont_sample_rate;

        //detect change of SNAC settings and reset clock divider and set new settings
        reset_on_change <= 1'b0;
        if(i_rst || (game_cont_type_r != game_cont_type) || (game_cont_sample_rate_r != game_cont_sample_rate)) begin
            reset_on_change <= 1'b1;
        end
    end

    reg serlat_ena;
    reg pce_ena;
    always @(posedge i_clk) begin
        serlat_ena <= 1'b0;
        pce_ena    <= 1'b0;

        case (game_cont_type)
            GC_DB15, GC_NES, GC_SNES: begin 
                serlat_ena <= 1'b1;
                case (game_cont_sample_rate)
                    0: begin strobe_step_size <= serlatch_compat_pstep ;   end
                    1: begin strobe_step_size <= serlatch_normal_pstep;    end
                    2: begin strobe_step_size <= serlatch_fast_pstep;      end
                    3: begin strobe_step_size <= serlatch_very_fast_pstep; end 
                    4: begin strobe_step_size <= snes_compat_pstep;        end 
                    5: begin strobe_step_size <= Compat_60Hz_pstep;        end
                    6: begin strobe_step_size <= Compat_120Hz_pstep;       end
                    default: begin strobe_step_size <= serlatch_compat_pstep ;  end
                endcase
            end
            GC_PCE_2BTN, GC_PCE_6BTN, GC_PCE_MULTITAP: begin
                pce_ena    <= 1'b1;
                case (game_cont_sample_rate)
                    0: begin strobe_step_size <= pce_compat_pstep;    end
                    1: begin strobe_step_size <= pce_normal_pstep;    end
                    2: begin strobe_step_size <= pce_fast_pstep;      end
                    3: begin strobe_step_size <= pce_very_fast_pstep; end 
                    default: begin strobe_step_size <= pce_compat_pstep;    end
                endcase 
            end
            default: //disabled
                strobe_step_size <= 33'd0;
        endcase
    end

    always @(posedge i_clk) begin
        case (conf_AB)         
            CONF_A: begin
                CART_BK0_DIR                   <= 1'b0;                                           //INPUT
                {SNAC_IN4,SNAC_IN7,SNAC_IO3_A} <= {CART_BK0_IN[7],CART_BK0_IN[5],CART_BK0_IN[4]}; //OUTPUT
                CART_BK1_OUT_P76                <= {SNAC_OUT2,SNAC_OUT1};                          //OUTPUT 
                CART_PIN30_DIR                 <= 1'b1;                                           //OUTPUT 
                CART_PIN30_OUT                 <= SNAC_IO5_A; 
                CART_PIN31_DIR                 <= 1'b0;                                           //INPUT
                SNAC_IO6_A                     <= CART_PIN31_IN;  
            end 
            CONF_B: begin 
                CART_BK0_DIR                    <= 1'b0;                                           //INPUT
                {SNAC_IN4,SNAC_IO5_B,SNAC_IN7} <= {CART_BK0_IN[7],CART_BK0_IN[6],CART_BK0_IN[5]}; //OUTPUT
                CART_BK1_OUT_P76                <= {SNAC_OUT2,SNAC_OUT1};                          //OUTPUT 
                CART_PIN30_DIR                 <= 1'b1;                                           //OUTPUT           
                CART_PIN30_OUT                 <= SNAC_IO3_B; 
                CART_PIN31_DIR                 <= 1'b1;                                           //OUTPUT
                CART_PIN31_OUT                 <= SNAC_IO6_B;
            end
        endcase
    end
                                               
    wire stb_clk /* synthesis keep */;
    clock_divider_fract ckdiv(
    .i_clk (i_clk),
    .i_rst(reset_on_change), //reset on polling freq change
    .i_step(strobe_step_size[31:0]),
    .o_stb (stb_clk)
    );

	 wire dbg_clk_w;
	 reg dbg_clk /* synthesis noprune */;
    clock_divider_fract dbgckdiv(
    .i_clk (i_clk),
    .i_rst(reset_on_change), //reset on polling freq change
    .i_step({strobe_step_size[29:0],2'b00}),
    .o_stb (dbg_clk_w)
    );
	 
	 always @(posedge i_clk) dbg_clk <= dbg_clk_w;

    assign o_stb = stb_clk;

    //DB15/NES/SNES game controller
    wire [15:0] sl_p1 /* synthesis keep */;
    wire [15:0] sl_p2 /* synthesis keep */;
    wire SERLAT_SNAC_OUT1 /* synthesis keep */;
    wire SERLAT_SNAC_OUT2 /* synthesis keep */;
    //wire SERLAT_SNAC_IO5_A /* synthesis keep */;
    serlatch_game_controller #(.MASTER_CLK_FREQ(MASTER_CLK_FREQ)) slgc
    (
        .i_clk(i_clk),
        .i_rst(reset_on_change),
        .game_controller_type(game_cont_type[2:0]), //1 DB15, 2 NES, 3 SNES
        .i_stb(stb_clk),
        .p1_btn_state(sl_p1),
        .p2_btn_state(sl_p2),
        .busy(),
        //SNAC Game controller interface
        .o_clk(SERLAT_SNAC_OUT1), //shared for 2 controllers
        .o_clk2(SNAC_IO5_A),
        .o_lat(SERLAT_SNAC_OUT2), //shared for 2 controllers
        .i_dat1(SNAC_IO3_A), //data from controller 1
        .i_dat2(SNAC_IN7)  //data from controller 2
    );

    //PCENGINE game controller
    wire [15:0] pce_p1 /* synthesis keep */;
    wire PCE_SNAC_OUT1 /* synthesis keep */;
    wire PCE_SNAC_OUT2 /* synthesis keep */;

    pcengine_game_controller #(.MASTER_CLK_FREQ(MASTER_CLK_FREQ), .PULSE_CLR_LINE(1'b1)) pcegc1
    (
        .i_clk(i_clk),
        .i_rst(reset_on_change),
        .game_controller_type(game_cont_type), //4 2btn, 5 6btn
        .i_stb(stb_clk),
        .player_btn_state(pce_p1),
        .busy(),
        //SNAC Game controller interface
        .o_clr(PCE_SNAC_OUT1), //shared for 2 controllers
        .o_sel(PCE_SNAC_OUT2), //shared for 2 controllers
        .i_dat({SNAC_IN7,SNAC_IO3_A,SNAC_IO6_A,SNAC_IN4}) //data from controller
    );

wire [15:0] pce_multitap_p1, pce_multitap_p2;
wire PCE_MULTITAP_SNAC_OUT1, PCE_MULTITAP_SNAC_OUT2;

pcengine_game_controller_multitap #(.MASTER_CLK_FREQ(MASTER_CLK_FREQ)) pcegmultitap
(
        .i_clk(i_clk),
        .i_rst(reset_on_change),
        .game_controller_type(game_cont_type), //6 multitap
        .i_stb(stb_clk),
        .player1_btn_state(pce_multitap_p1),
        .player2_btn_state(pce_multitap_p2),
        .player3_btn_state(),
        .player4_btn_state(),
        .player5_btn_state(),
        .busy(),
    //SNAC Game controller interface
    .o_clr(PCE_MULTITAP_SNAC_OUT1), //shared for 2 controllers
    .o_sel(PCE_MULTITAP_SNAC_OUT2), //shared for 2 controllers
    .i_dat({SNAC_IN7,SNAC_IO3_A,SNAC_IO6_A,SNAC_IN4}) //data from controller
);

    always @(*) begin
        case(game_cont_type)
        GC_DISABLED: begin
            SNAC_OUT1 = 1'b0;
            SNAC_OUT2 = 1'b0;
            p1_btn_state = 16'd0; 
            p2_btn_state = 16'd0;
        end
        GC_DB15, GC_NES, GC_SNES: begin
            SNAC_OUT1 = SERLAT_SNAC_OUT1;
            SNAC_OUT2 = SERLAT_SNAC_OUT2;            
            p1_btn_state = sl_p1;
            p2_btn_state = sl_p2;

        end
        GC_PCE_2BTN, GC_PCE_6BTN: begin
            SNAC_OUT1 = PCE_SNAC_OUT1;
            SNAC_OUT2 = PCE_SNAC_OUT2;
            p1_btn_state = pce_p1; 
            p2_btn_state = 16'd0;
        end
        GC_PCE_MULTITAP: begin
            SNAC_OUT1 = PCE_MULTITAP_SNAC_OUT1;
            SNAC_OUT2 = PCE_MULTITAP_SNAC_OUT2;
            p1_btn_state = pce_multitap_p1; 
            p2_btn_state = pce_multitap_p2;
        end
        default: begin
            SNAC_OUT1 = 1'b0;
            SNAC_OUT2 = 1'b0;
            p1_btn_state = 16'd0; 
            p2_btn_state = 16'd0;
        end
        endcase
    end
endmodule