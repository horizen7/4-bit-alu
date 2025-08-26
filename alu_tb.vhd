<<<<<<< HEAD
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
        
        -- step 1
        opA <= "0001"; opB <= "0001"; wait for 20 ns;

        -- step 2
        opA <= "1111"; opB <= "1110"; wait for 20 ns;

        -- step 3
        mode <= '1';
        opA <= "0011"; opB <= "0001"; wait for 20 ns;

        -- step 4
        opA <= "0111"; opB <= "0001"; wait for 20 ns;

    end process;
=======
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
        
        -- step 1
        opA <= "0001"; opB <= "0001"; wait for 20 ns;

        -- step 2
        opA <= "1111"; opB <= "1110"; wait for 20 ns;

        -- step 3
        mode <= '1';
        opA <= "0011"; opB <= "0001"; wait for 20 ns;

        -- step 4
        opA <= "0111"; opB <= "0001"; wait for 20 ns;

    end process;
>>>>>>> a5cb29f (hi)
end test;