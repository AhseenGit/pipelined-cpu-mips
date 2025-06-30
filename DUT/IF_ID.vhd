LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-- make Flush
ENTITY IF_ID IS
    GENERIC (
        PC_WIDTH       : INTEGER := 10;
        DATA_BUS_WIDTH : INTEGER := 32
    );
    PORT (
        clk_i          : IN  STD_LOGIC;
        rst_i          : IN  STD_LOGIC;
        pc_plus4_i     : IN  STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
        instruction_i  : IN  STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
		flush_i        : IN  STD_LOGIC;  -- from control
		stall_i        : IN  STD_LOGIC;  -- from data hazard
        pc_plus4_o     : OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
        instruction_o  : OUT STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0)
    );
END IF_ID;

ARCHITECTURE rtl OF IF_ID IS
    SIGNAL pc_reg       : STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
    SIGNAL instr_reg    : STD_LOGIC_VECTOR(DATA_BUS_WIDTH-1 DOWNTO 0);
BEGIN
    process(clk_i, rst_i)
    begin
        if rst_i = '1' then
            pc_reg      <= (others => '0');
            instr_reg   <= (others => '0');
		elsif rising_edge(clk_i) then
		
			if flush_i = '1' then
				instr_reg <= (others => '0'); 
			elsif stall_i = '0' then
				pc_reg    <= pc_plus4_i;
				instr_reg <= instruction_i;
			-- elsif stall_i = '1' then
			    --pc_reg    <= pc_plus4_i;
			    -- instr_reg <= instruction_i;
			end if;
			
		end if;
    end process;

    pc_plus4_o    <= pc_reg;
    instruction_o <= instr_reg;
END rtl;
