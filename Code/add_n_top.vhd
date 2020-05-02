library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity add_n_top is 
generic (
	constant SIZE : integer := 64;		
	constant DWIDTH : integer := 32;
	constant AWIDTH : integer := 6;
	constant NUM_BLOCKS : integer := 4
);
port (
	signal clock : in std_logic;
	signal reset : in std_logic;
	signal start : in std_logic;
	signal done : out std_logic;
	signal x_wr_addr: in std_logic_vector(5 downto 0);
	signal x_wr_en: in std_logic_vector(3 downto 0);
	signal x_din: in std_logic_vector(31 downto 0);
	signal y_wr_addr: in std_logic_vector(5 downto 0);
	signal y_wr_en: in std_logic_vector(3 downto 0);
	signal y_din: in std_logic_vector(31 downto 0);
	signal z_rd_addr: in std_logic_vector(5 downto 0);
	signal z_dout: out std_logic_vector(31 downto 0));
end entity add_n_top; 

architecture behavior of add_n_top is 
	component add_n
	port(
		signal clock : in std_logic;
		signal reset : in std_logic;
		signal start : in std_logic;
		signal done : out std_logic;
		signal x_dout: in std_logic_vector(31 downto 0);
		signal x_addr: out std_logic_vector(5 downto 0);
		signal y_dout: in std_logic_vector(31 downto 0);
		signal y_addr: out std_logic_vector(5 downto 0);
		signal z_din: out std_logic_vector(31 downto 0);
		signal z_addr: out std_logic_vector(5 downto 0);
		signal z_wr_en: out std_logic_vector(3 downto 0));
	end component;
	
	component bram_block is 
	generic (
		constant SIZE : integer := 1024;
		constant DWIDTH : integer := 32;
		constant AWIDTH : integer := 10 );
	port (
		signal clock : in std_logic;
		signal rd_addr: in std_logic_vector((AWIDTH -1) downto 0);
		signal wr_addr: in std_logic_vector((AWIDTH -1) downto 0);
		signal wr_en: in std_logic_vector(((DWIDTH / 8) -1) downto 0);
		signal dout : out std_logic_vector((DWIDTH -1) downto 0);
		signal din : in std_logic_vector((DWIDTH -1) downto 0) );
	end component;
	
	signal x_dout : std_logic_vector(31 downto 0);
	signal x_rd_addr: std_logic_vector(5 downto 0);
	signal y_dout: std_logic_vector(31 downto 0);
	signal y_rd_addr: std_logic_vector(5 downto 0);
	signal z_din: std_logic_vector(31 downto 0);
	signal z_wr_addr: std_logic_vector(5 downto 0);
	signal z_wr_en: std_logic_vector(3 downto 0);
--	constant SIZE : integer := 1024;
--	constant DWIDTH : integer := 32;
--	constant AWIDTH : integer := 10;
	
	begin 
		add_n_inst: component add_n
		port map(
			clock => clock,
			reset => reset,
			start => start,
			done => done,
			x_dout => x_dout,
			x_addr => x_rd_addr,
			y_dout => y_dout,
			y_addr => y_rd_addr,
			z_din => z_din,
			z_addr => z_wr_addr,
			z_wr_en => z_wr_en);

		x_inst: component bram_block
		generic map(
			SIZE => SIZE,
			DWIDTH => DWIDTH,
			AWIDTH => AWIDTH)
		port map(
			clock => clock,
			rd_addr => x_rd_addr,
			wr_addr => x_wr_addr,
			wr_en => x_wr_en,
			dout => x_dout,
			din => x_din);
			
		y_inst: component bram_block
		generic map(
			SIZE => SIZE,
			DWIDTH => DWIDTH,
			AWIDTH => AWIDTH)
		port map(
			clock => clock,
			rd_addr => y_rd_addr,
			wr_addr => y_wr_addr,
			wr_en => y_wr_en,
			dout => y_dout,
			din => y_din);
			
		z_inst: component bram_block
		generic map(
			SIZE => SIZE,
			DWIDTH => DWIDTH,
			AWIDTH => AWIDTH)
		port map(
			clock => clock,
			rd_addr=> z_rd_addr,
			wr_addr=> z_wr_addr,
			wr_en=> z_wr_en,
			dout => z_dout,
			din => z_din);
			
end architecture behavior;