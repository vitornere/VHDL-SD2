----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.08.2016 16:15:00
-- Design Name: 
-- Module Name: state_machine - Behavioral
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

entity state_machine is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC;
           S : out STD_LOGIC);
end state_machine;

architecture Behavioral of state_machine is

type state is (e0, e1, e2, e3);
    signal current_state, next_state : state := e0;
    signal s_wire : std_logic;

begin

    estado_atual: process(clk) begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    proximo_estado: process(clk, A, current_state) begin
        case current_state is
            when e0 =>
                s_wire <= '0';
                if A = '1' then
                    next_state <= e1;
                else
                    next_state <= e0;
                end if;
            when e1 =>
                s_wire <= '0';
                if A = '1' then
                    next_state <= e2;
                else
                    next_state <= e0;
                end if;
            when e2 =>
                s_wire <= '0';                
                if A = '1' then
                    next_state <= e2;
                else
                    next_state <= e3;
                end if;
            when e3 =>
                s_wire <= '1';
                if A = '1' then
                    next_state <= e1;
                else
                    next_state <= e0;
                end if;
        end case;
    end process;         

S <= s_wire;

end Behavioral;
