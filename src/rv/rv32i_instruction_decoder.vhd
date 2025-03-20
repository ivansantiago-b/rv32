--! @file rv32i_instruction_decoder.vhd
--! @author Iván Santiago (ivansantiago-b)
--! @date 19/03/2025 - 21:44
--! @brief RISC-V base integer ISA instruction decoding unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.rv32i_constants.all;

entity rv32i_instruction_decoder is
    port(
        inst : in std_logic_vector(XLEN - 1 downto 0);
        rd_addr, rs1_addr, rs2_addr : out std_logic_vector(ADDR_LENGTH - 1 downto 0);
        imm : out std_logic_vector(XLEN - 1 downto 0);
        alu_fnct : out std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0);
        alu_sel_imm : out std_logic
    );
end rv32i_instruction_decoder;

architecture behavioral of rv32i_instruction_decoder is
    signal opcode : std_logic_vector(6 downto 0);
begin
    opcode <= inst(6 downto 0);
    rd_addr <= inst(11 downto 7);
    rs1_addr <= inst(19 downto 15);
    rs2_addr <= inst(24 downto 20);
    alu_fnct(2 downto 0) <= inst(14 downto 12);
    alu_fnct(3) <= inst(30);
    imm(10 downto 0) <= inst(30 downto 20);
    imm(31 downto 11) <= (others => inst(31));
    alu_sel_imm <= '1' when opcode = I_TYPE else '0';
end behavioral;