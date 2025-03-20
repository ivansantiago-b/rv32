--! @file rv32i_alu.vhd
--! @author Iván Santiago (ivansantiago-b)
--! @date 19/03/2025 - 21:08
--! @brief RISC-V 32-bit integer arithmetic logic unit implementation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.rv32i_constants.all;

entity rv32i_alu is
    port(
        --! ALU function
        fnct : in std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0);
        --! function operands
        a, b : in std_logic_vector(XLEN - 1 downto 0);
        --! function result
        r : out std_logic_vector(XLEN - 1 downto 0)
    );
end rv32i_alu;

architecture behavioral of rv32i_alu is
    signal less_than, less_than_unsigned : std_logic;
begin
    with fnct select
        r <= std_logic_vector(unsigned(a) + unsigned(b)) when ALU_FNCT_ADD,
             std_logic_vector(unsigned(a) - unsigned(b)) when ALU_FNCT_SUB,
             a xor b when ALU_FNCT_XOR,
             a or b when ALU_FNCT_OR,
             a and b when ALU_FNCT_AND,
             std_logic_vector(unsigned(a) sll to_integer(unsigned(b(4 downto 0)))) when ALU_FNCT_SLL,
             std_logic_vector(unsigned(a) srl to_integer(unsigned(b(4 downto 0)))) when ALU_FNCT_SRL,
             std_logic_vector(unsigned(a) sra to_integer(unsigned(b(4 downto 0)))) when ALU_FNCT_SRA,
             (0 => less_than, others => '0') when ALU_FNCT_SLT,
             (0 => less_than_unsigned, others => '0') when ALU_FNCT_SLTU,
             (others => '-') when others;
    less_than <= '1' when signed(a) < signed(b) else '0';
    less_than_unsigned <= '1' when unsigned(a) < unsigned(b) else '0';
end behavioral;