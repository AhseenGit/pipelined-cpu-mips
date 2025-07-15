---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;
USE work.cond_comilation_package.all;
USE work.aux_package.all;


ENTITY MIPS_tb IS
	generic( 
		WORD_GRANULARITY : boolean 	:= G_WORD_GRANULARITY;
	    MODELSIM : integer 			:= G_MODELSIM;
		DATA_BUS_WIDTH : integer 	:= 32;
		ITCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
		DTCM_ADDR_WIDTH : integer 	:= G_ADDRWIDTH;
		PC_WIDTH : integer 			:= 10;
		FUNCT_WIDTH : integer 		:= 6;
		DATA_WORDS_NUM : integer 	:= G_DATA_WORDS_NUM;
		CLK_CNT_WIDTH : integer 	:= 16;
		INST_CNT_WIDTH : integer 	:= 16
	);
END MIPS_tb ;


ARCHITECTURE struct OF MIPS_tb IS
   -- Internal signal declarations
   SIGNAL rst_tb_i           	: STD_LOGIC;
   SIGNAL clk_tb_i           	: STD_LOGIC;
   
   --SIGNAL alu_result_tb_o  		: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0 );
   --SIGNAL Branch_ctrl_tb_o      : STD_LOGIC;
  -- SIGNAL instruction_top_tb_o 	: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0 );
   --SIGNAL MemWrite_ctrl_tb_o    : STD_LOGIC;
   --SIGNAL pc_tb_o              	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0 );
  -- SIGNAL RegWrite_ctrl_tb_o    : STD_LOGIC;
   --SIGNAL Zero_tb_o        		: STD_LOGIC;
  -- SIGNAL read_data1_tb_o 		: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0 );
  -- SIGNAL read_data2_tb_o 		: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0 );
   --SIGNAL write_data_tb_o  		: STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0 );
   SIGNAL mclk_cnt_tb_o			: STD_LOGIC_VECTOR(CLK_CNT_WIDTH-1 DOWNTO 0);
   SIGNAL inst_cnt_tb_o 		: STD_LOGIC_VECTOR(INST_CNT_WIDTH-1 DOWNTO 0);
   SIGNAL stall_cnt_tb_o		: STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL flush_cnt_tb_o		: STD_LOGIC_VECTOR(7 DOWNTO 0);
   
   signal       IFpc_tb_o				:STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
   signal		IFinstruction_tb_o		:STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
   signal		IDpc_tb_o				:STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
   signal		IDinstruction_tb_o		:STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
   signal		EXpc_tb_o				:STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
   signal		EXinstruction_tb_o		:STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
   signal		MEMpc_tb_o				:STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
   signal		MEMinstruction_tb_o	    :STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
   signal		WBpc_tb_o				:STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
   signal		WBinstruction_tb_o		:STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
   signal       BRADDR_tb_o             :STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
   signal       strigger_tb_o           : STD_LOGIC;
BEGIN
	CORE : MIPS
	generic map(
		WORD_GRANULARITY 			=> WORD_GRANULARITY,
	    MODELSIM 					=> MODELSIM,
		DATA_BUS_WIDTH				=> DATA_BUS_WIDTH,
		ITCM_ADDR_WIDTH				=> ITCM_ADDR_WIDTH,
		DTCM_ADDR_WIDTH				=> DTCM_ADDR_WIDTH,
		PC_WIDTH					=> PC_WIDTH,
		FUNCT_WIDTH					=> FUNCT_WIDTH,
		DATA_WORDS_NUM				=> DATA_WORDS_NUM,
		CLK_CNT_WIDTH				=> CLK_CNT_WIDTH,
		INST_CNT_WIDTH				=> INST_CNT_WIDTH
	)
	PORT MAP (
		rst_i           	=> rst_tb_i,
		clk_i           	=> clk_tb_i,
		BPADDR_i            => BRADDR_tb_o,
		--pc_o              	=> pc_tb_o,
		--alu_result_o  		=> alu_result_tb_o,
		--read_data1_o 		=> read_data1_tb_o,
		--read_data2_o 		=> read_data2_tb_o,
		--write_data_o  		=> write_data_tb_o,
		--instruction_top_o 	=> instruction_top_tb_o,
		--Branch_ctrl_o      	=> Branch_ctrl_tb_o,
	--	Zero_o        		=> Zero_tb_o,
	
	    IFpc_o			    =>IFpc_tb_o,
	    IFinstruction_o	    =>IFinstruction_tb_o,
	    IDpc_o			    =>IDpc_tb_o,
	    IDinstruction_o	    =>IDinstruction_tb_o,
	    EXpc_o			    =>EXpc_tb_o,
	    EXinstruction_o	    =>EXinstruction_tb_o,
	    MEMpc_o			    =>MEMpc_tb_o,
	    MEMinstruction_o    =>MEMinstruction_tb_o,
	    WBpc_o			    =>WBpc_tb_o,
	    WBinstruction_o	    =>WBinstruction_tb_o,
		--MemWrite_ctrl_o    	=> MemWrite_ctrl_tb_o,
		--RegWrite_ctrl_o    	=> RegWrite_ctrl_tb_o,
		mclk_cnt_o		   	=> mclk_cnt_tb_o,
		inst_cnt_o			=> inst_cnt_tb_o,
		STCNT_o     		=> stall_cnt_tb_o,
		STRIGGER_o          => strigger_tb_o,
		FHCNT_o				=>flush_cnt_tb_o
		
		
	);	
--------------------------------------------------------------------	
	gen_clk : 
	process
        begin
		  clk_tb_i <= '1';
		  wait for 50 ns;
		  clk_tb_i <= not clk_tb_i;
		  wait for 50 ns;
    end process;
	
	gen_rst : 
	process
        begin
		  rst_tb_i <='1','0' after 80 ns;
		  wait;
    end process;
	
	--break point address
	BRADDR_tb_o<= "0001100100";
--------------------------------------------------------------------		
END struct;
