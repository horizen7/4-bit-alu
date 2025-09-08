library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture test of alu_tb is
    signal opA, opB, opCode : std_logic_vector(3 downto 0) := "0000";
    signal output : std_logic_vector(3 downto 0);
    signal mode : std_logic := '0'; -- '0' = unsigned | '1' = signed
    signal less_than, great_than, equal : std_logic;
    signal N, Z, C, V : std_logic;

    component alu
        Port (
                opA, opB, opCode : in std_logic_vector(3 downto 0);
                output : out std_logic_vector(3 downto 0);
                mode : in std_logic;
                less_than, great_than, equal : out std_logic;
                N, Z, C, V : out std_logic
        );
    end component;

begin
    uut : alu port map (
        opA => opA,
        opB => opB,
        opCode => opCode,
        output => output,
        mode => mode,
        less_than => less_than,
        great_than => great_than,
        equal => equal,
        N => N,
        Z => Z,
        C => C,
        V => V
    );

    process
    begin

        -- setting to ADD
        opCode <= "0000";

        
        --    1) Add unsigned values, no carry
        --    2) Add unsigned, carry
        --    3) Signed no overflow
        --    4) Signed with overflow
        --    5) Testing zero flag
        --    6) Testing negative flag
        --    7) Test overflow with neg
        
        -- step 1
        opA <= "0001"; opB <= "0001"; wait for 20 ns;
        -- output = 0010 | N = 0 | Z = 0 | C = 0 | V = 0

        -- step 2
        opA <= "1111"; opB <= "1110"; wait for 20 ns;
         -- output = 1101 | N = 0 | Z = 0 | C = 1 | V = 0

        -- step 3
        mode <= '1';
        opA <= "0011"; opB <= "0001"; wait for 20 ns;
         -- output = 0100 | N = 0 | Z = 0 | C = 0 | V = 0

        -- step 4
        opA <= "0111"; opB <= "0001"; wait for 20 ns;
         -- output = 1000 | N = 1 | Z = 0 | C = 0 | V = 1

        -- step 5
        mode <= '0';
        opA <= "0000"; opB <= "0000"; wait for 20 ns;
         -- output = 0000 | N = 0 | Z = 1 | C = 0 | V = 0
        mode <= '1';
        opA <= "0000"; opB <= "0000"; wait for 20 ns;
         -- output = 0000 | N = 0 | Z = 1 | C = 0 | V = 0

        -- step 6
        opA <= "1000"; opB <= "0001"; wait for 20 ns;
         -- output = 1001 | N = 1 | Z = 0 | C = 0 | V = 0

        -- step 7
        opA <= "0111"; opB <= "0110"; wait for 20 ns;
         -- output = 1101 | N = 1 | Z = 0 | C = 0 | V = 1


        -- setting to SUB, unsigned
        opCode <= "0001";
        mode <= '0';

        --  1) subtract unsigned values, no flags
        --  2) subtract unsigned values, Z flag
        --  3) subtract unsigned, C flag
        --  4) subtract signed, no flags
        --  5) signed Z
        --  6) signed N
        --  7) signed V

        -- step 1
        opA <= "1000"; opB <= "0010"; wait for 20 ns;
        -- output = 0110 | N = 0 | Z = 0 | C = 1 | v = 0

        -- step 2
        opA <= "0110"; opB <= "0110"; wait for 20 ns;
        -- output = 0000 | N = 0 | Z = 1 | C = 1 | V = 0

        -- step 3
        opA <= "0001"; opB <= "0010"; wait for 20 ns;
        -- output = 1111 | N = 0 | Z = 0 | C = 0 | V = 0

        -- step 4
        mode <= '1';
        opA <= "0100"; opB <= "0001"; wait for 20 ns;
        -- output = 0011 | N = 0 | Z = 0 | C = 1 | V = 0

        -- step 5
        opA <= "0100"; opB <= "0100"; wait for 20 ns;
        -- output = 0000 | N = 0 | Z = 1 | C = 1 | V = 0

        -- step 6
        opA <= "0100"; opB <= "0110"; wait for 20 ns;
        -- output = 1110 | N = 1 | Z = 0 | C = ? | V = 0

        -- step 7
        opA <= "0111"; opB <= "1000"; wait for 20 ns;
        -- output = 1111 | N = 1 | Z = 0 | C = ? | V = 1

    end process;
end test;