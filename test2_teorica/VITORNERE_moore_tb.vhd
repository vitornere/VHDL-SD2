----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.08.2016 17:18:13
-- Design Name: 
-- Module Name: test_state_machine - Behavioral
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

entity test_state_machine is
--  Port ( );
end test_state_machine;

architecture Behavioral of test_state_machine is

    component state_machine is
        Port ( clk : in STD_LOGIC;
               A : in STD_LOGIC;
               S : out STD_LOGIC);
    end component;        

    signal clk_wire, a_wire, s_wire : std_logic := '0';
begin

    state_machine1: state_machine port map(clk => clk_wire, A => a_wire, S => s_wire); 

    clk_wire <= not clk_wire after 10ns;
    
    process begin
        a_wire <= '0';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
    end process;
end Behavioral;
