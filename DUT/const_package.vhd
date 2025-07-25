---------------------------------------------------------------------------------------------
-- Copyright 2025 Hananya Ribo 
-- Advanced CPU architecture and Hardware Accelerators Lab 361-1-4693 BGU
---------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;


package const_package is
---------------------------------------------------------
--	IDECODE constants
---------------------------------------------------------
	constant R_TYPE_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000000";
	constant LW_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "100011";
	constant SW_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";
	constant BEQ_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "000100";
	constant BNEQ_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "000101";
	constant ANDI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001100";
	constant ORI_OPC : 		STD_LOGIC_VECTOR(5 DOWNTO 0) := "001101";
	constant ADDI_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001000";
	constant ADDIU_OPC : 	STD_LOGIC_VECTOR(5 DOWNTO 0) := "001001";
	constant XORI_OPC :     STD_LOGIC_VECTOR(5 DOWNTO 0) := "001110";
	constant LUI_OPC :      STD_LOGIC_VECTOR(5 DOWNTO 0) :=  "001111";
	constant SLTI_OPC :     STD_LOGIC_VECTOR(5 DOWNTO 0) := "001010";
	constant MLTIPLY_OPC :  STD_LOGIC_VECTOR(5 DOWNTO 0) := "011100";
	constant JUMP_OPC :     STD_LOGIC_VECTOR(5 DOWNTO 0) := "000010";
	--constant JR_OPC :       STD_LOGIC_VECTOR(5 DOWNTO 0) := "001110";
	constant JAL_OPC :       STD_LOGIC_VECTOR(5 DOWNTO 0) := "000011";
	
	
--------------------------------------------------------	
	
	
	

end const_package;

