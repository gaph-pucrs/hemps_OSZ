library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;

package ni_pkg is
    
    constant TAM_WORD   : integer := TAM_FLIT*2;
    subtype regword is std_logic_vector(TAM_WORD-1 downto 0);

    constant FIXED_HEADER_SIZE      : integer := 2;
    constant DYNAMIC_HEADER_SIZE    : integer := 22;
    constant HEADER_SIZE            : integer := FIXED_HEADER_SIZE*2 + DYNAMIC_HEADER_SIZE;

    constant TABLE_SIZE             : integer := 4;
    constant MAX_FLITS_PER_PKT      : integer := 255;

    constant FIFO_SIZE              : integer := 32;

    constant APPID_SIZE             : integer := 10;
    constant KEYPERIPH_SIZE         : integer := APPID_SIZE;
    constant BSIZE_SIZE             : integer := 6;
    constant MAX_PATH_FLITS         : integer := 6;    

    subtype regN_appID      is std_logic_vector(APPID_SIZE-1 downto 0);
    subtype regN_keyPeriph  is std_logic_vector(KEYPERIPH_SIZE-1 downto 0);
    subtype regN_burstSize  is std_logic_vector(BSIZE_SIZE-1 downto 0);
    type    regN_path       is array(MAX_PATH_FLITS-1 downto 0) of regflit;
    subtype intN_pathSize   is integer range 0 to MAX_PATH_FLITS;
    subtype intN_pathIndex  is integer range 0 to MAX_PATH_FLITS-1;
    
    constant SERVICE_FLIT                       : integer := 6;
    constant END_OF_HEADER_FLIT                 : integer := 25;
    
    constant CONFIG_PERIPH_SERVICE              : regword := x"02000010";
    constant CONFIG_PERIPH_SERVICE_APPID_FLIT   : integer := 9;
    constant CONFIG_PERIPH_SERVICE_KEYP_FLIT    : integer := 11;

    constant SET_PATH_SERVICE                   : regword := x"FEDC1234";
    constant SET_PATH_SERVICE_APPID_FLIT        : integer := 9;

    constant REQUEST_PERIPH_SERVICE             : regword := x"45542323";
    constant REQUEST_PERIPH_SERVICE_APPID_FLIT  : integer := 9;
    constant REQUEST_PERIPH_SERVICE_BSIZE_FLIT  : integer := 19;

    constant IO_WRITE_SERVICE                   : regword := x"09902020";
    
    --------------------------------
    -- TABLE READ-WRITE INTERFACE --
    --------------------------------

    type TableInput is record

        -- ctrl

        request         : std_logic;
        crypto          : std_logic;
        newLine         : std_logic;
        tag             : regN_appID;
        clearSlot       : std_logic;

        -- rw

        appId_w         : regN_appID;
        appId_wen       : std_logic;

        key1_w          : regN_keyPeriph;
        key1_wen        : std_logic;

        key2_w          : regN_keyPeriph;
        key2_wen        : std_logic;

        burstSize_w     : regN_burstSize;
        burstSize_wen   : std_logic;

        pathSize_w      : intN_pathSize;
        pathSize_wen    : std_logic;

        pathFlit_w      : regflit;
        pathFlit_wen    : std_logic;
        pathFlit_idx    : intN_pathIndex;

    end record;

    type TableOutput is record

        -- ctrl

        ready           : std_logic;
        fail            : std_logic;
        full            : std_logic;

        -- rw

        appId           : regN_appID;
        key1            : regN_keyPeriph;
        key2            : regN_keyPeriph;
        burstSize       : regN_burstSize;
        pathSize        : intN_pathSize;
        pathFlit        : regflit;
    
    end record;
    
    -------------------------------
    -- TABLE READ-ONLY INTERFACE --
    -------------------------------

    type TableSecondaryInput is record
        tag             : regN_appID;        
        pathFlit_idx    : intN_pathIndex;
    end record;

    type TableSecondaryOutput is record
        ready           : std_logic;
        appId           : regN_appID;
        key1            : regN_keyPeriph;
        key2            : regN_keyPeriph;
        burstSize       : regN_burstSize;
        pathSize        : intN_pathSize;
        pathFlit        : regflit;
    end record;

    --------------------------------
    -- RESPONSE REQUEST INTERFACE --
    --------------------------------

    type TransmissionModeType is (THROUGH_HERMES, THROUGH_BRNOC);

    type ResponseParametersType is record
        txMode          : TransmissionModeType;
        appId           : regN_appID;
        hermesService   : regword;
        brnocService    : seek_bitN_service;
    end record;

    type TransmissionStatusType is record
        busy            : std_logic;
        accepted        : std_logic;
        rejected        : std_logic;
    end record;

    ---------------------------
    -- FIFO BUFFER INTERFACE --
    ---------------------------

    type BufferStatusType is record
        empty           : std_logic;
        full            : std_logic;
        err             : std_logic;
    end record;
    
end package ni_pkg;
