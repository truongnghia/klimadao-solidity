pragma solidity ^0.8.16;
import "forge-std/console.sol";
import "../AssertionHelper.sol";

import {KlimaRetirementAggregator} from "../../src/retirement_v1/KlimaRetirementAggregator.sol";

contract ToucanRetireCarbonTest is AssertionHelper {
    KlimaRetirementAggregator master;
    address c3Helper;

    address USDC = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
    address MCO2 = 0xAa7DbD1598251f856C12f63557A4C4397c253Cea;
    address KLIMA = 0x4e78011Ce80ee02d2c3e649Fb657E45898257815;
    address SKLIMA = 0xb0C22d8D350C67420f06F48936654f567C73E8C8;
    address WSKLIMA = 0x6f370dba99E32A3cAD959b341120DB3C9E280bA6;
    address NCT = 0xD838290e877E0188a4A44700463419ED96c16107;
    address BCT = 0x2F800Db0fdb5223b3C3f354886d907A671414A7F;
    address UBO = 0x2B3eCb0991AF0498ECE9135bcD04013d7993110c;
    address NBO = 0x6BCa3B77C1909Ce1a4Ba1A20d1103bDe8d222E48;
    address TRIDENT = 0xc5017BE80b4446988e8686168396289a9A62668E;
    address BENTO = 0x0319000133d3AdA02600f0875d2cf03D442C3367;
    address TOUCANREGISTRY = 0x263fA1c180889b3a3f46330F32a4a23287E99FC9;

    address BCT_PROJECT = 0x35B73A62Dd351030eCBd4252135e59bbb6345a60;
    address NCT_PROJECT = 0x7B6C20Ab3AeD15f8c695978282dc0a30093bEc97;

    function setUp() public {
        address masterAddress = vm.envAddress("RETIREMENT_V1_ADDRESS");
        master = KlimaRetirementAggregator(masterAddress);
        c3Helper = master.bridgeHelper(2);
    }

    /** ===== BCT Retirements ===== */

    function testRetireUboDefaultWithUsdc() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(USDC, UBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(USDC, address(master));
        assertZeroTokenBalance(USDC, c3Helper);

        assertZeroTokenBalance(UBO, address(master));
        assertZeroTokenBalance(UBO, c3Helper);
    }

    function testRetireUboDefaultWithUbo() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(UBO, UBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(UBO, address(master));
        assertZeroTokenBalance(UBO, c3Helper);
    }

    function testRetireUboDefaultWithKlima() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(KLIMA, UBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(KLIMA, address(master));
        assertZeroTokenBalance(KLIMA, c3Helper);

        assertZeroTokenBalance(UBO, address(master));
        assertZeroTokenBalance(UBO, c3Helper);
    }

    function testRetireUboDefaultWithSklima() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(SKLIMA, UBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(SKLIMA, address(master));
        assertZeroTokenBalance(SKLIMA, c3Helper);
        assertZeroTokenBalance(KLIMA, address(master));
        assertZeroTokenBalance(KLIMA, c3Helper);

        assertZeroTokenBalance(UBO, address(master));
        assertZeroTokenBalance(UBO, c3Helper);
    }

    function testRetireUboDefaultWithWsklima() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(WSKLIMA, UBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(WSKLIMA, address(master));
        assertZeroTokenBalance(WSKLIMA, c3Helper);
        assertZeroTokenBalance(SKLIMA, address(master));
        assertZeroTokenBalance(SKLIMA, c3Helper);
        assertZeroTokenBalance(KLIMA, address(master));
        assertZeroTokenBalance(KLIMA, c3Helper);

        assertZeroTokenBalance(UBO, address(master));
        assertZeroTokenBalance(UBO, c3Helper);
    }

    /** ===== NCT Retirements ===== */

    function testRetireNboDefaultWithUsdc() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(USDC, NBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(USDC, address(master));
        assertZeroTokenBalance(USDC, c3Helper);

        assertZeroTokenBalance(NBO, address(master));
        assertZeroTokenBalance(NBO, c3Helper);
    }

    function testRetireNboDefaultWithNbo() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(NBO, NBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(NBO, address(master));
        assertZeroTokenBalance(NBO, c3Helper);
    }

    function testRetireNboDefaultWithKlima() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(KLIMA, NBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(KLIMA, address(master));
        assertZeroTokenBalance(KLIMA, c3Helper);

        assertZeroTokenBalance(NBO, address(master));
        assertZeroTokenBalance(NBO, c3Helper);
    }

    function testRetireNboDefaultWithSklima() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(SKLIMA, NBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(SKLIMA, address(master));
        assertZeroTokenBalance(SKLIMA, c3Helper);
        assertZeroTokenBalance(KLIMA, address(master));
        assertZeroTokenBalance(KLIMA, c3Helper);

        assertZeroTokenBalance(NBO, address(master));
        assertZeroTokenBalance(NBO, c3Helper);
    }

    function testRetireNboDefaultWithWsklima() public {
        vm.prank(0x375C1DC69F05Ff526498C8aCa48805EeC52861d5);
        master.retireCarbon(WSKLIMA, NBO, 1e17, true, 0x375C1DC69F05Ff526498C8aCa48805EeC52861d5, "test", "test");

        assertZeroTokenBalance(WSKLIMA, address(master));
        assertZeroTokenBalance(WSKLIMA, c3Helper);
        assertZeroTokenBalance(SKLIMA, address(master));
        assertZeroTokenBalance(SKLIMA, c3Helper);
        assertZeroTokenBalance(KLIMA, address(master));
        assertZeroTokenBalance(KLIMA, c3Helper);

        assertZeroTokenBalance(NBO, address(master));
        assertZeroTokenBalance(NBO, c3Helper);
    }
}
