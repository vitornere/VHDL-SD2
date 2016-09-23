----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2016 09:20:15
-- Design Name: 
-- Module Name: operacional - Behavioral
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operacional is
    Port ( index_ld : in STD_LOGIC;
           index_clr : in STD_LOGIC;
           rfAdress_ld : in STD_LOGIC;
           rfData_ld : in STD_LOGIC;
           index_lt_15 : out STD_LOGIC;
           rfAdress : out STD_LOGIC_VECTOR (3 downto 0);
           rfData : out STD_LOGIC_VECTOR (31 downto 0));
end operacional;

architecture Behavioral of operacional is

    signal index : std_logic_vector(3 downto 0) := "0000";
    signal rfData_wire : std_logic_vector(31 downto 0) := (others => '0');
    signal index_lt_15_wire : std_logic := '0';

begin

    registrador: process(index_clr, index_ld, rfAdress_ld, rfData_ld) begin
        if index_clr = '1' then
            index <= "0000";
        elsif index_ld = '1' then
            index <= index+"0001";
        end if;
        
        if index = "1111" then
            index_lt_15_wire <= '0';
        else
            index_lt_15_wire <= '1';
        end if;
    end process;
    
rfAdress <= index;
rfData <= rfData_wire;
index_lt_15 <= index_lt_15_wire;
end Behavioral;
