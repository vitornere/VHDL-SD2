----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.09.2016 08:07:34
-- Design Name: 
-- Module Name: test_lab1 - Behavioral
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

entity test_lab1 is
--  Port ( );
end test_lab1;

architecture Behavioral of test_lab1 is

    component detector_sequencia is
    Port ( A : in STD_LOGIC;
           clk : in STD_LOGIC;
           Z : out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
    end component;

    signal a_wire, clk_wire, Z_wire : std_logic := '0';
    signal an_wire : std_logic_vector (3 downto 0) := "0000";
    signal seg_wire : std_logic_vector (6 downto 0) := "1000000";
begin

    detector1: detector_sequencia port map(A=>a_wire, clk=>clk_wire, Z=>Z_wire, an=>an_wire, seg=>seg_wire);

    clk_wire <= not clk_wire after 10ns;

    process begin
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
        a_wire <= '1';
        wait for 20ns;
        a_wire <= '0';
        wait for 20ns;
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
    end process;

end Behavioral;
