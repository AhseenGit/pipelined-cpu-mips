
-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE work.const_package.all;


ENTITY control IS
   PORT( 	
		opcode_i 			: IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
		funct_i             : IN    STD_LOGIC_VECTOR(5 DOWNTO 0);
		RegDst_ctrl_o 		: OUT 	STD_LOGIC;
		ALUSrc_ctrl_o 		: OUT 	STD_LOGIC;
		MemtoReg_ctrl_o 	: OUT 	STD_LOGIC;
		RegWrite_ctrl_o 	: OUT 	STD_LOGIC;
		MemRead_ctrl_o 		: OUT 	STD_LOGIC;
		MemWrite_ctrl_o	 	: OUT 	STD_LOGIC;
		Branch_ctrl_o 		: OUT 	STD_LOGIC_VECTOR(1 downto 0);
		ALUOp_ctrl_o	 	: OUT 	STD_LOGIC_VECTOR(2 DOWNTO 0);
		--jal_o               : OUT 	STD_LOGIC;
		jr_o                : OUT 	STD_LOGIC;
		JUMP_o              : OUT   STD_LOGIC
		--flush_o             : OUT   STD_LOGIC; -- for jump and branch taken
		--stall_ctl_o         : OUT   STD_LOGIC
	);
END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  rtype_w, lw_w, sw_w, beq_w,bneq_w, itype_imm_w,multipy_w,jtype_w,jal_w,jr_w : STD_LOGIC;

BEGIN           
				-- Code to generate control signals using opcode bits
	rtype_w 			<=  '1'	WHEN	opcode_i = R_TYPE_OPC		ELSE '0';
	lw_w          		<=  '1'	WHEN  	opcode_i = LW_OPC  			ELSE '0';
 	sw_w          		<=  '1'	WHEN  	opcode_i = SW_OPC  			ELSE '0';
   	beq_w         		<=  '1'	WHEN  	opcode_i = BEQ_OPC  		ELSE '0';
	bneq_w         		<=  '1'	WHEN  	opcode_i = BNEQ_OPC  		ELSE '0';
	itype_imm_w			<=	'1'	WHEN	((opcode_i = ADDI_OPC)  or 
										( opcode_i = ORI_OPC)   or 
										( opcode_i = ANDI_OPC)  or 
       									( opcode_i = XORI_OPC)  or 
										( opcode_i = LUI_OPC)   or 
										( opcode_i = SLTI_OPC)  or 
										( opcode_i = ADDIU_OPC))ELSE '0';
	jr_w <= '1' when ((opcode_i="000000") and (funct_i="001000")) else '0';								
										
	jal_w         		<=  '1'	WHEN  	opcode_i = JAL_OPC  	ELSE '0';	
										
    multipy_w           <=  '1' WHEN    opcode_i = MLTIPLY_OPC 	ELSE '0';
    jtype_w         <= 	'1' WHEN    ((opcode_i = JUMP_OPC) or  (opcode_i = JAL_OPC)) or (jr_w ='1') else '0';
							             
  	RegDst_ctrl_o    	<=  (rtype_w and (not jr_w) ) or  jal_w or multipy_w;
 	ALUSrc_ctrl_o  		<=  lw_w OR sw_w or itype_imm_w;
	MemtoReg_ctrl_o 	<=  lw_w;
  	RegWrite_ctrl_o 	<=  (rtype_w and (not jr_w)) OR lw_w or itype_imm_w or jal_w or multipy_w ;
  	MemRead_ctrl_o 		<=  lw_w;
   	MemWrite_ctrl_o 	<=  sw_w; 
 	Branch_ctrl_o(0)   	<=  beq_w;
    Branch_ctrl_o(1)    <=	bneq_w;
	--jal_o               <=  jal_w; 
	jr_o                <=  jr_w; 
	JUMP_o              <=  jtype_w;
	ALUOp_ctrl_o(0) 	<=  beq_w or bneq_w;
	ALUOp_ctrl_o(1) 	<=  (rtype_w and (not jr_w)) or multipy_w;
	ALUop_ctrl_o(2)     <= itype_imm_w or multipy_w;
    
   END behavior;


