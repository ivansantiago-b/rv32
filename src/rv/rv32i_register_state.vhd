--! @file rv32i_register_state.vhd
--! @author Iván Santiago (ivansantiago-b)
--! @date 19/03/2025 - 20:44
--! @brief RISC-V 32-bit base integer ISA register state implementation
--! using two asynchronous read ports and one synchronous write port

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.rv32i_constants.all;

entity rv32i_register_state is
    port(
        clk, we : in std_logic;
        rd_addr, rs1_addr, rs2_addr : in std_logic_vector(ADDR_LENGTH - 1 downto 0);
        rd_in : in std_logic_vector(XLEN - 1 downto 0);
        rs1, rs2 : out std_logic_vector(XLEN - 1 downto 0)
    );
end rv32i_register_state;

architecture behavioral of rv32i_register_state is
    type register_file is array(1 to REGISTER_COUNT) of std_logic_vector(XLEN - 1 downto 0);
    signal data : register_file;
    signal s1_addr, s2_addr, d_addr : integer range 1 to REGISTER_COUNT;
    --! Register zero X0 = 0
    constant X0 : std_logic_vector(XLEN - 1 downto 0) := (others => '0');
    --! Address zero
    constant X0_ADDR : integer := 0;
begin
WRITE_REGISTER:
    process(clk, we, d_addr)
    begin
        if rising_edge(clk) and we = ACTIVE_LEVEL and d_addr > 0 then
            data(d_addr) <= rd_in;
        end if;
    end process WRITE_REGISTER;
    d_addr <= to_integer(unsigned(rd_addr));
    s1_addr <= to_integer(unsigned(rs1_addr));
    s2_addr <= to_integer(unsigned(rs2_addr));
    rs1 <= X0 when s1_addr = X0_ADDR else data(s1_addr);
    rs2 <= X0 when s2_addr = X0_ADDR else data(s2_addr);
end behavioral;