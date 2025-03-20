--! @file rv32i_hart.vhd
--! @author Iván Santiago (ivansantiago-b)
--! @date 19/03/2025 - 22:05
--! @brief RISC-V 32-bit integer base ISA implementation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.rv32i_constants.all;

entity rv32i_hart is
    port(
        clk : in std_logic;
        inst : in std_logic_vector(XLEN - 1 downto 0)
    );
end rv32i_hart;

architecture behavioral of rv32i_hart is
    --! Register state related signals
    signal we : std_logic;
    signal rd_addr, rs1_addr, rs2_addr : std_logic_vector(ADDR_LENGTH - 1 downto 0);
    signal rs1, rs2, rd_in : std_logic_vector(XLEN - 1 downto 0);
    --! ALU related signals
    signal alu_fnct : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0);
    signal alu_b, alu_out : std_logic_vector(XLEN - 1 downto 0);
    --! Instruction decoder control signals
    signal alu_sel_imm : std_logic;
    signal imm : std_logic_vector(XLEN - 1 downto 0);
begin
U0: entity work.rv32i_register_state port map(clk => clk, we => we, rd_addr => rd_addr, rs1_addr => rs1_addr,
    rs2_addr => rs2_addr, rd_in => rd_in, rs1 => rs1, rs2 => rs2);
U1: entity work.rv32i_alu port map(fnct => alu_fnct, a => rs1, b => alu_b, r => alu_out);
U2: entity work.rv32i_instruction_decoder port map(inst => inst, rd_addr => rd_addr, rs1_addr => rs1_addr,
    rs2_addr => rs2_addr, imm => imm, alu_fnct => alu_fnct, alu_sel_imm => alu_sel_imm);
    alu_b <= imm when alu_sel_imm = '1' else rs2;
    rd_in <= alu_out;
end behavioral;