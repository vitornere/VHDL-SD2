----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.09.2016 09:22:15
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           rfLoad : out STD_LOGIC;
           rfAdress : out STD_LOGIC_VECTOR (3 downto 0);
           rfData : out STD_LOGIC_VECTOR (31 downto 0));
end fsm;

architecture Behavioral of fsm is

    component controle is
        Port ( rst : in STD_LOGIC;
               index_lt_15 : in STD_LOGIC;
               rfLoad : out STD_LOGIC;
               index_ld : out STD_LOGIC;
               index_cl : out STD_LOGIC;
               rfAdress_ld : out STD_LOGIC;
               rfData_ld : out STD_LOGIC);
    end component;
    
    component operacional is
        Port ( index_ld : in STD_LOGIC;
               index_clr : in STD_LOGIC;
               rfAdress_ld : in STD_LOGIC;
               rfData_ld : in STD_LOGIC;
               index_lt_15 : out STD_LOGIC;
               rfAdress : out STD_LOGIC_VECTOR (3 downto 0);
               rfData : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    signal index_ld_wire, index_clr_wire, rfAdress_ld_wire, rfData_ld_wire, index_lt_15_wire : std_logic;
    signal rfAdress_wire : std_logic_vector (3 downto 0);
    signal rfData_wire :std_logic_vector (31 downto 0);
    
begin

controle1: controle port map(rst, index_lt_15_wire, rfLoad, index_ld_wire, index_clr_wire, rfAdress_ld_wire, rfData_ld_wire);
operacional1: operacional port map(index_ld_wire, index_clr_wire, rfAdress_ld_wire, rfData_ld_wire, index_lt_15_wire, rfAdress_wire, rfData_wire); 

end Behavioral;
