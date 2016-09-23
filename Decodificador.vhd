library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Decodificador is
    Port ( clk : in  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           seg : out  STD_LOGIC_VECTOR (6 downto 0));
end Decodificador;

architecture Behavioral of Decodificador is

constant preset : std_logic_vector(17 downto 0) := "101111101011110000";
--preset = "101111101011110000" = 195312 (Clock de 100MHz)
constant increase : std_logic_vector(23 downto 0):= "100110001001011010000000"; 
--increase = "101111101011110000" = 10.000.000 (Clock de 100MHz)
signal count : std_logic_vector(17 downto 0):= (others=>'0');
signal count2 : std_logic_vector(23 downto 0):= (others=>'0');
signal control : std_logic_vector(1 downto 0):= "00";
signal dig1  : std_logic_vector (3 downto 0) := "0000";
signal dig2  : std_logic_vector (3 downto 0) := "0000";
signal dig3  : std_logic_vector (3 downto 0) := "0000";
signal dig4  : std_logic_vector (3 downto 0) := "0000";
signal deco  : std_logic_vector (3 downto 0) := "0000";
signal anodos: std_logic_vector (3 downto 0) := "1111";


begin	
	process(clk) begin
		if rising_edge(clk) then
			if count = preset then
                count <= (others=>'0');
                control <= control+"01";
            end if;
			
			if count2 = increase then
				count2 <= (others=>'0');
				
				if dig4 = "1111" then
				    dig1 <= "0000";
				    dig2 <= "0000";
				    dig3 <= "0000";
				    dig4 <= "0000";
				elsif dig1 = "1111" and dig2 = "1111" and dig3 = "1111" then
                    dig1 <= "0000";
                    dig2 <= "0000";
                    dig3 <= "0000";
                    dig4 <= dig4+'1';
                elsif dig1 = "1111" and dig2 = "1111" then
                    dig1 <= "0000";
                    dig2 <= "0000";
                    dig3 <= dig3+'1';
                elsif dig1 = "1111" then
                    dig1 <= "0000";
                    dig2 <= dig2+'1';
                else
                    dig1 <= dig1+'1';
                end if; 				                 
			else
				count <= count+'1'; 
			end if;
		end if;
	end process;
	
	with control select
		anodos <= "1110" when "00",
			      "1101" when "01",
		          "1011" when "10",
	              "0111" when others;
		
	with control select
		deco <= dig1 when "00",
		        dig2 when "01",
		        dig3 when "10",
		        dig4 when "11", 
				"0000" when others;
	
	process(deco)
	begin
		case deco is
			when "0000" => seg <= "1000000"; --0
            when "0001" => seg <= "1111001"; --1
            when "0010" => seg <= "0100100"; --2
            when "0011" => seg <= "0110000"; --3
            when "0100" => seg <= "0011001"; --4
            when "0101" => seg <= "0010010"; --5
            when "0110" => seg <= "0000010"; --6
            when "0111" => seg <= "1111000"; --7
            when "1000" => seg <= "0000000"; --8
            when "1001" => seg <= "0011000"; --9
            when "1010" => seg <= "0001000"; --a
            when "1011" => seg <= "0000011"; --b
            when "1100" => seg <= "1000110"; --c
            when "1101" => seg <= "0100001"; --d
            when "1110" => seg <= "0000110"; --e
            when others => seg <= "0001110"; --f
		end case;
	end process;
	
	an <= anodos;	
	
end Behavioral;
