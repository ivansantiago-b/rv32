--! @file rv32i_constants.vhd
--! @author Iván Santiago (ivansantiago-b)
--! @date 19/03/2025 - 20:46
--! @brief 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package rv32i_constants is
    --! All registers are 32-bit wide
    constant XLEN : integer := 32;
    --! There are 31 general purpose registers and the X0 register
    constant REGISTER_COUNT : integer := 31;
    --! There are required 5 bits to addressing all the 31 registers
    constant ADDR_LENGTH : integer := 5;
    --! Level to indicate and active signal
    constant ACTIVE_LEVEL : std_logic := '0';
    --! ALU function length
    constant ALU_FNCT_LENGTH : integer := 4;
    --! ALU addition function
    constant ALU_FNCT_ADD : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0000";
    --! ALU subtraction function
    constant ALU_FNCT_SUB : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "1000";
    --! ALU bitwise xor function
    constant ALU_FNCT_XOR : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0100";
    --! ALU bitwise or function
    constant ALU_FNCT_OR : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0110";
    --! ALU bitwise and function
    constant ALU_FNCT_AND : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0111";
    --! ALU shift left logical function
    constant ALU_FNCT_SLL : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0001";
    --! ALU shift right logical function
    constant ALU_FNCT_SRL : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0101";
    --! ALU shift right arith function
    constant ALU_FNCT_SRA : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "1101";
    --! ALU set less than function
    constant ALU_FNCT_SLT : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0010";
    --! ALU unsigned set less than function
    constant ALU_FNCT_SLTU : std_logic_vector(ALU_FNCT_LENGTH - 1 downto 0) := "0011";
    --! R-Type opcode
    constant R_TYPE : std_logic_vector(6 downto 0) := "0110011";
    --! I-Type opcode
    constant I_TYPE : std_logic_vector(6 downto 0) := "0010011";
end package rv32i_constants;