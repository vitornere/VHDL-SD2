----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2016 09:20:15
-- Design Name: 
-- Module Name: controle - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controle is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           index_lt_15 : in STD_LOGIC;
           rfLoad : out STD_LOGIC;
           index_ld : out STD_LOGIC;
           index_cl : out STD_LOGIC;
           rfAdress_ld : out STD_LOGIC;
           rfData_ld : out STD_LOGIC);
end controle;

architecture Behavioral of controle is

    type state is (init, clear, next_clear);
    signal rfLoad_wire, index_ld_wire, rfAdress_ld_wire, rfData_ld_wire : std_logic := '0';
    signal index_cl_wire : std_logic := '1';
    signal current_state, next_state : state := init;

begin

    proximo_estado: process(clk) begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;     

    regra_estados: process(clk, rst) begin
        case current_state is
            when init =>
                index_cl_wire <= '1';
                index_ld_wire <= '1';
                rfAdress_ld_wire <= '0';
                rfLoad_wire <= '0';
                rfData_ld_wire <= '0';
                
                if rst = '1' then
                    next_state <= clear;
                else
                    next_state <= init;
                end if;
            when clear =>
                rfAdress_ld_wire <= '1';
                rfLoad_wire <= '1';
                rfData_ld_wire <= '1';
                
                if index_lt_15 = '1' then
                    next_state <= next_clear;
                else
                    next_state <= init;
                end if;
            when next_clear =>
                index_ld_wire <= '1';
                next_state <= clear;
        end case;
    end process;
    
index_ld <= index_ld_wire;
index_cl <= index_cl_wire;
rfLoad <= rfLoad_wire;
rfAdress_ld <= rfAdress_ld_wire;
rfData_ld <= rfData_ld_wire;

end Behavioral;
