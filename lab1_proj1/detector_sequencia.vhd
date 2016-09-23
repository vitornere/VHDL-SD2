----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.09.2016 19:11:50
-- Design Name: 
-- Module Name: detector_sequencia - Behavioral
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

entity detector_sequencia is
    Port ( A : in STD_LOGIC;
           clk : in STD_LOGIC;
           Z : out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0));
       
end detector_sequencia;

architecture Behavioral of detector_sequencia is

    type state is (init, ea, eb, ec, ed);
    signal current_state, next_state : state := init;
    signal z_wire, clk2 : std_logic := '0';
    signal seg_wire, seg_wire2 : std_logic_vector (6 downto 0) := "1000000";
    constant preset : std_logic_vector(17 downto 0) := "101111101011110000";
    --preset = "101111101011110000" = 195312 (Clock de 100MHz)
    constant increase : std_logic_vector(27 downto 0):= "1110111001101011001010000000"; 
    --increase = "101111101011110000" = 10.000.000 (Clock de 100MHz)
    signal count : std_logic_vector(17 downto 0) := (others=>'0');
    signal count2 : std_logic_vector(27 downto 0) := (others=>'0');
    signal control : std_logic_vector(1 downto 0) := "00";
    signal anodos : std_logic_vector(3 downto 0) := "1110";

begin

    increase1: process(clk) begin
        if rising_edge(clk) then
            if count2 = increase then 
                count2 <= (others => '0');
                clk2 <= '1';
            else
                count2 <= count2+'1';
                clk2 <= '0';
            end if;
        end if;
    end process;

    estado_atual: process(clk2) begin
        if rising_edge(clk2) then
            current_state <= next_state;
        else
        end if;
    end process;
    
    proximo_estdo: process(clk2) begin
        case current_state is
            when init =>
                z_wire <= '0';
                seg_wire <= "1000000"; -- 0
                
                if A = '1' then
                    next_state <= ea;
                else
                    next_state <= init;
                end if;
            when ea =>
                z_wire <= '0';
                seg_wire <= "0001000"; -- a
                
                if A = '1' then
                    next_state <= eb;
                else
                    next_state <= init;
                end if;
            when eb =>
                z_wire <= '0';
                seg_wire <= "0000011"; -- b
                
                if A = '0' then
                    next_state <= ec;
                else
                    next_state <= eb;
                end if;
            when ec =>
                z_wire <= '0';
                seg_wire <= "1000110"; -- c
                
                if A = '1' then
                    next_state <= ed;
                else
                    next_state <= init;
                end if;
            when ed =>
                z_wire <= '1';
                seg_wire <= "0100001"; -- d
                
                if A = '1' then
                    next_state <= ea;
                else
                    next_state <= init;
                end if;
        end case;
    end process;
    
    process(clk) begin
        if rising_edge(clk) then
            if count = preset then
                count <= (others=>'0');
                
                if control = "00" then
                    control <= control+"01";
                else
                    control <= "00";
                end if;
            else
                count <= count+'1';
            end if;
        end if;
    end process;
    
    with control select
        anodos <= "1110" when "00",
                  "1101" when others;
    
    display: process(clk) begin
        if anodos = "1110" then
            seg_wire2 <= seg_wire; -- numero estado
        else    
            seg_wire2 <= "0000110"; -- e
        end if;
    end process;
    
Z <= z_wire;
seg <= seg_wire2;
an <= anodos;
end Behavioral;
